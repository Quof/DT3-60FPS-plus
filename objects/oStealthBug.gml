#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2

//Enemy base statistics
eName="Stealth Bug"
eLevel=21
maxLife=310
life=maxLife
pointWorth=29
atkPower=6
resType[1]=4
resType[2]=4
resType[5]=2
stunResist=1
baseItemChance=70
baseDropIndex=90
moneyWorth=5
runAcc=1.5
inactiveDist*=1.5

eProg=0
riseTime=0
chargeProg=0
chargeTime=0
chargeDelay=100

jeremyText="I think this is the first I've ever seen anything that can cloak in this world. Behavior wise, it's similar to the Magical Bees and Big Monster Bats with a few tweaks. While it pulls back before a charge, its cloak will give up a bit."
chaoText="It's really not all that hard to see, especially if you're playing full screen...#That wasn't the 4th wall I threw a rock at was it?"
devText="In a very old game I made, there was an enemy that used camo to hide itself. If it was stationary, it was 100% invisible. Only when it moved and you saw the area around it distort, were you able to see where it was. This may or may not make it to an enemy in DT3."
extraInfo="Cloaks when not attacking."
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
      if eProg=0 //Fly when player is close enough or took damage
      {
        if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<216 {eProg=1}
        if life<maxLife {eProg=1}
      }
      else if eProg=1 //Fly up
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}

        sprite_index=sStealthBugFly
        y-=2
        image_alpha-=0.02
        riseTime+=1
        if riseTime>=45 {eProg=2}
      }
      else if eProg=2 //Normal behavior
      {
        chargeTime+=1
        if chargeProg=0 //Normal
        {
          if image_alpha>0.06 {image_alpha-=0.02}

          if x<oPlayer1.x {image_xscale=1}
          else {image_xscale=-1}

          if point_distance(x,0,oPlayer1.x,0)>20 //Seek player y
          {
            if image_xscale=1 {x+=runAcc}
            else {x-=runAcc}
          }

          if y>oPlayer1.y-128 {y-=3}
          else if y<oPlayer1.y-144 {y+=1}

          if chargeTime>=chargeDelay
          {
            if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<192
            {
              direction=player_sprite_center()-180
              image_speed=0.5
              chargeTime=0
              chargeProg+=1
            }
          }
        }
        else if chargeProg=1 //Wait time
        {
          speed=runAcc/1.5
          image_alpha+=0.02
          if chargeTime>=12 //Find direction to charge
          {
            direction=player_sprite_center()
            chargeTime=0
            chargeProg+=1
          }
        }
        else if chargeProg=2 //Charge sting
        {
          speed=runAcc*7
          if chargeTime>=21
          {
            speed=0
            image_speed=0.2
            chargeTime=0
            chargeProg=0
          }
        }
      }
    }
    else {speed=0}
  }
  enemyStepEvent()
}
else {speed=0}
