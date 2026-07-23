//Breaks up string blocks into portions convertable into different variables.
//string_breakup(base_string,seperator) Ex: string_breakup("a|b|c|","|")

base_string=argument0;
seperator=argument1;
var numbers;
numbers=string_count(seperator,base_string);
for(i=0;i<numbers;i+=1)
{
  pos=string_pos(seperator,base_string);
  var_string[i]=string_copy(base_string,1,pos-1);
  base_string=string_delete(base_string,1,pos);
}
