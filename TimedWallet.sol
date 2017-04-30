contract TimedWallet(){

address public owner;
uint public wait; //the time needed to unlock
uint public request; //the moment of the request
address panicAddress; //a secondary panic address in case of problems
uint public amount; //the amount to withdraw at the requested time

function TimedWallet(address o,address safe,uint interval){
owner=o;
panicAddress=safe;
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

//change owner
function manager(address o)returns(bool){
if(msg.sender!=owner)throw;
owner=o;
return true;
}

//destroy box
function kill(){
if (msg.sender != owner)throw;
selfdestruct(owner);
}

}
