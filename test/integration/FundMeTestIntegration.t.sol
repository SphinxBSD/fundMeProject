// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import { FundMe } from "../../src/FundMe.sol";
import { DeployFundMe } from "../../script/DeployFundMe.s.sol";
import {FundFundMe,WithdrawFundMe} from "../../script/Interaction.s.sol";

contract FundMeTestIntegration is Test {
    FundMe private fundMe;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant INITIAL_VALUE = 10 ether;
    uint256 constant GAS_PRICE = 1;

    address USER = makeAddr("user");
    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundMe = deploy.run();
        vm.deal(USER, INITIAL_VALUE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assertEq(address(fundMe).balance, 0);
    }
}