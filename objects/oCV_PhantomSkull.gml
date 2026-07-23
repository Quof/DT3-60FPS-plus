#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Phantom Skull"
eLevel=14
maxLife=165
life=maxLife
pointWorth=14
atkPower=5
resType[2]=4
resType[3]=2
resType[4]=2
resType[5]=2
stunResist=2
baseItemChance=40
baseDropIndex=90
affiliation=3
dieEffect=0
inactiveDist*=2

currHspd=0
currVspd=0

deathAnim=0

jeremyText="It's a flying skull that tries to seek you out. I think it's kinda mimicing Chao's movement."
chaoText="These things are stealing my movement type! Take them all out Claire!"
devText="An interesting fact about the first game's release is I wasn't able to beat the Shroud Lord on Distorted. Everything else, including the Artist battle, I was able to do. It wasn't until roughly a year after its release that I got around to finally beating it on that setting. This is something I won't be doing ever again. If I can't complete it, it won't be released. That being said, the Distorted setting is like the unwanted step-child..."
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
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}

      myDist=player_sprite_center()
      myDist=round(myDist/32)
      if myDist>9 {myDist=9}
      else if myDist<3 {myDist=3}
      maxSpeed=myDist

      if x>oPlayer1.x
      {
        if currHspd>-maxSpeed {currHspd-=0.1}
        else {currHspd=-maxSpeed}
      }
      else if x<oPlayer1.x
      {
        if currHspd<maxSpeed {currHspd+=0.1}
        else {currHspd=maxSpeed}
      }
      if y>oPlayer1.y-26
      {
        if currVspd>-maxSpeed {currVspd-=0.1}
        else {currVspd=-maxSpeed}
      }
      else if y<oPlayer1.y-26
      {
        if currVspd<maxSpeed {currVspd+=0.1}
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
    }
    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
