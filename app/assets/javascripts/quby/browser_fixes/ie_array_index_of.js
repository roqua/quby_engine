//IE7 indexOf fix
if(!Array.indexOf){
    Array.prototype.indexOf = function(obj){
        for(var i=0; i < this.length; i++){
            if(this[i]==obj){
                return i;
            }
        }
    }
}
