#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.1

//Enemy base statistics
eName="Big Monster Bat"
eLevel=14
maxLife=300
life=maxLife
pointWorth=20
atkPower=5
resType[2]=2
resType[3]=4
resType[5]=2
stunResist=3
baseItemChance=65
baseDropIndex=90
moneyWorth=5
dieEffect=0
runAcc=1.33
inactiveDist*=2

chargeProg=0
chargeTime=65
chargeDelay=100

deathAnim=0
yDeath=0

jeremyText="When breaking it down fundamentally, these work almost exactly like the bees in the Magical Hills. I'm not sure what else to say about them, just watch that wing flap, it speeds up when they're about to charge."
chaoText="Another interesting behavior these have is they'll sometimes run away instead of charging toward you. I wonder what causes that..."
devText="The small chance for the bat to retreat rather than attack came about through a bug at first. It looked humorous so instead of completely removing it, the code was fixed up and the bat, scripted to perform that action at a small chance."
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
      chargeTime+=1
      if chargeProg=0 //Normal behavior
      {
        if x<oPlayer1.x
          image_xscale=1
        else
          image_xscale=-1

        if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())>128 //Far from player
        {
          direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
          speed=runAcc
        }
        else if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<112 //Close to player
        {
          chargeTime+=0.5
          direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
          speed=runAcc/1.5
        }
        else {chargeTime+=0.5}

        if chargeTime>=chargeDelay
        {
          if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<192
          {
            direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
            image_speed=0.5
            chargeTime=0
            chargeProg+=1
          }
        }
      }
      else if chargeProg=1 //Wait time
      {
        speed=runAcc/1.5
        if chargeTime>=15 //Find direction to charge
        {
          if random(10)>9.1
          {
            var newMessage;
            newMessage=instance_create(x-46,y-70,oEnemyChat)
            newMessage.enemyMessage="Run for the hills!"
            direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
          }
          else {direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())}
          chargeTime=0
          chargeProg+=1
        }
      }
      else if chargeProg=2 //Charge sting
      {
        speed=runAcc*7
        if chargeTime>=25
        {
          image_speed=0.1
          chargeTime=0
          chargeProg=0
        }
      }
    }
    else
      speed=0
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sWB_BigBat_Die
      yDeath=-6
    }
    else if deathAnim>=2
    {
      y+=yDeath
      if yDeath<12 {yDeath+=0.3}
      if y>room_height+24 {instance_destroy()}
    }
  }
  enemyStepEvent()
}
else
  speed=0
