#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<maxResetObj;i+=1)
{
  myOX[i]=myObj[i].xstart
  myOY[i]=myObj[i].ystart
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  var tFlash;
  tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
  for(i=0;i<maxResetObj;i+=1)
  {
    if !instance_exists(myObj[i])
    {
      myObj[i]=instance_create(myOX[i],myOY[i],oPushRock)
      myObj[i].sprite_index=sG6_EarthBlock
    }
    myObj[i].x=myOX[i]
    myObj[i].y=myOY[i]
  }

  /*if room=rBT_ZeroD
  {
    with oBreakRock {instance_destroy()}
    for(i=0;i<5;i+=1)
    {
      instance_create(1472+(i*64),400,oBreakRock)
    }
  }*/
}
