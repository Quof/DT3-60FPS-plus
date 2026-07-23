#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_black
fadeAlpha=0
followBack=0

abilSetRemove(1)
oPlayer1.visible=0
background_xscale[0]=2
background_yscale[0]=2
background_hspeed[0]=-12
background_hspeed[1]=-12

timeline_index=tl_RoadRage
if global.bossTrack=1 {timeline_position=4520}

if global.optShowDamage<2
{
  global.optShowDamage+=2
  global.optEnemyHP+=2
}

if global.gameProgress=3340 {fadeAlpha=1}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  timeline_running=1
  if global.gameProgress=3360 //----- [] Road rage -----
  {
    with oZakoCannonfodder {x-=12}
    if sceneProgress=0
    {
      oPlayer1.bCanTakeDamage=false
      spawnTime=0
      spawnDelay=2+irandom(8)
      sceneProgress+=1
    }
    else if sceneProgress=1
    {
      spawnTime+=1
      if spawnTime>=spawnDelay and sceneDelay<=150
      {
        spawnTime=0
        var tEnemy;
        tEnemy=instance_create(496,320,oZakoCannonfodder)
        tEnemy.bActive=1
        spawnDelay=2+irandom(8)
      }
      sceneDelay+=1
      if sceneDelay>=210
      {
        global.gamePaused=true
        with oAttackBase {instance_destroy()}
        sceneDelay=0; sceneProgress=10
      }
    }
  }
}
else
{
  timeline_running=0
  if global.gameProgress=3340 //----- [Unskippable] Truck Tutorial -----
  {
    if sceneProgress=0
    {
      sceneDelay+=1
      if sceneDelay=1 {global.gamePaused=true}
      else if sceneDelay>=30
      {
        if fadeAlpha>0 {fadeAlpha-=0.02}
        else if fadeAlpha<=0 {sceneDelay=0; sceneProgress+=1}
      }
    }
    else if sceneProgress=1 and bWaitForInput=false
      msgCreate(0,0,"Jerry","What are we doing?!",0,3,oMessageCutscene,1)
    else if sceneProgress=2 and bWaitForInput=false
      msgCreate(0,0,"Claire","What else? Bashing through anything that gets in the way!",0,3,oMessageCutscene,1)
    else if sceneProgress=3 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","They've got a sizable force set up to block your exit from the city.",0,3,oMessageCutscene,1)
    else if sceneProgress=4 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Here's how to work that truck properly...#[Left]/[Right]: Maneuver truck#[Up]/[Down]: Rotate turret#[Jump]: Fire turret     [Action A]: Bomb toss",0,3,oMessageCutscene,1)
    else if sceneProgress=5 and bWaitForInput=false
      msgCreate(0,0,"Jeremy","Something important to keep in mind. The truck itself is immune to damage, as is Claire. Jerry, you're still vulnerable to damage though. His life is in your hands, Claire.",0,3,oMessageCutscene,1)
    else if sceneProgress=6 and bWaitForInput=false
      msgCreate(0,0,"Jerry","Now that's a scary thought.",0,3,oMessageCutscene,1)
    else if sceneProgress=7 and bWaitForInput=false
      msgCreate(0,0,"Claire","Oh shut it, Jerry. You know I've got this.",0,3,oMessageCutscene,1)
    else if sceneProgress=8
    {
      sceneDelay=0; sceneProgress=0
      global.gameProgress=3350
      global.gamePaused=false
    }
  }
  else if global.gameProgress=3350 //----- [Unskippable] End boss -----
  {
    if global.bossTrack=1
    {
      if sceneProgress=1
      {
        awardBossAP(1500)
        sceneProgress=0
        global.bossTrack=2
      }
    }
    else if global.bossTrack=2
    {
      if sceneProgress=0
      {
        sceneDelay+=1
        if sceneDelay>=20 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=1 and bWaitForInput=false
        msgCreate(0,0,"Claire","Okay, hold on Jerry. We gotta go fast!",0,3,oMessageCutscene,1)
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay>=20
        {
          sceneDelay=0; sceneProgress=0
          global.gameProgress=3360
          global.bossTrack=0
          global.currentBoss=""
          global.gamePaused=false
        }
      }
    }
  }
  else if global.gameProgress=3360 //----- [Unskippable] End sequence -----
  {
    if sceneProgress=10
    {
      oTeamTruck.x+=12
      if oTeamTruck.x>=560 {sceneProgress+=1}
    }
    else if sceneProgress=11
    {
      sceneDelay+=1
      if sceneDelay>=30
      {
        if fadeAlpha<1 {fadeAlpha+=0.02}
        else if fadeAlpha=1
        {
          global.activeCharacter=0
          global.newMapX=512
          global.newMapY=224
          room_goto(rMain_56)
        }
      }
    }
  }
}

keyWaitForInput()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
