pragma solidity ^0.8.0;

interface ERC20{
    event Transfer(address _from, address _to, uint256 _value);
    event Approval(address _from, address _to, uint256 _value);
     
    function totalSupply() external view returns(uint256);
    function balanceOf(address _owner) external view returns(uint256);
    function transfer(address _to,uint256 _value) external returns(bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns(bool);
    function approve(address _spender, uint256 _value) external returns(bool);
    function allowance(address _owner, address _spender) external view returns(uint256);
}

contract StandardToken is ERC20 {

    //mapping은 정보를 저장하는 장소이다

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    function totalSupply() override external view returns(uint256) {
        return balances[_owner];
    }

    //작동을 많이 하면서 깨달았는데 owner는 metamask의 작동되는 서버? 개념이고
    //_to나 _from에 공개키를 집어 넣는 것은 가나슈에서 하는 블록체인적 개념이다

    function transfer(address _to, uint256 _value) override external returns(bool){
        if(balances[msg.sender] >= _value && _value > 0){
            balances[msg.sender] -= value;
            balances[_to] += _value;
            emit Transfer(msg.sender,_to,_value);
            return true;
        } else {
            return false;
        }
    }

    function transferFrom((address _from, address _to, uint256 value), _to, _value);


}

//내가 가진 단위의 토큰
contract IngToken is StandardToken{

    string public name;
    uint8 public decimals;
    string public symbol;
    string public version;
    uint256 public uintsOneEthCanBuy;
    uint256 public totalEthInWei;
    address public fundWallet;

    constructor() payable public{
        name = "IngToken";
        decimals = 18;
        symbol = "ING";
        uintsOntEthCanBuy = 100;
        fundWallet = msg.sender;
        //컴파일시에 최초 등록 계쫘
    }
}