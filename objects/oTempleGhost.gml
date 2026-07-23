#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: xTrack,yTrack
event_inherited()
image_speed=0.25
bCanDealDamage=0
bCanTakeDamage=0

//Enemy base statistics
eName="Temple Ghost"
eLevel=36
maxLife=540
life=maxLife
pointWorth=100
atkPower=10
stunResist=6
baseItemChance=70
moneyWorth=10
dieEffect=0

currHspd=0; currVspd=0
xPoint=0
yPoint=0
maxSpeed=4.4

shotTime=100
shotDelay=140
checkLight=0

bTouchSpikeCeiling=0

jeremyText="These guys seem to be completely immune to damage. 'Seem' being the operating word. They can be damaged somehow I'm sure. That block of code is hidden from me, but before that it mentions something in the environment that causes them to phase into existence. Its attack is an assortment of ghostly fire that it projects from itself, then sends them toward you about a second later. They do have homing properties, so watch yourself."
chaoText="This sprite comes from the game, 'Barnyard Blast' for the DS. What a weird sounding game.##It's kind of interesting that the traps here will harm bots that aren't native to the temple."
devText="While I didn't use it much, I really liked (sometimes) designing around the traps also damaging the CHAOS bots. It turned out to not really work out too well, which is the main reason it isn't fully utilized. The traps tend to be too detrimental to the enemies, or not enough."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(0)}
  if bActive=true and stunnedTime=0 and life>0
  {
    if collision_circle(x,y,8,oCh19CeilingTrap,1,1) {bTouchSpikeCeiling=1}
    else {bTouchSpikeCeiling=0}

    if checkLight>0 {checkLight-=1}
    else {bCanTakeDamage=0}

    if x>oPlayer1.x {image_xscale=-1}
    else {image_xscale=1}

    //Movement
    xPoint=oPlayer1.x+(xTrack*-oPlayer1.image_xscale)
    yPoint=oPlayer1.y-yTrack

    if x>xPoint
    {
      if currHspd>-maxSpeed {currHspd-=0.4}
      else {currHspd+=0.4}
    }
    else if x<xPoint
    {
      if currHspd<maxSpeed {currHspd+=0.4}
      else {currHspd-=0.4}
    }
    if y>yPoint
    {
      if currVspd>-maxSpeed {currVspd-=0.4}
      else {currVspd+=0.4}
    }
    else if y<yPoint
    {
      if currVspd<maxSpeed {currVspd+=0.4}
      else {currVspd-=0.4}
    }
    hspeed=currHspd; vspeed=currVspd

    //Fire shots
    shotTime+=1
    if shotTime=shotDelay {sprite_index=sTempleGhost_HandUp}
    else if shotTime=shotDelay+10
    {
      shotDist=0
      for(i=0;i<8;i+=1)
      {
        myFire[i]=instance_create(x+(16*image_xscale),y-10,oTGhostFire)
        myFire[i].myOwner=id; myFire[i].atkPower=atkPower
      }
    }
    else if shotTime>=shotDelay+11 and shotTime<=shotDelay+50
    {
      if shotTime<=shotDelay+30 {shotDist+=2}
      for(i=0;i<8;i+=1)
      {
        myFire[i].x=x+(16*image_xscale)+lengthdir_x(shotDist,i*45)
        myFire[i].y=y-10+lengthdir_y(shotDist,i*45)
      }
    }
    else if shotTime=shotDelay+51
    {
      for(i=0;i<8;i+=1)
      {
        myFire[i].atkProg=1
      }
      sprite_index=sTempleGhost_Idle
      shotTime=0
    }
  }
  else if life<=0
  {
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    instance_destroy()
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag<100 {event_inherited()}
#define Collision_oDCS_Light
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCanTakeDamage=1
checkLight=2
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bTouchSpikeCeiling=0
{
  depth=25
  if checkLight=0
  {
    image_alpha=1
    draw_set_blend_mode(bm_add)
    event_inherited()
    draw_set_blend_mode(bm_normal)
  }
  else
  {
    image_alpha=0.75
    event_inherited()
  }
}
else
{
  depth=8
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_black,0.15)
}
