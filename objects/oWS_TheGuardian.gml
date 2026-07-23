#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="The Guardian"
eLevel=39
maxLife=1000
life=maxLife
pointWorth=50
atkPower=14
moneyWorth=0
affiliation=7

attackProg=0
frameProg=0

jeremyText="This has a simple attack cycle. First it spins, then the eye flashes, and then it will open. After this, it attacks, then it closes and repeats."
chaoText="This sprite was made by a turnip named Rena (aka Tavi). Huh, didn't know turnips had names."
devText="No Dev Commentary at this time."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)

  if bActive=1
  {
    frameProg+=1
    if attackProg=0 //Spin [Animation]
    {
      if frameProg=3 {image_index=2}
      else if frameProg=6 {image_index=3}
      else if frameProg=9 {image_index=4}
      else if frameProg=12 {image_index=0}
      else if frameProg=16 {frameProg=0; attackProg+=1}
    }
    else if attackProg=1 //Flash Eye [Animation]
    {
      if frameProg=3 {image_index=0}
      else if frameProg=6 {image_index=1}
      else if frameProg=9 {image_index=0}
      else if frameProg=12 {image_index=1}
      else if frameProg=15 {image_index=0}
      else if frameProg=19 {frameProg=0; attackProg+=1}
    }
    else if attackProg=2 //Open [Animation]
    {
      if frameProg=2 {image_index=5}
      else if frameProg=4 {image_index=6}
      else if frameProg=6 {image_index=7}
      else if frameProg=8 {image_index=8}
      else if frameProg=10 {image_index=9}
      else if frameProg=12 {image_index=10}
      else if frameProg=14 {image_index=11}
      else if frameProg=16 {image_index=12}
      else if frameProg=18 {image_index=13}
      else if frameProg=20 {image_index=14}
      else if frameProg=26 {frameProg=0; attackProg+=1}
    }
    else if attackProg=3 //Attack [Behavior]
    {
      if frameProg=3
      {
        var tNewAttack,tDir;
        tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        for(i=0;i<6;i+=1)
        {
          tNewAttack=instance_create(x,y,oPassBullet)
          tNewAttack.sprite_index=sHexWormLaser; tNewAttack.atkPower=atkPower; tNewAttack.direction=tDir
          tDir+=360/6
          if i=0 {tNewAttack.bulletSpeed=7; tNewAttack.decayTime=90}
          else {tNewAttack.bulletSpeed=4; tNewAttack.decayTime=120}
        }
      }
      else if frameProg=6 {frameProg=0; attackProg+=1}
    }
    else if attackProg=4 //Close [Animation] [Restart Cycle]
    {
      if frameProg=3 {image_index=15}
      else if frameProg=6 {image_index=0}
      else if frameProg=10 {frameProg=0; attackProg=0}
    }
  }
  enemyStepEvent()
}
