/* not gonna lie, totally swiped this, still getting an expected pragma error, 
and we'd need to change the " Generate random id between 1 - 5000 (corresponds to NFT id)"
part to be dynamic to the amount of entrants per Raise, also:

https://ethereum.stackexchange.com/questions/119869/correct-way-of-randomly-selecting-token-ids-from-already-minted-nfts

From notes on Site above:
"I think the the line (seed - ((seed / maxSupply) * maxSupply)) + 1 will always give 1 as the output, 
as maxSupply cancels out and then seed cancels out. If you want a number below maxSupply or totalSupply, 
you could do modulus on it. It'll look like return seed%totalSupply."

"Oh I see. Thank you so much for your explanation. So you're saying that all I need to do to product 
random number between 1 and 500 is place a modulus operator right after the seed? 
So: "return seed % totalSupply""
*/



pragma solidity ^0.5.0;

function selectWinners(uint256 noOfWinners) public onlyOwner {
    require(!paused, "ERROR: Contract is paused");
    require(lotteryActive, "ERROR: Lottery not active yet");
    require(noOfWinners <= 50, "ERROR: Too many winners selected");

    uint256 epochNow = block.timestamp;
    uint256 nextLotteryDate = lotteryDates[lotteryDates.length - 1];

    require(epochNow >= nextLotteryDate, "ERROR: Cannot draw yet, too early");

    for (uint256 i = 0; i < noOfWinners; i++) {
        selectAWinner(
            0,
            epochNow,
            msg.sender,
            nextLotteryDate,
            msg.sender,
            0
        );
    }

    lotteryDates.push(epochNow + (epochDay * lotteryIntervalDays));

    // increment draw
    drawNumber++;
}


function selectAWinner(
    uint256 it,
    uint256 epochNow,
    address sender,
    uint256 lotteryDate,
    address randomAddr,
    uint256 randomNo
) internal {
    // Generate random id between 1 - 5000 (corresponds to NFT id)

    uint256 winningToken = rand(randomAddr, randomNo);
    address winnerAddress = ERC721.ownerOf(winningToken);
    uint256 lastWon = _winners[winnerAddress];

    bool alreadyWon = (lastWon == lotteryDate);

    Winner memory win;

    if ((it < 5) && alreadyWon) {
        uint256 newIt = it + 1;
        return
            selectAWinner(
                newIt,
                epochNow,
                sender,
                lotteryDate,
                winnerAddress,
                winningToken
            );
    } else if ((it >= 5) && alreadyWon) {
        return;
    } else {
        win.date = lotteryDate;
        win.winner = winnerAddress;
        win.tokenId = winningToken;
        winnerLog[drawNumber].push(win);

        _winners[winnerAddress] = lotteryDate;
    }

    return;
}

function rand(address randomAddress, uint256 randomNo) internal view returns (uint256) {
    uint256 seed = uint256(
        keccak256(
            abi.encodePacked(
                (block.timestamp - randomNo) +
                    block.difficulty +
                    ((
                        uint256(keccak256(abi.encodePacked(block.coinbase)))
                    ) / (block.timestamp)) +
                    block.gaslimit +
                    ((uint256(keccak256(abi.encodePacked(randomAddress)))) /
                        (block.timestamp)) +
                    block.number
            )
        )
    );

    return (seed - ((seed / maxSupply) * maxSupply)) + 1;
}