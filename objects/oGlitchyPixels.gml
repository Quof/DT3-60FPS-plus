#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=2
image_yscale=2
myColor=make_color_rgb(40,40,40)

//Enemy base statistics
eName="Glitchy Pixels"
eLevel=35
maxLife=140
life=maxLife
pointWorth=52
atkPower=9
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=2
stunResist=2
baseItemChance=60
baseDropIndex=90
moneyWorth=5

runAcc=3
shotTime=30
shotDelay=80

orbitPos=0
orbitSpd=1
myDir=0
circlePlayer=0
bArmorBreak=0

jeremyText="Its movement can be a bit odd to interpret. All it does is orbit a set distance from your location, but that orbit is constantly changing, so your movement can make its movement look erratic. Stop for a moment and observe it, things will make sense then. As for attacks, it has one. When you see those small circles orbiting its main part start to move faster, it's going to fire three shots toward you."
chaoText="These are pretty weird. It looks like its sprite is undefined. You'll come across two kinds of these, both with the same behavior, but a different vulnerability. The one that has very contrasting color to non-solids when not in an inverted color is weak to PIERCE, and the one that has very little contrast to that is weak to SPECIAL. If you can hit it with EXPLOSIVE, but I don't know how useful that will be."
devText="I definitely wanted to use this idea again, especially after it was so well received in DT1. This time though, I wanted to take it a bit further with the color collision rules swapping and the method the traps use to conceal themselves. I thought this turned out pretty neat."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  eName+=" Alpha"
  myColor=make_color_rgb(40,40,40)
}
else if type=5
{
  eName+=" Beta"
  myColor=make_color_rgb(215,215,215)
}
resType[type]=3
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
      //Movement
      var tDirToPlayer;
      tDirToPlayer=point_direction(x,y,oPlayer1.x+lengthdir_x(96,circlePlayer),returnPlayerYCenter()+lengthdir_y(96,circlePlayer))
      circlePlayer+=2
      direction=tDirToPlayer
      speed=runAcc

      //Weapon
      shotTime+=1
      if shotTime>=shotDelay-30 {orbitSpd=8}
      else {orbitSpd=1}
      orbitPos+=orbitSpd

      if shotTime>=shotDelay
      {
        var tNewAttack,tDir;
        tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        tDir-=12
        for(i=0;i<3;i+=1)
        {
          tNewAttack=instance_create(x,y,oGlitchBullet)
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6; tNewAttack.decayTime=-100
          tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.75
          tNewAttack.direction=tDir
          tDir+=12
        }
        shotTime=0
      }
    }
    else {speed=0}
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bArmorBreak=0 and other.damageType="EXPLOSION"
{
  resType[type]+=1
  bArmorBreak=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(myColor)
draw_circle(x,y,7,0)
myDir=0
for(i=0;i<6;i+=1)
{
  draw_circle(x+lengthdir_x(12,orbitPos+myDir),y+lengthdir_y(12,orbitPos+myDir),2,0)
  myDir+=360/6
}
