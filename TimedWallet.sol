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
amount=0;
}

function RequestWithdraw(uint tot){
if(msg.sender!=owner)throw;
request=block.number;
amount=tot;
}

function Withdraw(address a){
if(amount==0)throw;
if(msg.sender!=owner)throw;
if(block.number<request+wait)throw;
if(!send(a,amount))throw;
amount=0;
}

function status()constant returns(uint,amount){
uint countdown=0; //blocks countdown to withdraw
if(block.number<request+wait)countdown=request+wait-blocknumber;
return(countdown,amount);
}

function panic(){
if(msg.sender!=owner)throw;
if(!send(panicAddress,this.balance))throw;
}

}
