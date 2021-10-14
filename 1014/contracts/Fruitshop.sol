// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
/*

1. 보낸 사람의 계저에서 사과를 총 몇 개 가지고 있는가?
2. 사과 구매시, 해당 계정에 사과를 리턴해주는 코드 작성
3. 사과를 판매시 내가 가지고 있는 사과*사과 구매 가격 만큼 토큰을 반환
4. 내 사과를 반환해주는 함수
 */
contract Fruitshop {
  mapping(address => uint) myApple;

  constructor() public {

  }

  function buyApple() payable public{
    myApple[msg.sender]++;
  }

  function getMyApple() public view returns (uint){
    return myApple[msg.sender];
  }

  function sellApple(uint _applePrice) payable public {
    uint totalPrice = (myApple[msg.sender] * _applePrice);
    myApple[msg.sender] = 0;
    msg.sender.transfer(totalPrice);
  }
}
