#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: dropDist (multiples of 6)
event_inherited()
bCanDealDamage=false
bCanTakeDamage=false
y+=32
image_speed=0.05
headFrm=0
bInfected=0

//Enemy base statistics
eName="Junk Bot"
eLevel=30
maxLife=290
life=maxLife
pointWorth=37
atkPower=9
resType[0]=2
resType[3]=2
resType[5]=4
stunResist=3
baseItemChance=50
baseDropIndex=90
pickupDropMod=5
detectDistX=196

dropped=-1
moveWave=pi
shotTime=15
shotDelay=35

bIsBoss=1
chaoText="Wait, why are these robots just hanging there? They're all inactive too, well until the Virus turned them on again. These things just creep me out is all."
devText="When it came to implementation, I was surprised how much of my original idea actually worked in practice. Not too much had to change. That said, designing this level was more difficult than I thought it would be."

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
    //Drop when player is close enough
    if dropped=-1
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<192 {dropped=0}
    }
    else if dropped<dropDist {dropped+=6; y+=6}

    //Hanging wave
    moveWave+=pi/40
    x+=cos(moveWave)/1.75

    if bInfected=1
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      shotTime+=1
      if shotTime=shotDelay {headFrm=2}
      else if shotTime>=shotDelay+10
      {
        if shotTime mod 10=0
        {
          var tNewAttack;
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4
          tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100
          tNewAttack.direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
        }
      }
      if shotTime>=shotDelay+40
      {
        headFrm=1
        shotTime=0
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
jeremyText="These don't do much but hang there and fire standard bullets toward you. The threatening thing about them is that they fire at a pretty fast rate."
bCanDealDamage=true
bCanTakeDamage=true
baseColor=make_color_rgb(180,255,180)
image_blend=baseColor
headFrm=1
bActive=1
bInfected=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(c_gray)
draw_line(xstart,ystart,x,y)
event_inherited()
draw_sprite_ext(sJunkBotHead,headFrm,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
