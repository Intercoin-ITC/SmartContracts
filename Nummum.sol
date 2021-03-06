pragma solidity 0.5.8;
import"./Intelligentes.sol";
contract Intercoin is SmartToken{string private _name;string private _symbol;uint8 private _decimals;constructor()public{_name="Intercoin";_symbol="ITC";_decimals=6;mint(msg.sender,888888888e6);}
function name()public view returns(string memory){return _name;}
function symbol()public view returns(string memory){return _symbol;}
function decimals()public view returns(uint8){return _decimals;}
event Freeze(address indexed from,address indexed to,uint256 value);event Melt(address indexed from,address indexed to,uint256 value);
function freeze(address to,uint256 value)public onlyOwner stoppable returns(bool){_freeze(msg.sender,to,value);return true;}
function _freeze(address _from,address to,uint256 value)private{Frozen[to]=Frozen[to].add(value);_transfer(_from,to,value);emit Freeze(_from,to,value);}
function melt(address to,uint256 value)public onlyOwner stoppable returns(bool){_melt(msg.sender,to,value);return true;}
function _melt(address _onBehalfOf,address to,uint256 value)private{require(Frozen[to]>=value);Frozen[to]=Frozen[to].sub(value);emit Melt(_onBehalfOf,to,value);}
function transferAnyTRC20(address _tokenAddress,address _to,uint256 _amount)public onlyOwner{ITRC20(_tokenAddress).transfer(_to,_amount);}
function transferTRC10Token(address toAddress,uint256 tokenValue,trcToken id)public onlyOwner{address(uint160(toAddress)).transferToken(tokenValue,id);}
function withdrawTRX()public onlyOwner returns(bool){msg.sender.transfer(address(this).balance);return true;}}