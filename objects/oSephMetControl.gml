#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
XXA=oSephiroth.xCenter-oSephiroth.roomSpan-112
XXB=oSephiroth.xCenter+oSephiroth.roomSpan+112
metRounds=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  meteorTime-=1
  if meteorTime mod meteorFreq=0
  {
    var tNewAttack;
    tNewAttack=instance_create(XXA,-38,oSephMeteor)
    tNewAttack.atkPower=oSephiroth.atkPower; tNewAttack.moveSpd=8; tNewAttack.direction=315
    tNewAttack=instance_create(XXB,-38,oSephMeteor)
    tNewAttack.atkPower=oSephiroth.atkPower; tNewAttack.moveSpd=8; tNewAttack.direction=225

    XXA+=24
    XXB-=24
    metRounds+=1
    if metRounds>=5
    {
      XXA=oSephiroth.xCenter-oSephiroth.roomSpan-112+(metRounds*24)
      XXB=oSephiroth.xCenter+oSephiroth.roomSpan+112-(metRounds*24)
      metRounds=0
    }
  }

  if meteorTime<=0 {instance_destroy()}
}
