#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
//Enemy base statistics
eName="Peeping Eye"
eLevel=15
maxLife=380
life=maxLife
pointWorth=23
atkPower=5
resType[1]=2
resType[4]=4
resType[5]=2
stunResist=2
baseItemChance=65
moneyWorth=10
affiliation=3
dieEffect=0
inactiveDist*=1.5

hitFric=0.5
xSpd=0; ySpd=0
moveTime=35
moveDelay=35
moveSpd=2

shotTime=45
shotDelay=60
lightBullet=-1

deathAnim=0
tailDeath=4

jeremyText="The odd tracking they have on you makes them awkward to fight. Your Dagger isn't very effective against them, and keeping up your hair attack with their erratic movement can be tough. I'd recommend trying for the extra damage that the Holy Water flame gives you, well when you can."
chaoText="As someone who likes her privacy, the name of these things creeps me out. I mean really, who would name them that?!"
devText="For this game, I wanted to craft a very specific experience, and having multiple difficulty settings meant that I'd be designing each scenario more than once. While they are nice to have, I do feel they make things unfocused at times. Really, DT1 should only be played on the Normal setting. The game and everything in it are balanced and set up specifically for that. In later versions, I made the enemy stats closer to Normal."

segDir=0
stepCount=pi/2
for(i=0;i<5;i+=1)
{
  eyePart[i]=instance_create(x,y+19+i*12,oCV_PeepEyePart)
  eyePart[i].depth=26+i
  eyePart[i].ownerID=id
}
eyeTail=instance_create(x,y+13+i*12,oCV_PeepEyePart)
eyeTail.sprite_index=sCV_PeepingEyeTailEnd
eyeTail.ownerID=id
eyeTail.depth=26+i
lightBullet=0

alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<5;i+=1)
{
  with eyePart[i]
    instance_destroy()
}
with eyeTail
  instance_destroy()
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=1; myShadow.maxShadowDist=192
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
  if bActive=true and stunnedTime=0 and life>0
  {
    //----- Eye Movement -----
    //Circle
    x+=sin(stepCount)
    y+=cos(stepCount)
    //The rest
    speed=moveSpd
    moveTime+=1
    if moveTime>=moveDelay
    {
      direction=player_sprite_center()
      moveTime=0
    }

    //----- Attack -----
    shotTime+=1
    if shotTime=shotDelay
    {
      lightBullet=instance_create(eyeTail.x,eyeTail.y,oPeepEyeLightning)
      lightBullet.atkPower=atkPower
      lightBullet.ownerID=id
    }
    else if shotTime=shotDelay+41
    {
      if instance_exists(lightBullet)
      {
        if checkScreenArea(x,y,48)=1 {playSound(global.snd_LightballSpread,0,0.85,38000)}
        lightBullet.atkProg=1
        lightBullet.direction=point_direction(lightBullet.x,lightBullet.y,oPlayer1.x,oPlayer1.y-26)
      }
      shotTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_angle+=25
    if deathAnim=1
    {
      with lightBullet {instance_destroy()}
      for(i=0;i<5;i+=1)
      {
        eyePart[i].bCanDealDamage=false
      }
      with eyeTail
      {
        playSound(global.snd_BombExplode,0,0.82,1)
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
    }
    else if deathAnim>=2 and deathAnim<=99
    {
      if deathAnim mod 8=0
      {
        with eyePart[tailDeath]
        {
          playSound(global.snd_BombExplode,0,0.82,1)
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          instance_destroy()
        }
        tailDeath-=1
        if tailDeath=-1 {deathAnim=100}
      }
    }
    else if deathAnim>=115
    {
      playSound(global.snd_BombExplode,0,0.85,1)
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sBombExplosion; tEffect.image_xscale=0.85; tEffect.image_yscale=0.85
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }

  if life>0
  {
    //----- Sync lightning attack to tail -----
    if shotTime>=shotDelay+1 and shotTime<=shotDelay+40
    {
      lightBullet.x=eyeTail.x+lengthdir_x(9,eyeTail.image_angle-90)
      lightBullet.y=eyeTail.y+lengthdir_y(9,eyeTail.image_angle-90)
    }
    //----- Hit Movement -----
    if xSpd>0{xSpd-=hitFric}
    else if xSpd<0{xSpd+=hitFric}
    if ySpd>0{ySpd-=hitFric}
    else if ySpd<0{ySpd+=hitFric}

    x+=xSpd
    y+=ySpd

    //----- Tail Movement -----
    eyePart[0].x=x
    eyePart[0].y=y+19
    for(i=1;i<5;i+=1)
    {
      eyePart[i].x=eyePart[i-1].x+lengthdir_x(12,-90+eyePart[i-1].image_angle)
      eyePart[i].y=eyePart[i-1].y+lengthdir_y(12,-90+eyePart[i-1].image_angle)
      eyePart[i].image_angle=eyePart[i-1].image_angle+(segDir)
    }
    eyeTail.x=eyePart[i-1].x+lengthdir_x(12,-90+eyePart[i-1].image_angle)
    eyeTail.y=eyePart[i-1].y+lengthdir_y(12,-90+eyePart[i-1].image_angle)
    eyeTail.image_angle=eyePart[i-1].image_angle+(segDir)

    stepCount+=pi/60
    segDir+=sin(stepCount)
  }
  enemyStepEvent()
}
else
  speed=0
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
speed=0
if x>oPlayer1.x
  xSpd=3
else
  xSpd=-3

distPoint=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)/64
if distPoint>2.5
  distPoint=2.5
if y>oPlayer1.y
  ySpd=distPoint
else
  ySpd=-distPoint
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sCV_PeepingEyeLid,image_index,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
