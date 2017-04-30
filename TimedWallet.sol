contract TimedWallet(){
address public owner;
uint public blocksInterval; //the time needed to unlock
uint public request; //the moment of the request
address safeAddress;
uint public amount;

function TimedWallet(address o,address safe){
owner=o;
safeAddress=safe;
}

function panic(){
if(msg.sender!=owner)throw;
if(!send(safeAddress,this.balance))throw;
kill();
}

function RequestWithdraw(uint tot){
if(msg.sender!=owner)throw;
request=block.number;
amount=tot;
}

function Withdraw(address a){
if(msg.sender!=owner)throw;
if(block.number<request+blocksInterval)throw;
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