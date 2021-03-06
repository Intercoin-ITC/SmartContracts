pragma solidity 0.5.8;
import"./Silentum.sol";
import"./Cogitare.sol";contract TRC20Basic{uint public totalSupply;
function balanceOf(address who)public view returns(uint256);
function transfer(address to,uint256 value)public returns(bool);event Transfer(address indexed from,address indexed to,uint256 value);}
contract BasicToken is TRC20Basic,Pauseable{using SafeMath for uint256;mapping(address=>uint256)internal Frozen;mapping(address=>uint256)internal _balances;
function transfer(address to,uint256 value)public stoppable validRecipient(to)returns(bool){_transfer(msg.sender,to,value);return true;}
function _transfer(address from,address to,uint256 value)internal{require(from!=address(0));require(value>0);require(_balances[from].sub(Frozen[from])>=value);_balances[from]=_balances[from].sub(value);_balances[to]=_balances[to].add(value);emit Transfer(from,to,value);}
function balanceOf(address _owner)public view returns(uint256){return _balances[_owner];}
function availableBalance(address _owner)public view returns(uint256){return _balances[_owner].sub(Frozen[_owner]);}
function frozenOf(address _owner)public view returns(uint256){return Frozen[_owner];}
modifier validRecipient(address _recipient){require(_recipient!=address(0)&&_recipient!=address(this));_;}}