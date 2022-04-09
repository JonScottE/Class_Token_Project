pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";

contract FUNdrop is ERC721Full {
    constructor() public ERC721Full("FUNdropToken", "DROP") {}

    struct FUNdraiser{
        string donor;
        string cause;
        address donor_wallet;
        uint256 donation_amount;
    }

    mapping(uint256 => Donation_Receipt) public FUNdraiser_mapping;

    event Donation(uint256 tokenId, uint256 donation_amount, string reportURI);

    function CreateFundraiser(
        address owner,
        string memory cause,
        uint256 donation_uint,
        string memory tokenURI
    ) public returns (uint256) {
        uint256 tokenId = totalSupply();

        _mint(owner, tokenId);
        _setTokenURI(tokenId, tokenURI);

        FUNdraiser[tokenId] = Donation_Receipt(donor, cause, wallet, donation_amount);

        return tokenId;
    }
/*
    function newAppraisal(
        uint256 tokenId,
        uint256 newAppraisalValue,
        string memory reportURI
    ) public returns (uint256) {
        artCollection[tokenId].appraisalValue = newAppraisalValue;

        emit Appraisal(tokenId, newAppraisalValue, reportURI);

        return artCollection[tokenId].appraisalValue;
    }
    */
}
