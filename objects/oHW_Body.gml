#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveDelay
event_inherited()
bCanTakeDamage=false
image_speed=0
bActive=true

//Enemy base statistics
eName="Hex Worm Body"
eLevel=37
maxLife=170
life=maxLife
atkPower=12
affiliation=8
bIsBoss=true
bNoBonus=true
dieEffect=0
weaponGive=300
bossProgress=0

chargeFrame=0
myMoveCheck=0

fireTime=30
fireDelay=75+(oHexWorm.partNum*4)

jeremyText="After some time, these become invulnerable to taking damage, but you know what to do there. Something different for them though, they try to stay attached to the body, so you'll need to be very close to get Kirby to eat them. Oh yes, when you see a charging up like particle effect on the body segments, it's about to fire a laser."
chaoText="These don't give any ability when eaten, but they do restore 1/2 of a heart... wow that's pretty bad."
devText="N/A"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  event_inherited()
  if bActive=true and life>0
  {
    if moveDelay=0
    {
      image_angle=direction
      if oHexWorm.moveBehavior=1 //Follow a path
      {
        if myMoveCheck=0
        {
          fireTime+=1
          if fireTime>=fireDelay
          {
            playSound(global.snd_LaserA,0,0.9,32000)
            if oHexWorm.partNum>=12
            {
              var tNewAttack,tDir;
              tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
              tNewAttack=instance_create(x,y,oPassBullet)
              tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=6
              tNewAttack.decayTime=-100; tNewAttack.direction=tDir
              if oHexWorm.partNum<=17
              {
                tNewAttack=instance_create(x,y,oPassBullet)
                tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
                tNewAttack.decayTime=-100; tNewAttack.direction=tDir-5
                tNewAttack=instance_create(x,y,oPassBullet)
                tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
                tNewAttack.decayTime=-100; tNewAttack.direction=tDir+5
              }
            }
            else
            {
              var tNewAttack,tDir;
              tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
              for(i=0;i<8;i+=1)
              {
                tNewAttack=instance_create(x,y,oPassBullet)
                tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
                tNewAttack.decayTime=-100; tNewAttack.direction=tDir
                tDir+=360/8
              }
            }
            fireTime=0
          }

          path_speed=oHexWorm.moveSpd
          if path_position>=0.99
          {
            bCanTakeDamage=false
            oHexWorm.partCheck+=1
            myMoveCheck=1
          }
        }
      }
    }
    else {path_speed=0; moveDelay-=1}

    if lifePercent<=0.4 and lifePercent>=0 and bossProgress=0
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    playSound(global.snd_HealthPickup,0,1,1)
    oPlayer1.life+=2
    oHexWorm.partNum-=1
    instance_destroy()
  }
  enemyStepEvent()
}
else {path_speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()
if fireTime>=fireDelay-20
{
  if oGame.time mod 2=0
    chargeFrame+=1
  draw_sprite_ext(sMMcharging,chargeFrame,x,y,1,1,0,c_white,image_alpha)
}
