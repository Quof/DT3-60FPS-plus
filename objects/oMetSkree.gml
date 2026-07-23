#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,1,8,26)
image_speed=0
if global.currentMusic=503
{
  baseColor=make_color_rgb(255,160,160)
  image_blend=baseColor
}
else if global.currentMusic=504
{
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor
}

//Enemy base statistics
eName="Skree"
eLevel=23
maxLife=80
life=maxLife
pointWorth=30
atkPower=7
resType[0]=2
resType[1]=2
resType[4]=4
baseItemChance=70
baseDropIndex=90
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4

diving=0

jeremyText="This waits on the ceiling until you're under it, then comes crashing down after you. The speed they come down after you is dependent on the difference in your y coordinates. They can also dive toward you along x depending on various circumstances."
chaoText="These were in all the Metroid games except Fusion, though they are in that game's code. In Metroid Prime, they were named 'Shriekbats'."
devText="In the original game, these have an animation while they wait on the ceiling. For this, I wanted them completely still to hide them more from the player."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=106
{
  baseColor=make_color_rgb(30,200,255)
  image_blend=baseColor
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0
  {
    if diving=0 //Wait for player
    {
      if point_distance(x,0,oPlayer1.x,0)<=28
      {
        if !collision_line(x,y+(sprite_height/2),oPlayer1.x,oPlayer1.y-26,oSolid,1,1) {image_index=1; diving=1}
      }
    }
    else if diving>=1 and diving<=9 //Ready to dive
    {
      diving+=1
      if diving>=5
      {
        playSound(global.snd_MetEnemyMove,0,1,1)
        sprite_index=sMetSkreeDive
        image_speed=0.33
        y+=2
        var tDist;
        tDist=point_distance(0,y,0,oPlayer1.y-26)
        tDist/=16
        if tDist<7 {tDist=7} else if tDist>12 {tDist=12}
        yVel=tDist

        if x>oPlayer1.x //Right side of player
        {
          if oPlayer1.xVel>=5 {xVel=2}
          else if oPlayer1.xVel<=0 {xVel=-2}
        }
        else if x<oPlayer1.x //Left side of player
        {
          if oPlayer1.xVel<=-5 {xVel=-2}
          else if oPlayer1.xVel>=0 {xVel=2}
        }
        diving=10
      }
    }
    else if diving=10 //Dive down
    {
      if yVel<16 {yVel+=0.2}
      if isCollisionBottom(1) {yGround=y+sprite_height; yVel=0; diving=20}
      if isCollisionLeft(1) {xVel=1}
      if isCollisionRight(1) {xVel=-1}

      moveTo(xVel,yVel)
      if y>room_height+24 {instance_destroy()}
    }
    else if diving>=20 //Go into ground
    {
      y+=1
      diving+=1

      if diving mod 2=0
      {
        var tEffect;
        tEffect=instance_create(x+random_range(-4,4),yGround,oEffectGrav)
        tEffect.sprite_index=sSkreeRock; tEffect.image_speed=0.6+random(0.1); tEffect.type=2; tEffect.fadeSpd=0.05; tEffect.rotation=0
        tEffect.grav=0.25; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-2-random(2)
      }

      if diving>=50 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
