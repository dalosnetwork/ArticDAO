// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract SocialSBT {
    uint256 internal _sbtID;
    mapping(address => uint256) internal SBTID;
    mapping(address => bool) internal isSBTOwner;
    mapping(address => uint256) internal decisionSBTPoint;

    event SBTMinted(address _wallet, uint256 _id);
    event decisionPointIncreased(address _wallet, uint256 _increasePoint);
    event decisionPointDecreased(address _wallet, uint256 _decreasePoint);

    function decreaseDecisionPoint(address _wallet, uint256 _decreasePoint) public returns (bool) {
        require(isSBTOwner[_wallet]);

        decisionSBTPoint[_wallet] -= _decreasePoint;

        emit decisionPointDecreased(_wallet, _decreasePoint);

        return true;
    }

    function increaseDecisionPoint(address _wallet, uint256 _increasePoint) public returns (bool) {
        require(isSBTOwner[_wallet]);

        decisionSBTPoint[_wallet] += _increasePoint;

        emit decisionPointIncreased(_wallet, _increasePoint);

        return true;
    }

    function mint() public returns (bool) {
        require(!isSBTOwner[msg.sender]);

        isSBTOwner[msg.sender] = true;
        SBTID[msg.sender] = _sbtID;

        emit SBTMinted(msg.sender, _sbtID);

        _sbtID += 1;

        return true;
    }

    function getID(address _wallet) public view returns (uint256) {
        return SBTID[_wallet];
    }

    function isOwner(address _wallet) public view returns (bool) {
        return isSBTOwner[_wallet];
    }

    function decisionPoint(address _wallet) public view returns (uint256) {
        return decisionSBTPoint[_wallet];
    }
}
