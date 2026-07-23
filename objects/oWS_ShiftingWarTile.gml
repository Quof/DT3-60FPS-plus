#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
x-=8; y-=8

//Enemy base statistics
eName="Shifting War Tile"
eLevel=38
maxLife=300
life=maxLife
pointWorth=30
atkPower=11
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
resType[4]=5
baseItemChance=10
affiliation=7
detectDistX=156
detectDistY=112

atkProg=0
atkTime=0

deathAnim=0

jeremyText="It's another hidden thing on the ship that's out to get intruders. These are simply like the Zelda tiles that come to life. They can be destroyed, but it's pretty hard to do so. Only EXPLOSIVE type damage is effective against them. The rest is piss poor damage."
chaoText="It's just a tile from the ship itself. Nothing really all that exciting sprite wise. If I happen to fly over one, I can reveal its location through that stat preview."
devText="For the most part, I wanted all the new enemies revealed on the Warship to be simple, where the rest of the more complicated enemies are previous CHAOS enemies from before, but with the new armor values after their upgrade. And with a few more instances of the support drones."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}

  if bActive=true and life>0
  {
    image_angle+=15
    atkTime+=1
    if atkProg=0 //Rise
    {
      y-=1
      if atkTime=32 {atkTime=0; atkProg+=1}
    }
    else if atkProg=1 //Wait
    {
      if atkTime=16
      {
        direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        atkTime=0; atkProg+=1
      }
    }
    else if atkProg=2 {speed=9}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      for(i=0;i<3;i+=1)
      {
        tEffect=instance_create(x+random_range(-7,7),y+random_range(-7,7),oEffect)
        tEffect.sprite_index=sEfFacLasTurExp; tEffect.image_speed=0.5; tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {speed=0}
