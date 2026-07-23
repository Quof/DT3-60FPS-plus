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
eName="Facility Drone"
eLevel=31
maxLife=480
life=maxLife
pointWorth=45
atkPower=10
resType[1]=2
resType[4]=4
stunResist=4
baseItemChance=65
baseDropIndex=90
moneyWorth=5

runAcc=2
turnTime=0
shotTime=20
shotDelay=75
lineW=1

bIsBoss=1
chaoText="Jeremy, you and Jerry don't like this thing much. Is there bad blood between you and this bot type?"
devText="I always wanted to bring this enemy back from the first game and this place seemed like the perfect spot to bring them back for."

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
    if turnTime>=64
    {
      image_xscale*=-1
      turnTime=0
    }

    if shotTime<=shotDelay
    {
      turnTime+=1
      x+=runAcc*image_xscale
    }

    if bInfected=1
    {
      shotTime+=1
      if shotTime>=shotDelay {lineW+=0.33}
      if shotTime>=shotDelay+30
      {
        if !collision_line(x,y,oPlayer1.x,oPlayer1.y-26,oSolid,true,true)
        {
          playSound(global.snd_Shock,0,0.82,17000)
          with oPlayer1 {hitPlayer(other)}
        }
        lineW=1
        shotTime=0
      }
    }
  }
  else if bActive=false {shotTime=20}
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
jeremyText="Oh no, the Aero Scanner is back. I mean, it's not really the Aero Scanner, but its behavior is nearly identical. It has that annoying laser pointer attack. To avoid it, put something between you and it. You'll know you're doing it right when the laser turns blue. If there's no cover though, dashing at the moment it would deal damage will keep it from harming you."
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
  if shotTime>=shotDelay
  {
    draw_set_alpha(1)
    if !collision_line(x,y,oPlayer1.x,oPlayer1.y-24,oSolid,true,true)
      draw_set_color(c_red)
    else
      draw_set_color(c_blue)
    draw_line_width(x,y,oPlayer1.x,oPlayer1.y-24,lineW)
  }
}
event_inherited()
