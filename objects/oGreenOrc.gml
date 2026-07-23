#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-9,-42,9,-1)
image_speed=0.25

//Enemy base statistics
eName="Green Orc"
eLevel=9
maxLife=400
life=maxLife
pointWorth=13
atkPower=4
resType[1]=5
resType[2]=4
stunResist=4
baseItemChance=55
baseDropIndex=85
affiliation=2
dieEffect=3

initDir=0
runAcc=2.25
bJumpReady=1

jeremyText="Ah, the generic orc. Nothing tough about these, they just get in the way. However, I am detecting a new AI behavior. It seems these guys will jump at a ledge instead of falling to their doom."
chaoText="These guys are usually found around the mountains here. Looks like they're guarding the Great Palace. Those you find on the mountains. Not the ones anywhere else."
devText="I made this enemy AI specifically to put the player in compromising situations and built a few levels that put their jump to good use. Of course, with every problem that's presented, the player will always be equip to handle it..."
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
    //---------- Movement ----------
    if yVel=0 and bJumpReady=1
    {
      image_speed=0.25
      sprite_index=sGreenOrcWalk
      if x<oPlayer1.x
      {
        image_xscale=1
        xVel=runAcc
      }
      else
      {
        image_xscale=-1
        xVel=-runAcc
      }
    }
    else
    {
      image_speed=0
      sprite_index=sGreenOrcJump
      if yVel<0
        image_index=0
      else
        image_index=1
    }

    //Check if cliff edge and jump
    if yVel=0 and bJumpReady=1
    {
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,24,16,4)=1
        {
          tDrop=1
        }
      }

      if tDrop=0
      {
        xVel=(runAcc*1.25)*image_xscale
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    /*if !collision_point(x+(16*image_xscale),y+4,oSolid,0,1) and yVel=0 and bJumpReady=1
    {
      var tDrop;
      tDrop=0
      for(i=0;i<3;i+=1)
      {
        if collision_point(x+(16*image_xscale),y+4+(i*24),oSolid,0,1)
        {
          tDrop=1
          break;
        }
      }

      if tDrop=0
      {
        xVel=(runAcc*1.25)*image_xscale
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }*/

    yVel+=0.25
    if isCollisionBottom(1)
    {
      yVel=0
      bJumpReady=1
    }
    if isCollisionLeft(1)
      xVel=runAcc
    if isCollisionRight(1)
      xVel=-runAcc
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  enemyStepEvent()
}
