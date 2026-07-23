#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=2

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2

decayTime=130
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  decayTime-=1
  if decayTime=128
  {
    if room=rLowFacG
    {
      if type=1 //Spawn to right
      {
        var tFloorFlame;
        tFloorFlame=instance_create(x+18,oBladeBot.yGround,oBBot_FloorFlame)
        tFloorFlame.atkPower=atkPower
        if x>=oBladeBot.xCenter+oBladeBot.roomSpan-8 {tFloorFlame.type=0}
        else {tFloorFlame.type=1}
      }
      else if type=2 //Spawn to left
      {
        var tFloorFlame;
        tFloorFlame=instance_create(x-18,oBladeBot.yGround,oBBot_FloorFlame)
        tFloorFlame.atkPower=atkPower
        if x<=oBladeBot.xCenter-oBladeBot.roomSpan+8 {tFloorFlame.type=0}
        else {tFloorFlame.type=2}
      }
    }
    else if room=rLowFacR
    {
      if type=1 //Spawn to right
      {
        var tFloorFlame;
        tFloorFlame=instance_create(x+18,oCACA_Main.yGround,oBBot_FloorFlame)
        tFloorFlame.atkPower=atkPower
        if x>=oCACA_Main.xCenter+oCACA_Main.roomSpan-8 {tFloorFlame.type=0}
        else {tFloorFlame.type=1}
      }
      else if type=2 //Spawn to left
      {
        var tFloorFlame;
        tFloorFlame=instance_create(x-18,oCACA_Main.yGround,oBBot_FloorFlame)
        tFloorFlame.atkPower=atkPower
        if x<=oCACA_Main.xCenter-oCACA_Main.roomSpan+8 {tFloorFlame.type=0}
        else {tFloorFlame.type=2}
      }
    }
  }
  else if decayTime<=0 {instance_destroy()}
}
