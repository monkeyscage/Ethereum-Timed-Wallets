cintract TimedWallet(){
address public owner;

function TimedWallet(address o){
owner=o;
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
