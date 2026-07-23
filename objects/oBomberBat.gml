#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd,turnDelay,turnAmt
event_inherited()
image_speed=0
animTime=0
warnFrm=0

//Enemy base statistics
eName="Bomber Bat"
eLevel=36
maxLife=220
life=maxLife
pointWorth=66
atkPower=11
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=3
stunResist=50

turnTime=0
turnNum=0

jeremyText="These fly in a perfect square pattern, though each spawn is capable of different speeds. It will always fire on the third time it changes direction."
chaoText="That bat sprite is adorable."
devText="Bomberman 64 is definitely one of my more fonder memories of the N64 days, and easily my favorite of the Bomberman games, including the 2D games. For a long while, I wanted to do some kind of homage to Bomberman, but I couldn't quite figure out how in using the current abilities. With a level like this, I knew what I needed to do."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true
  {
    animTime+=1
    if animTime=10 {image_index=1}
    else if animTime=20 {image_index=2}
    else if animTime=30 {image_index=1}
    else if animTime=40 {image_index=0; animTime=0}

    speed=moveSpd
    turnTime+=1
    if turnTime>=turnDelay
    {
      turnNum+=1
      if turnNum>=3
      {
        var tNewAttack;
        for(i=0;i<4;i+=1)
        {
          tNewAttack=instance_create(x,y,oNormalBullet)
          tNewAttack.sprite_index=sEBShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=2
          tNewAttack.direction=90*i; tNewAttack.image_xscale=5.25; tNewAttack.image_yscale=5.25; tNewAttack.image_alpha=0.8
        }
        turnNum=0
      }
      direction+=turnAmt
      turnTime=0
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if turnNum=2
{
  warnFrm+=1
  draw_sprite_ext(sMMcharging,warnFrm,x,y,1,1,0,c_white,1)
}
