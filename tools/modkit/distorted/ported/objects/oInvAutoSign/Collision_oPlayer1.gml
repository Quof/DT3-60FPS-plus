//Post message
if global.gamePaused=false and cooldown=0
{
  cooldown=60
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
  /*if room=rREXb     //spsp
  {
    tXoffset=-160
    tYoffset=-64
  }*/
  //spsp ns fix
  if y-tYoffset<16 {tYoffset=y-16}
  tNewMessage=instance_create(x-tXoffset,y-tYoffset,oMessageSign)
  tNewMessage.message=stringToShow
  tNewMessage.fadingTime=65+(signSize*15)
  tNewMessage.signSize=signSize
}
