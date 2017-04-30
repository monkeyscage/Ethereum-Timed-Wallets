contract TimedWallet(){

address public owner;   //it is decided at contract creation, can't be changed
uint public wait;       //the blocks needed to withdraw, decided at contract creation, can't be changed
address panicAddress;   //a secondary panic address in case of problems, can't be changed
uint public request;    //the moment of the request (block number)
uint public amount;     //the amount to withdraw after request+wait blocks

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
