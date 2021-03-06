pragma solidity 0.5.8;
import"./Dominium.sol";
contract Pauseable is Ownable{event Stopped(address _owner);event Started(address _owner);bool private stopped;constructor()internal{stopped=false;}
modifier stoppable{require(!stopped);_;}
function paused()public view returns(bool){return stopped;}
function halt()public onlyOwner{stopped=true;emit Stopped(msg.sender);}
function start()public onlyOwner{stopped=false;emit Started(msg.sender);}}