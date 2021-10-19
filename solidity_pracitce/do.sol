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
        //here it is msg.sender mean metamask checked account not address 
        if(balances[msg.sender] >= _value && _value > 0){
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            emit Transfer(msg.sender,_to,_value);
            return true;
        } else {
            return false;
        }
    }
    
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
    
    function approve(address _spender, uint256 _value) override external returns(bool){
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender,_value);
        return true;
    }
    
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
        //fundWallet = 0x1bB6C4791C45C3519812c10FB6c4be487ad211c6;
        fundWallet = msg.sender;
        balances[msg.sender] = 10000000000000000000;
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
       //you must contract address
       (bool success, bytes memory data) = _spender.call(abi.encodeWithSignature("receiveApproval(address,uint256,address,bytes)",msg.sender,_value,address(this),_extraData));
        require(success, "call failed");
        return true;
        
    
    }
}