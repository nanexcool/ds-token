/*
   Copyright 2017 Nexus Development, LLC

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

import 'ds-guard/guard.sol';

import './token.sol';

contract TokenFactory {
    function createToken() returns (DSToken) {
        DSGuard guard = new DSGuard();
        DSToken token = new DSToken("Test Token", "TST", 18);
        token.setAuthority(guard);
        return token;
    }
}