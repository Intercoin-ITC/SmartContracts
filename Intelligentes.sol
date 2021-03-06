pragma solidity 0.5.8;
import"./Normalen.sol";
contract ITRC677 is ITRC20{
function transferAndCall(address receiver,uint value,bytes memory data)public returns(bool success);event Transfer(address indexed from,address indexed to,uint256 value,bytes data);}
contract TRC677Receiver{
function onTokenTransfer(address _sender,uint _value,bytes memory _data)public;}
contract SmartToken is ITRC677,StandardToken{
function transferAndCall(address _to,uint256 _value,bytes memory _data)public validRecipient(_to)returns(bool success){_transfer(msg.sender,_to,_value);emit Transfer(msg.sender,_to,_value,_data);if(isContract(_to)){contractFallback(_to,_value,_data);}
return true;}
function contractFallback(address _to,uint _value,bytes memory _data)private{TRC677Receiver receiver=TRC677Receiver(_to);receiver.onTokenTransfer(msg.sender,_value,_data);}
function isContract(address _addr)private view returns(bool hasCode){uint length;assembly{length:=extcodesize(_addr)}
return length>0;}}