// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract kittyRewards is ERC20, ERC20Burnable, Ownable {
    mapping(address => bool) controllers;

    constructor() ERC20("Pupil Dialators", "PUPL") { }

    function mint(address _to, uint _amount) external {
        require(controllers[msg.sender], "Only controllers can mint");
        _mint(_to, _amount);
    }

    function burnFrom(address _account, uint _amount) public override {
        if (controllers[msg.sender]) {
            _burn(_account, _amount);
        } else {
            super.burnFrom(_account, _amount);
        }
    }

    function addController(address controller) external onlyOwner {
        controllers[controller] = true;
    }

    function removeController(address controller) external onlyOwner {
        controllers[controller] = false;
    }
}