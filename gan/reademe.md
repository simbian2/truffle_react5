# 기본 세팅

-ganashe
-metamask
-truffle init
-truffle-config.js

# 작업순서

1. 환경설정
2. 코드작성
3. 가나슈 배포 

# 오픈제펠린

- 블록체인 불변성
    컨트랙트를 수정 할 수 있게 도와주는 라이브러리.
    proxy contract logic contract
- 수수료
    이더리움 개념
    gas station network
    사용자가 트랜잭션을 발생시켜도 ETH 소비가 안 된다.
    배포자가 냅니다.

# My Ether Wallet (MEW)
ㅡ metamask와 같은 직바,
- https://www.myetherwallet.com/wallet/
- https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.7+commit.e28d00a7.js


npm init
npm install openzeppelin-solidity

./node_modules/openzeppeling-solidity/contracts/token/ERC20/...

44줄 
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },

    로 수정

84줄     
    version: "0.8.1", 
    로 수정

truffle create contract IngToken
truffle create migration IngToken


contract address
0x2a1f7ef67eEA3CD43EeD14da8526E3CaAcB8E62E

ABI
"abi": [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [],
      "name": "decimals",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "name",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "symbol",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "totalSupply",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    }
  ],

EOA address/account
0x355595a29aE3bb28a7D24Da4818E49738990c0F2



contract

0xd60144eF90339F0E3b5A48CF06AAb56758d8e570

//다시 컴파일 시에는 json 다 지우기/


# testnet에 배포하기

https://infura.io/dashboard/ethereum/540c2ca6a6c5499d957f04df2b95f894/settings

여기서 두번째 서버로 수정한후
/

truffle-config.js
22-24줄 주석 처리 해제
60-67줄 주석 처리 해제
61줄 uri를 infura에서 가져온 주소로 치환.

설정>보안 및 개인 정보> 거기서 시드 문구 
bicycle copy useful avoid index case magnet tool vocal green fork action

truffle compile -all
truffle migrate --network ropsten

https://ropsten.etherscan.io/address/0x355595a29aE3bb28a7D24Da4818E49738990c0F2
여기서 hash 값이나 주소 쳐서 보기