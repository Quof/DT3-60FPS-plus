//Post message
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  bChecked=1
  global.recSignsRead+=1
  with oMessageSign {instance_destroy()}
  var tNewMessage,tXoffset,tYoffset;
  if signSize=0
  {
    tXoffset=70
    tYoffset=80
  }
  else if signSize=1
  {
    tXoffset=100
    tYoffset=93
  }
  else if signSize=2
  {
    tXoffset=130
    tYoffset=106
  }
  else if signSize=3
  {
    tXoffset=160
    tYoffset=119
  }
  tNewMessage=instance_create(x-tXoffset,y-tYoffset,oMessageSign)
  tNewMessage.message=stringToShow
  tNewMessage.fadingTime=65+(signSize*15)
  tNewMessage.signSize=signSize
}
