#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Metal Guardian"
eLevel=21
maxLife=510
life=maxLife
pointWorth=29
atkPower=5
for(i=0;i<6;i+=1)
{
  resType[i]=2
}
stunResist=5
baseItemChance=75
baseDropIndex=95
moneyWorth=10
dieSound=0
dieEffect=0
initDir=0

runAcc=1
turnTime=0
shotTime=40
shotDelay=70

deathAnim=0

jeremyText="This thing tries to conceal its weakness to you. When it opens its eye, use SHOT type attacks such as your X-Buster. Its crazy resilience can be quite an annoyance."
chaoText="Oh wow, this thing fires 3 large lasers toward you. I recommend dashing...#Sorry, I just can't think straight right now. Mixture of feeling kinda depressed and this place brightening my mood."
devText="This enemy is the only normally appearing enemy in the Farreaches to pose much of a threat. To keep with the calm approach, I wanted to keep the enemies less threatening than the previous areas. Although this being the first area that the player has access to multiple abilities with one character, I wanted to show there were benefits to both staying with one set as well as switching."
extraInfo="Very High Stun Resist when shell is closed."
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
    if initDir=0
    {
      if x>oPlayer1.x
        image_xscale=-1
      initDir=1
    }

    if image_index=2
    {
      resType[0]=3
      resType[1]=1
      resType[2]=2
      resType[3]=4
      resType[4]=3
      resType[5]=3
      stunResist=4
    }
    else
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=2
      }
      resType[1]=1
      stunResist=12
    }

    if x>oPlayer1.x and image_xscale=1
      turnTime+=1
    else if x<oPlayer1.x and image_xscale=-1
      turnTime+=1
    if turnTime>=30
    {
      image_xscale*=-1
      turnTime=0
    }
    x+=runAcc*image_xscale

    shotTime+=1
    if shotTime=shotDelay {image_index=1}
    else if shotTime=shotDelay+6 {image_index=2}
    else if shotTime=shotDelay+30
    {
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_LaserA,0,0.86,15000)}
      var tNewAtk,tDir;
      tDir=player_sprite_center()
      tDir-=10
      for(i=0;i<3;i+=1)
      {
        tNewAtk=instance_create(x,y,oPassBullet)
        tNewAtk.sprite_index=sLB_Laser; tNewAtk.atkPower=atkPower; tNewAtk.bulletSpeed=6; tNewAtk.image_yscale=2
        tNewAtk.decayTime=-100; tNewAtk.direction=tDir; tNewAtk.image_angle=tDir
        tDir+=10
      }
    }
    else if shotTime=shotDelay+50 {image_index=1}
    else if shotTime=shotDelay+55
    {
      image_index=0
      shotTime=0
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_BombExplode,0,0.9,1)
      sprite_index=sMetalGuardianDie
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    if deathAnim mod 5=0
    {
      if deathAnim mod 10=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-10,10),y+random_range(-10,10),oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    y+=1
    image_alpha-=0.02
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if image_index=2 {draw_sprite_ext(sMetalGuardianEye,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)}
