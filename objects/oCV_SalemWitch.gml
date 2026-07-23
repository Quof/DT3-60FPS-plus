#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.15
//Enemy base statistics
eName="Salem Witch"
eLevel=14
maxLife=340
life=maxLife
pointWorth=21
atkPower=5
resType[1]=2
resType[2]=4
resType[3]=2
baseItemChance=55
baseDropIndex=80
moneyWorth=5
affiliation=3
dieEffect=0
inactiveDist=224

hitFric=0.5
xSpd=0; ySpd=0
moveSpd=0
moveTime=20
moveDir=0

shotTime=60
shotDelay=100
myFire[0]=noone
myFire[1]=noone

deathAnim=0

jeremyText="She doesn't move around too much. It's mostly to back away from you slightly. For her attack, she sends out two balls of light, which themselves can't hurt you. It's when they start that trail of blue flames that they're dangerous. Time your dodge properly."
chaoText="When these are in groups of three, they can be quite a bother. Especially when they're behind a Sword Knight for protection. Though maybe you could lure the knight away somehow..."
devText="This enemy started a new thing for DT, that being knockback when you hit the enemy. It isn't something that will show up often though, so it's scripted per enemy. Depending on whether or not it's going to be a frequent thing happening determines whether or not I'll make a function for a specific action."
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
      //----- Movement -----
      if x>oPlayer1.x {image_xscale=-1}
      else {image_xscale=1}

      if sprite_index=sCV_SalemWitchIdle {moveTime+=1}
      myDistToPlayer=point_distance(x,y,oPlayer1.x,returnPlayerYCenter())
      if moveTime>=70 and myDistToPlayer<=124 //Player is close
      {
        moveDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())+180+(20*oPlayer1.image_xscale)
        moveSpd=5
        moveTime=0
      }
      else if moveTime>=100 and myDistToPlayer>=124.1 //Player is far
      {
        moveDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())+(20*oPlayer1.image_xscale)
        moveSpd=5
        moveTime=0
      }
      if moveSpd>0
      {
        moveSpd-=0.2
        if moveSpd<=0.25 {moveSpd=0}
      }
      direction=moveDir
      speed=moveSpd

      //----- Attack -----
      shotTime+=1
      if shotTime=shotDelay {sprite_index=sCV_SalemWitchCast}
      else if shotTime=shotDelay+10
      {
        var tDir;
        tDir=player_sprite_center()
        for(i=0;i<2;i+=1)
        {
          myFire[i]=instance_create(x,y,oSalemWitchFire)
          myFire[i].atkPower=atkPower
          myFire[i].direction=tDir+90+(i*180)
        }
      }
      else if shotTime=shotDelay+50
      {
        sprite_index=sCV_SalemWitchIdle
        shotTime=0
      }
    }
    else {speed=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      speed=0
      sprite_index=sCV_SalemWitchDie
      for(i=0;i<2;i+=1)
      {
        if instance_exists(myFire[i]) {with myFire[i] {instance_destroy()}}
      }
    }
    if deathAnim mod 3=0
    {
      if deathAnim mod 6=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-11,11),y+random_range(-20,20),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.02
    if image_alpha<0 {instance_destroy()}
  }

  //----- Hit Movement -----
  if xSpd>0{xSpd-=hitFric}
  else if xSpd<0{xSpd+=hitFric}
  if ySpd>0{ySpd-=hitFric}
  else if ySpd<0{ySpd+=hitFric}

  x+=xSpd; y+=ySpd

  enemyStepEvent()
}
else {speed=0}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if x>oPlayer1.x {xSpd=3}
else {xSpd=-3}

if y>oPlayer1.y-26 {ySpd=2.5}
else {ySpd=-2.5}
