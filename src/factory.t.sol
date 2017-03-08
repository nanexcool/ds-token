/*
   Copyright 2016 Nexus Development, LLC

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

pragma solidity ^0.4.8;

import "ds-test/test.sol";

import './factory.sol';

contract TokenUser {
    DSToken  token;

    function TokenUser(DSToken token_) {
        token = token_;
    }

    function doTransferFrom(address from, address to, uint amount)
        returns (bool)
    {
        return token.transferFrom(from, to, amount);
    }

    function doTransfer(address to, uint amount)
        returns (bool)
    {
        return token.transfer(to, amount);
    }

    function doApprove(address recipient, uint amount)
        returns (bool)
    {
        return token.approve(recipient, amount);
    }

    function doAllowance(address owner, address spender)
        constant returns (uint)
    {
        return token.allowance(owner, spender);
    }

    function doBalanceOf(address who) constant returns (uint) {
        return token.balanceOf(who);
    }

    function doMint(uint amount) {
        token.mint(amount);
    }

    function doBurn(uint amount) {
        token.burn(amount);
    }
}

contract DSTokenFactoryTest is DSTest {
    
    function testFactory() {
        log_named_address("this", this);
        log_bytes32("Will set guard");
        DSGuard guard = new DSGuard();
        log_named_address("guard", guard);
        log_bytes32("Will create token");
        DSToken token = new DSToken("Test Token", "TST", 18);
        log_named_address("token", token);
        log_bytes32("Will set authority");
        token.setAuthority(guard);
        log_named_address("guard", token.authority());
        //guard.allow(this, token, guard.ANY);
        //guard.allow(bytes32(this), bytes32(token), bytes32(uint(-1)), true);
        guard.allow(this, token, "mint(uint256)");
        guard.allow(this, token, "burn(uint256)");
        token.mint(1);
        token.burn(1);
        assertEq(token.totalSupply(), 0);

        TokenUser user = new TokenUser(token);
        guard.allow(guard.ANY(), bytes32(address(token)), guard.ANY(), true);
        guard.allow(bytes32(address(token)), guard.ANY(), guard.ANY(), true);
        guard.allow(user, token, guard.ANY(), true);
        guard.allow(guard.ANY(), token, guard.ANY(), true);
        user.doMint(1);
        user.doBurn(1);
        assertEq(token.totalSupply(), 0);

        assert(false);
    }
}