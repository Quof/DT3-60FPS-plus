#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Launch Penguin"
eLevel=33
maxLife=90
life=maxLife
pointWorth=60
atkPower=16
stunResist=50
baseItemChance=90
moneyWorth=10
bCheckDir=0
angleChange=0
launchTime=0

jeremyText="This poor guy is just launched from a cannon. Only one can be fired off per cannon. When it is destroyed in any way, there's quite a large explosion, so watch out there."
chaoText="These penguins are adorable. Even this one being launched out of a cannon."
devText="This is one of the more humorous and goofy enemies in the game, to me at least."
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Bobomb,0,0.98,1)
newAttack=instance_create(x,y,oDamageExplosion)
newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
newAttack.image_xscale=2; newAttack.image_yscale=2; newAttack.decayTime=-100
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true
  {
    if bCheckDir=0
    {
      if image_angle<90 {angleChange=-1.5}
      else {angleChange=1.5}
      bCheckDir=1
    }
    else
    {
      launchTime+=1
      image_angle+=angleChange
      direction=image_angle
      speed=7
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x,y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=random(1)+1; tEffect.friction=random(0.0125)+0.0125; tEffect.image_speed=0.2
        tEffect.fadeSpd=0.05; tEffect.image_blend=make_color_rgb(choose(0,255),choose(0,255),choose(0,255))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        tEffect.direction=image_angle-180
      }
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if launchTime>=5 {instance_destroy()}
