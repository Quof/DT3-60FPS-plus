progCheck=9000000

var instrCheck,i;
for(i=0;i<8;i+=1)
{
  instrCheck=string_char_at(global.eGateProg,i+1)
  if instrCheck="9" {instance_destroy()}
}
