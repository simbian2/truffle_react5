// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import '../node_modules/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol';
import '../node_modules/openzeppelin-solidity/contracts/access/Ownable.sol';
import '../node_modules/openzeppelin-solidity/contracts/security/Pausable.sol';

contract IngToken is ERC20,Ownable,Pausable{
  
  string public _name = "INGOO TOKEN";
  string public _symbol = "ING";
  uint256 public _totalSupply = 10000 * (10**uint256(decimals())); 
  string text = "hello wolrd!";

  constructor() ERC20("INGOO TOKEN","ING") {
    _mint(msg.sender,_totalSupply);
  }

  function pause() public onlyOwner{
    _pause();
  }

  function unpause() public onlyOwner{
   _unpause();  
  }
}