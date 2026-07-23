#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
bInfected=0

//Enemy base statistics
eName="Facility Cleaner Bot"
eLevel=31
maxLife=530
life=maxLife
pointWorth=49
atkPower=9
stunResist=6
resType[0]=2
baseItemChance=65
baseDropIndex=90
moneyWorth=5
initDir=0

runAcc=1.5
turnTime=0
shotTime=20
shotDelay=70
elecFrm=0
lineAlpha=0
bRockForm=0

bIsBoss=1
chaoText="Why is this called a Cleaner Bot? I guess that vacuum it creates to pull in the rocks is why, but still. It's just so weird, and why would a facility that isn't being used in a virtual world even need a bot that cleans?"
devText="Nearly all the enemies in here are set up to be a fairly good nuisance to the player to encourage them to attempt to fight off the Injector Virus's from infecting bots."

deathAnim=0

myInfectSpot=instance_create(x,y,oInfectMe)
myInfectSpot.myOwner=id
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
    if initDir=0
    {
      if x>oPlayer1.x {image_xscale=-1}
      initDir=1
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
    if shotTime<shotDelay {x+=runAcc*image_xscale}

    if bInfected=1
    {
      shotTime+=1
      if bRockForm=0
      {
        if shotTime>=shotDelay and shotTime<=shotDelay+9 {lineAlpha+=0.1}
        else if shotTime=shotDelay+12
        {
          var tNewAtk,tDir;
          tDir=0
          for(i=0;i<8;i+=1)
          {
            tNewAtk=instance_create(x+lengthdir_x(192,tDir),y+lengthdir_y(192,tDir),oCleanBotRock)
            tNewAtk.atkPower=atkPower; tNewAtk.myOwner=id; tNewAtk.direction=tDir-180
            tDir+=45
          }
        }
      }
      else
      {
        if shotTime>=shotDelay+12
        {
          if shotTime mod 6=0
          {
            playSound(global.snd_HardHit3,0,0.95,18000)
            var tNewAttack;
            tNewAttack=instance_create(x,y,oPassBulletRed)
            tNewAttack.sprite_index=sCleanBotRock; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=10
            tNewAttack.decayTime=-100; tNewAttack.direction=player_sprite_center()
          }
        }
        if shotTime>=shotDelay+36
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
          resType[0]=2
          sprite_index=sFacCleanerBare
          stunResist=6
          lineAlpha=0
          bRockForm=0
          shotTime=0
        }
      }
    }
  }
  enemyStepEvent()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(myInfectSpot)
{
  with myInfectSpot {instance_destroy()}
}
bIsBoss=0
jeremyText="When you see the lightning effect and the lines, be sure to get out of the way since you can't dash through the rocks it summons. When the rocks reach it, it will recover some HP and increase all of its resistances up 1 level. After a moment, it will fire off the rocks toward you."
bCanDealDamage=true
bCanTakeDamage=true
baseColor=make_color_rgb(180,255,180)
image_blend=baseColor
bActive=1
bInfected=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bActive=true
{
  if shotTime>=shotDelay and bRockForm=0
  {
    draw_set_alpha(lineAlpha)
    draw_set_color(c_red)
    var tDir;
    tDir=0
    for(i=0;i<8;i+=1)
    {
      draw_line_width(x,y,x+lengthdir_x(192,tDir),y+lengthdir_y(192,tDir),3)
      tDir+=45
    }
  }
}
event_inherited()
if shotTime>=shotDelay
{
  elecFrm+=0.4
  draw_sprite_ext(sEfCleanBotElec,elecFrm,x,y,1,1,0,c_white,1)
  draw_sprite_ext(sEfCleanBotElec,elecFrm,x,y,1,1,90,c_white,1)
  draw_sprite_ext(sEfCleanBotElec,elecFrm,x,y,1,1,180,c_white,1)
  draw_sprite_ext(sEfCleanBotElec,elecFrm,x,y,1,1,270,c_white,1)
}
