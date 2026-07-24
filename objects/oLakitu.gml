#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
animSpd=0
image_speed=animSpd

//Enemy base statistics
eName="Lakitu"
eLevel=5
maxLife=150
life=maxLife
pointWorth=10
atkPower=4
resType[2]=5
resType[3]=4
resType[4]=5
resType[5]=1
baseItemChance=75
affiliation=1
dieEffect=0
runAcc=3
bThrown=0

throwTime=60
throwDelay=70

deathAnim=0
dthVelY=-4

jeremyText="One of the most annoying enemies in the Mario universe... at least until the Big N started nerfing the guy. You know the drill with these. They throw Spiny Beetles and in some cases, not Spiny Beetles. If you can reach him, it'll make things easier for a little while."
chaoText="Eww, I don't like these. They mistreat the Spinys and that's wrong. What did the Spinys ever do to them?!"
devText="These were actually coded in DT2, but were never used. It would've still worked within the fundamental designs the levels followed, but they wouldn't have much of an impact since Claire was very mobile. All levels were designed so that you could chain every enemy from start to finish, which the Lakitu didn't break, but he simply had no real purpose in the game, even as a buffer to the next enemy to chain."
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
    //---------- Movement ----------
    runAcc=point_distance(x,0,oPlayer1.x,0)/20
    if runAcc>10 {runAcc=10}
    else if runAcc<0.1 {runAcc=0}

    if x<oPlayer1.x {x+=runAcc*gDeltaTime}
    else {x-=runAcc*gDeltaTime}

    if throwTime<throwDelay //Look at player
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //---------- Throw object ----------
    throwTime+=1*gDeltaTime
    if throwTime>=throwDelay
    {
      if throwTime=throwDelay
      {
        if random(100)<2.75
        {
          var newMessage;
          newMessage=instance_create(x-46,y-48,oEnemyChat)
          newMessage.enemyMessage="Have a spike salad!"
        }
        image_index=0
        animSpd=0.33
      }
      else if throwTime>=throwDelay+1 and throwTime<=throwDelay+500 //Check anim frame
      {
        animSpd=0.33
        if image_index>=7 and image_index<=7.99 and bThrown=0 //On throw frame
        {
          if instance_number(oSpinyBeetle)<50
          {
            if checkScreenArea(x,y,48)=1 {playSound(global.snd_LinkBomb,0,0.95,18000)}
            var tNewSpiny,tDirX;
            if image_xscale=1 {tDirX=6*gDeltaTime}
            else {tDirX=-6*gDeltaTime}
            tNewSpiny=instance_create(x+tDirX,y-6,oSpinyBeetle)
            tNewSpiny.bActive=true
            tNewSpiny.sprite_index=sSpinyBeetleBall
            if tDirX>0 {tNewSpiny.xVel=1}
            else {tNewSpiny.xVel=-1}
            tNewSpiny.yVel=-3*gDeltaTime
          }
          bThrown=1
        }
        else if image_index>=8
        {
          throwTime=throwDelay+600
          bThrown=0
          animSpd=0
        }
      }
      else if throwTime>=throwDelay+608 //End attack
      {
        image_index=0
        throwTime=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1 {sprite_index=sLakituFall}
    y+=dthVelY*gDeltaTime
    dthVelY+=0.3*gDeltaTime
    if y>room_height+16 {instance_destroy()}
  }
  enemyStepEvent()
}
else {animSpd=0}
image_speed=animSpd
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
