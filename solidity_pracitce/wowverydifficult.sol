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
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    function totalSupply() override external view returns(uint256){}
    
    function balanceOf(address _owner) override external view returns(uint256) {
        return balances[_owner];
    }
    
    function transfer(address _to,uint256 _value) override external returns(bool) {
        if(balances[msg.sender] >= _value && _value > 0){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender,_to,_value);
            return true;
        } else {
            return false;
        }
    }
    
    //from은 해당 서버이고 to는 보내고 싶은 addresss
    function transferFrom(address _from, address _to, uint256 _value) override external returns(bool) {
        if(balances[_from] >= _value && _value > 0){
            balances[_from] -= _value;
            balances[_to] += _value;
            allowed[_from][_to] -= _value;
            emit Transfer(_from,_to,_value);
            return true;
        } else {
            return false;
        }
    }
    
    //해당 서버=에서 보낼 수 있는 키값에 = 한정 용량
    function approve(address _spender, uint256 _value) override external returns(bool){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender,_value);
        return true;
    }
    
    //용량 확인
    function allowance(address _owner, address _spender) override external view returns(uint256){
        return allowed[_owner][_spender];
    }
}

contract IngToken is StandardToken {
    
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
        uintsOneEthCanBuy = 100;
        fundWallet = msg.sender;
        //여기서의 msg.sender는 계좌일 것이다. 그리고 계좌와 가나슈의 계정의 키는 다르다. 주소.
        //msg.sender는 특정 값을 나타내는 상수가 아니라 많은 상수들을 받아오는 통로값이다. '이 코드'를 실행하는 사람의 주소를 의미
        //msg.sender가 영희가 될 수도 있고 철수가 될 수도 있는 것이다.

        balances[msg.sender] = 100000000000000000000;
    }
    
    fallback() external payable {
        totalEthInWei = totalEthInWei + msg.value;
        uint256 amount = msg.value * uintsOneEthCanBuy;
        require(balances[fundWallet] >= amount);
        balances[fundWallet] -= amount;
        balances[msg.sender] += amount;
        
        emit Transfer(fundWallet, msg.sender, amount);
        payable(fundWallet).transfer(msg.value);
    }
    
    function approveAndCall(address _spender, uint256 _value, bytes memory _extraData) public returns(bool){
       allowed[msg.sender][_spender] = _value;
       emit Approval(msg.sender, _spender, _value);
       
       
       //when the call function is running, the Object/tuffle is result value.
       
       (bool success, bytes memory data) = _spender.call(abi.encodeWithSignature("receiveApproval(address,uint256,address,bytes)",msg.sender,_value,address(this),_extraData));
        require(success, "call failed");
        return true;
        
    
    }
}