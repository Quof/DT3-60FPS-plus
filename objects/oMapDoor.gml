#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: bShowArrow,exitType,type,newX,newY
arrowX=x+8
arrowY=y-24
pointTime=0
animPlayerExit=0
init=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  if init=0
  {
    effectLimit=0
    init=1
  }
  if global.gamePaused=false
  {
    pDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-22)
    if pDist<384
    {
      if effectLimit<=0
      {
        pX=x-2+random(20)
        pY=y-2+random(36)
        sizeRan=round(random(1))
        effect_create_above(ef_smoke,pX,pY,sizeRan,c_black)
        effectLimit=3
      }
      else
        effectLimit-=1
    }
  }
}

if animPlayerExit>0
{
  animPlayerExit+=1
  oPlayer1.x=x+(sprite_width/2)
  oPlayer1.y+=2
  if animPlayerExit=30
  {
    global.gamePaused=false
    oPlayer1.bCanTakeDamage=true
    oPlayer1.bCanTakeHit=true
    oPlayer1.depth=20
    oPlayer1.x=newX
    oPlayer1.y=newY
    view_xview[0]=newX
    view_yview[0]=newY
    animPlayerExit=0
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Door script.
This will move the player to another part of the same room.
exitType is set in the creation code.
exitType relates to whether the player has to press up to activate the event.
-- 0: Player must press up. Use for doors.
-- 1: Player just needs to walk into the exit.
-- 2: Player must press down. Use for pipes.
*/
if exitType=0
{
  if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
  {
    oPlayer1.x=newX
    oPlayer1.y=newY
    view_xview[0]=newX
    view_yview[0]=newY
    io_clear()
  }
}
else if exitType=1
{
  oPlayer1.x=newX
  oPlayer1.y=newY
  view_xview[0]=newX
  view_yview[0]=newY
}
else if exitType=2
{
  if oKeyCodes.kCodePressed[4]=1 and global.gamePaused=false
  {
    global.gamePaused=true
    playSound(global.snd_MarioPipe,0,1,1)
    if global.activeCharacter=0 oPlayer1.sprite_index=sJerryIdle
    else if global.activeCharacter=1 oPlayer1.sprite_index=sClaireIdle
    stopPlayer()
    oPlayer1.depth=1100000
    oPlayer1.bCanTakeDamage=false
    oPlayer1.bCanTakeHit=false
    animPlayerExit=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShowArrow=true
{
  pointTime+=1
  if pointTime=20
    arrowY+=1
  else if pointTime=40
  {
    arrowY-=1
    pointTime=0
  }
  draw_sprite(sExitArrow,2,arrowX,arrowY)
}
