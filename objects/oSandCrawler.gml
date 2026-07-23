#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(1,1,1,1)
image_speed=0.6
image_xscale=1.25
image_yscale=1.25
hoverAlpha=-1
bCanDealDamage=false
bCanTakeDamage=false
bShowHealthBar=false
bActive=1

//Enemy base statistics
eName="Sand Crawler"
if global.modeWahfuu=1 {eName="Wahfuu Jr."}
eLevel=10
maxLife=2500
life=maxLife
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=5

baseItemChance=90
biteTime=0

jeremyText="As long as you don't touch the sand, this thing won't detect you. It's best that you don't get caught because one bite and you're a goner. It seems invulnerable to everything you've got except bombs, but I doubt it'll help you much since it recovers when it goes back into the sand."
chaoText="This thing is from King of Monsters 2. It chased Claire through a desert when we were on that island. I wish we could do something to get rid of it."
devText="Oh yeah, he's back."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  biteTime+=1
  if biteTime=7
  {
    sprite_index=sSandCrawlerBite
    image_index=0
  }

  if sprite_index=sSandCrawlerBite
  {
    image_speed=0.3
    if image_index>=1.1 and image_index<=3.9 {bCanDealDamage=true; bCanTakeDamage=true}
    else {bCanDealDamage=false; bCanTakeDamage=false}
    if image_index>=5.5 {instance_destroy()}
  }
  else {image_speed=0.6}

  enemyStepEvent()
}
else {image_speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true {oneHitKill()}
