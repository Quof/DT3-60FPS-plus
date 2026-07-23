#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
eventProg=0
eventTime=0

if global.gameProgress>=4950 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if eventProg=1
  {
    if type<=1
    {
      playSound(global.snd_CShotB,0,0.95,1)
      var tNewAttack;
      tNewAttack=instance_create(x+(16*image_xscale),y+11,oPassBullet)
      tNewAttack.sprite_index=sJunkCarMissile; tNewAttack.atkPower=9; tNewAttack.bulletSpeed=12; tNewAttack.decayTime=6
      tNewAttack.direction=point_direction(x+(16*image_xscale),y+11,myKill.x,myKill.y-(myKill.sprite_height/2))
      eventProg=2
    }
    else {eventProg=3}
  }
  else if eventProg=2
  {
    eventTime+=1
    if eventTime=8
    {
      myKill.eventProg=1
    }
    else if eventTime>=15
    {
      if type=0
      {
        eventTime=0; eventProg=3
      }
      else if type=1
      {
        var tEnemy;
        tEnemy=instance_create(x,y,oCHAOS_Rocketeer); tEnemy.bActive=1; tEnemy.image_xscale=image_xscale
        instance_destroy()
      }
    }
  }
  else if eventProg=3
  {
    if x<oPlayer1.x {x+=2}
    else {x-=2}
    y-=6
    if y<=-8 {instance_destroy()}
  }
}
