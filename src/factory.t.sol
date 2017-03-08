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

contract DSTokenFactoryTest is DSTest {
    
    function testFactory() {
        log_named_address("this", this);
        log_bytes32("Will set guard");
        DSGuard guard = new DSGuard();
        log_named_address("guard", guard);
        log_bytes32("Will create token");
        DSToken token = new DSToken();
        log_named_address("token", token);
        log_bytes32("Will set authority");
        token.setAuthority(guard);
        log_named_address("guard", token.authority());
        guard.allow(bytes32(this), bytes32(token), bytes32(uint(-1)), true);
        token.mint(1);
        token.burn(1);
        assert(false);
    }
}