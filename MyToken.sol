pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is Ownable{
    using SafeMath for uint;
    
    string public constant name = "MyToken";
    string public constant symbol = "MFT";
    uint8 public constant decimal = 18;
    
    uint public totalSupply;
    mapping (address => uint) balances;
    
    mapping (address => mapping(address => uint)) allowed;
    
    event Transfer(address indexed _from, address indexed _to, uint value);
    event Approval(address indexed _from, address indexed _to, uint value); 
    
    function mint(address to, uint value) onlyOwner public{
        balances[to] = balances[to].add(value);
        totalSupply = totalSupply.add(value);
    }
    
    function balanceOF(address owner) public view returns(uint){
        return(balances[owner]);
    }
    
    function allowance(address _owner, address _spender) public view returns(uint){
        return(allowed[_owner][_spender]);
    }
    
    function transfer(address _to, uint value) public{
        require(balances[msg.sender] >= value);
        balances[msg.sender].sub(value);
        balances[_to] = balances[_to].add(value);
        emit Transfer(msg.sender, _to, value);
    }
    
    function transferFrom(address _from, address _to, uint value) public{
        require(balances[_from] >= value && allowed[_from][msg.sender] >= value);
        balances[_from] = balances[_from].sub(value);
        balances[_to] = balances[_to].add(value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(value);
        emit Transfer(_from, _to, value);
    }
    
    function approve(address _spender, uint _value) public {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }
    
    
}
