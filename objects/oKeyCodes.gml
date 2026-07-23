#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=1;i<=14;i+=1)
{
  kCode[i]=0
  kCodePressed[i]=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=1;i<=14;i+=1)
{
  if kCode[i]
  {
    kCode[i]=scrController(i)
    kCodePressed[i]=0
  }
  else
  {
    kCode[i]=scrController(i)
    if kCode[i]
      kCodePressed[i]=1
  }
}
