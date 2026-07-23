#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpd,turnDelay,turnAmt
event_inherited()
image_speed=0.33

//Enemy base statistics
eName="Bomber Cloud"
eLevel=36
maxLife=220
life=maxLife
pointWorth=66
atkPower=13
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
resType[4]=3
stunResist=50
baseItemChance=90
moneyWorth=5

turnTime=0
atkTime=0

jeremyText="This has the same pattern as the Bomber Bat. Its attack is a lingering cloud that it deposits every 64 pixels...#Hey man, I'm just giving you exact details."
chaoText="It was weird being able to see everything you two were doing here, but not being able to interact at all. I was kinda hoping you two would think we couldn't see and that you'd make out... Just being honest with you guys."
devText="Moment of truth. This Bomberman bit was a sudden idea that occurred while drawing up the map for this level. Did a quick addon to the Morph Bombs for just this moment, especially since the bomb jump is never used in this level. It's a quick and short bit that I quite liked."
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
    speed=moveSpd
    turnTime+=1
    if turnTime>=turnDelay
    {
      direction+=turnAmt
      turnTime=0
    }

    atkTime+=1
    if atkTime>=64/moveSpd
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sMMSmokeCloud; newAttack.decayTime=round((192/moveSpd)*1.25)
      newAttack.image_xscale=5; newAttack.image_yscale=5; newAttack.image_alpha=0.7; newAttack.depth=26
      atkTime=0
    }
  }
  enemyStepEvent()
}
else {speed=0}
