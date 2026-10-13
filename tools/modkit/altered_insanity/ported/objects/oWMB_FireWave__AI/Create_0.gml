warTarget=oCHAOS_Warmaster_Main
if room=rWarshipZ_E3
{
  if global.bBossGallery=1 {warTarget=oCHAOS_Warmaster_EX}
  else {warTarget=oFedex}
}
else if room=rBT_WarmasterA {warTarget=oCHAOS_Warmaster_Fixed}

else if room=rBT_Cousinoer5Warmechster_EX {warTarget=oCHAOS_Warmaster_EX}
else if room=rBT_Cousinoer5Warmechster_EXEX {warTarget=oFedex}

else if room=rBT_Cousinoer5ChaoWarmaster {warTarget=oChaoWarmaster}
else if room=rBT_Cousinoer5ChaoWarmasterEX {warTarget=oChaoWarmaster_EX}
else if room=rBT_Cousinoer5ChaoWarmasterEXEX {warTarget=oFedexChao}

//Flame Ground Trail
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkTime=0
if warTarget.DIFFICULTY=1 {moveSpd=7}
else
{
  moveSpd=8
  if warTarget=oCHAOS_Warmaster_EX
  {
    if oCHAOS_Warmaster_EX.ATTACK_FORM=2
    {
      if image_xscale=1.1 {moveSpd=13}
      else if image_xscale=1.3 {moveSpd=11}
      else if image_xscale=1.6 {moveSpd=9}
    }
  }
  else if warTarget=oFedex
  {
    if oFedex.ATTACK_FORM=2
    {
      if image_xscale=1.1 {moveSpd=13}
      else if image_xscale=1.3 {moveSpd=11}
      else if image_xscale=1.6 {moveSpd=9}
    }
  }
  else if warTarget=oFedexChao
  {
    if oFedexChao.ATTACK_FORM=2
    {
      if image_xscale=1.1 {moveSpd=13}
      else if image_xscale=1.3 {moveSpd=11}
      else if image_xscale=1.6 {moveSpd=9}
}
  }
}
