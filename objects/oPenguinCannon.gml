#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bActive=1

//Enemy base statistics
eName="Penguin Cannon"
maxLife=1000000
life=maxLife
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
bLaunch=0
launchTime=0

jeremyText="It's just a cannon that fires off penguins for some reason. It can't deal any damage on its own and it can only fire off one penguin. After that, it's used by the Fire Penguin as a ball launcher."
chaoText="I really like the fun vibe of this place. All these guys are out to get you, but they just look so fun!#Hmm, it seems weird that it can't actually take damage, but it can still take 0 damage... Oooh, it's to block your shots."
devText="There were a few things in the CHAOS Facility of Ch.18 that I thought wouldn't play out well, such as the swinging grapple points, or even the Brain Machine boss fight. The swinging points went well, but the Brain Machine turned out to easily be my favorite boss fight of the chapter and one of my favorite in the game."
extraInfo="Completely immune to damage."

if global.gameProgress=4940 {instance_destroy()}
else {alarm[0]=1}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oPlayer1.x<x {image_xscale=-1}

myPenguin=instance_create(x+(7*image_xscale),y-23,oLaunchPenguin)
if image_xscale=1 {myPenguin.image_angle=45}
else {myPenguin.image_angle=135}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bLaunch=0
  {
    if launchTime=0 //If too much time has passed
    {
      if point_distance(x,y-10,oPlayer1.x,returnPlayerYCenter())<=188
      {
        launchTime=1
      }
    }
    else
    {
      launchTime+=1
      if launchTime>=75
      {
        myPenguin.bActive=1
        bLaunch=1
      }
    }

    if point_distance(x,y-10,oPlayer1.x,returnPlayerYCenter())<=140 //Launch
    {
      myPenguin.bActive=1
      bLaunch=1
    }
  }
  if bLaunch=1
  {
    playSound(global.snd_MarioCannon,0,1,1)
    var tEffect;
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x+(7*image_xscale),y-23,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
      tEffect.speed=random(0.75)+0.5; tEffect.image_speed=0.2; tEffect.direction=random(360)
      tEffect.fadeSpd=0.05; tEffect.image_blend=c_black
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
    bLaunch=2
  }
  enemyStepEvent()
}
