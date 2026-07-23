#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Fake Metroid"
eLevel=10
maxLife=35
life=maxLife
pointWorth=10
atkPower=5
stunResist=1
baseItemChance=20
baseDropIndex=50
dieEffect=0

currHspd=0
currVspd=0

deathAnim=0

jeremyText="The behavior for these is simple, but it can be annoying due to its high speed. It tries to track you, but it has momentum in its movement."
chaoText="This thing looks kinda like a Metroid... oh, whoops, maybe I should look at what the program labeled it as."
devText="This thing is in the game because I wanted an enemy that could swarm easy, but could also be destroyed easy."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      myDist=player_sprite_center()
      myDist=round(myDist/16)
      if myDist>12 {myDist=12}
      else if myDist<5 {myDist=5}
      maxSpeed=myDist

      if x>oPlayer1.x
      {
        if currHspd>-maxSpeed {currHspd-=0.2}
        else {currHspd=-maxSpeed}
      }
      else if x<oPlayer1.x
      {
        if currHspd<maxSpeed {currHspd+=0.2}
        else {currHspd=maxSpeed}
      }
      if y>oPlayer1.y-26
      {
        if currVspd>-maxSpeed {currVspd-=0.2}
        else {currVspd=-maxSpeed}
      }
      else if y<oPlayer1.y-26
      {
        if currVspd<maxSpeed {currVspd+=0.2}
        else {currVspd=maxSpeed}
      }
      hspeed=currHspd; vspeed=currVspd
    }
    else {hspeed=0; vspeed=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      image_speed=0
      hspeed=0; vspeed=0
      baseColor=c_red; image_blend=c_red
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33; tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEfCir=instance_create(x,y,oEfCircleBlast); tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=2; tEfCir.fadeSpeed=0.1
    }
    image_alpha-=0.1
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
