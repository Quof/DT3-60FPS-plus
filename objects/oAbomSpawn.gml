#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bShowHealthBar=false
bActive=1
image_speed=0.2

//Enemy base statistics
eName="Abomination Spawn"
if global.modeWahfuu=1 {eName="Wahfuu Spawn"}
eLevel=20
maxLife=190
life=maxLife
pointWorth=10
atkPower=7
stunResist=3
baseItemChance=70
baseDropIndex=45
affiliation=9
bIsBoss=true
dieEffect=0

currHspd=0
currVspd=0

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      if x>oPlayer1.x
        image_xscale=-1
      else
        image_xscale=1

      myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
      myDist=round(myDist/32)
      if myDist>6
        myDist=6
      else if myDist<4
        myDist=4
      maxSpeed=myDist

      if x>oPlayer1.x
      {
        if currHspd>-maxSpeed
          currHspd-=0.25
        else
          currHspd=-maxSpeed
      }
      else if x<oPlayer1.x
      {
        if currHspd<maxSpeed
          currHspd+=0.25
        else
          currHspd=maxSpeed
      }
      if y>oPlayer1.y-26
      {
        if currVspd>-maxSpeed
          currVspd-=0.25
        else
          currVspd=-maxSpeed
      }
      else if y<oPlayer1.y-26
      {
        if currVspd<maxSpeed
          currVspd+=0.25
        else
          currVspd=maxSpeed
      }
      hspeed=currHspd
      vspeed=currVspd
    }
    else
    {
      hspeed=0
      vspeed=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      image_speed=0
      hspeed=0
      vspeed=0
      baseColor=c_red; image_blend=c_red
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else
{
  hspeed=0
  vspeed=0
}
