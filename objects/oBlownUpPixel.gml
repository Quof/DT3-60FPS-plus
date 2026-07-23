#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(0,0,15,15)
myColor=make_color_rgb(24,72,72)
depth=30

//Enemy base statistics
eName="Blown Up Pixel"
eLevel=20
maxLife=290
life=maxLife
pointWorth=18
atkPower=7
stunResist=4
baseItemChance=60
dieSound=0
dieEffect=0
runAcc=2

shotTime=50
shotDelay=130

detectDistX=144
detectDistY=112
inactiveDist=10000

jeremyText="This tricky little guy likes to try and hide among the backdrop. It has no attacks, it only seeks out those that get close to it."
chaoText="The sprite isn't from anything, it's just a solid color that matches one of the background colors here."
devText="N/A"

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("type") {myColor=make_color_rgb(128,0,0)} //Red
else {myColor=make_color_rgb(24,72,72)} //Blue
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(1)
  if bActive=true and stunnedTime=0 and life>0
  {
    mDir=point_direction(x+8,y+8,oPlayer1.x,returnPlayerYCenter())
    moveTo((runAcc)*cos(degtorad(mDir)),-(runAcc)*sin(degtorad(mDir)))

    //---------- ATTACK: Shot ----------
    /*shotTime+=1
    if shotTime>=shotDelay
    {
      if shotTime>=shotDelay and shotTime<=shotDelay+29 //spin
      {
        image_angle-=20
      }
      else if shotTime=shotDelay+30 //Fire shot
      {
        var tNewAttack;
        tNewAttack=instance_create(x,y,oPassBullet)
        tNewAttack.sprite_index=sEBShot; tNewAttack.atkPower=atkPower
        tNewAttack.bulletSpeed=6; tNewAttack.decayTime=-100; tNewAttack.direction=mDir
        image_angle=0
        shotTime=0
      }
    }*/
  }
  else if life<=0
  {
    playSound(global.snd_BombExplode,0,0.9,1)
    tEffect=instance_create(x+8,y+8,oEffect)
    tEffect.sprite_index=sRobotExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_color(myColor)
draw_set_alpha(1)
draw_rectangle(x,y,x+15,y+15,0)
