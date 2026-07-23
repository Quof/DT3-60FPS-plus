#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
x=global.newMapX
y=global.newMapY
if y>10000
{
  global.newMapY-=10000
  y=global.newMapY
}

bMoveStep=0
moveTime=0
bCanMove=1
delayMove=6

if room=rLink2_Overworld
  encDelay=90
else if room=rLink2_Overworld2
  encDelay=150
encTime=0

if global.gameProgress<=630
  encounterSteps=irandom_range(12,20)
else
  encounterSteps=irandom_range(16,40)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Controls -----
delayMove-=1
if delayMove<=0
{
  if !instance_exists(oZeldaSaveMenu)
  {
    event_user(0)
    if bMoveStep>0
    {
      if bMoveStep=1
        y-=4
      else if bMoveStep=2
        y+=4
      else if bMoveStep=3
        x-=4
      else if bMoveStep=4
        x+=4

      moveTime+=1
      if moveTime=4
      {
        image_speed=0
        moveTime=0
        bMoveStep=0

        //-- Random encounters --
        if global.gameProgress<=690
        {
          encounterSteps-=1
          if encounterSteps<=0
          {
            if global.gameProgress=630
              global.gameProgress=640
            event_user(1)
          }
        }
      }
    }
    event_user(0)

    //----- Pause Menu -----
    if bMoveStep=0 and bCanMove=1
    {
      if oKeyCodes.kCodePressed[12]=1
      {
        io_clear()
        resetKeyCodes()
        playSound(global.snd_MenuOpen,0,1,1)
        instance_create(0,0,oZeldaSaveMenu)
      }
    }

    //----- Spawn encounters -----
    if global.gameProgress>=700
    {
      encTime+=1
      if encTime>=encDelay and moveTime=0
      {
        var tTileID,tTileLeft;
        tTileID=tile_layer_find(1000000,x,y)
        tTileLeft=tile_get_left(tTileID)
        if tTileLeft=16 or tTileLeft=32 or tTileLeft=48
        {
          encTime=10+round(encDelay/10)

          var tNewSpawn;
          tNewSpawn=instance_create(x+96,y,oG2_MapEn)
          tNewSpawn=instance_create(x-96,y,oG2_MapEn)
          if random(10)>5
            tNewSpawn=instance_create(x,y+96,oG2_MapEn)
          else
            tNewSpawn=instance_create(x,y-96,oG2_MapEn)
        }
      }
    }
  }
}
#define Collision_oG2_MapEn
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveTime=0 and bCanMove=1
{
  event_user(1)
}
#define Mouse_54
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMenu=1
{
  var xCoord,yCoord;
  xCoord=get_integer("Enter target x coordinate.",x)
  yCoord=get_integer("Enter target y coordinate.",y)
  x=xCoord
  y=yCoord
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//---------- Movement Controls ----------
if bMoveStep=0 and bCanMove=1
{
  if scrController(3) and !collision_point(x,y-16,oSolid,0,1)
  {
    sprite_index=sJerryZUp
    image_xscale=1
    image_speed=0.33
    bMoveStep=1
  }
  else if scrController(4) and !collision_point(x,y+16,oSolid,0,1)
  {
    sprite_index=sJerryZDown
    image_xscale=1
    image_speed=0.33
    bMoveStep=2
  }
  else if scrController(1) and !collision_point(x-16,y,oSolid,0,1)
  {
    sprite_index=sJerryZRight
    image_xscale=-1
    image_speed=0.33
    bMoveStep=3
  }
  else if scrController(2) and !collision_point(x+16,y,oSolid,0,1)
  {
    sprite_index=sJerryZRight
    image_xscale=1
    image_speed=0.33
    bMoveStep=4
  }
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_ZeldaToMap,0,1,11025)
global.recAreaTrans+=1
global.recZeldaEnc+=1
global.newMapX=x
if room=rLink2_Overworld
  global.newMapY=y
else
  global.newMapY=y+10000
var tTileID,tTileLeft;
tTileID=tile_layer_find(1000000,x,y)
tTileLeft=tile_get_left(tTileID)
transition_steps=5
transition_kind=20
if tTileLeft=0 or tTileLeft=64
  room_goto(rLink2_EnRoad)
else if tTileLeft=16
  room_goto(rLink2_EnGrass)
else if tTileLeft=32
  room_goto(rLink2_EnDesert)
else if tTileLeft=48
  room_goto(rLink2_EnForest)
