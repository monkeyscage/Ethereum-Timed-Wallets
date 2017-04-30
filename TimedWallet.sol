contract TimedWallet(){

address public owner;
uint public wait; //the time needed to unlock
uint public request; //the moment of the request
address panicAddress; //a secondary panic address in case of problems
uint public amount; //the amount to withdraw at the requested time

function TimedWallet(address own,address panic,uint interval){
owner=own;
panicAddress=panic;
wait=interval;
}

function panic(){
if(msg.sender!=owner)throw;
if(!send(panicAddress,this.balance))throw;
kill();
}

function RequestWithdraw(uint tot){
if(msg.sender!=owner)throw;
request=block.number;
amount=tot;
}

function Withdraw(address a){
if(msg.sender!=owner)throw;
if(block.number<request+wait)throw;
if(!send(a,amount))throw;
}

//destroy box
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}

}
