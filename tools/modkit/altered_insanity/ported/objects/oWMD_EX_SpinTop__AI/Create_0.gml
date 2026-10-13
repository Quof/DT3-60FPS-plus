if global.bBossGallery=1 {warTarget=oCHAOS_Warmaster_EX}
else if room=rBT_Cousinoer5Warmechster_EX {warTarget=oCHAOS_Warmaster_EX}
else if room=rBT_Cousinoer5ChaoWarmaster {warTarget=oChaoWarmaster}
else if room=rBT_Cousinoer5ChaoWarmasterEX {warTarget=oChaoWarmaster_EX}
else if room=rBT_Cousinoer5ChaoWarmasterEXEX {warTarget=oFedexChao}
else {warTarget=oFedex}

//Top
event_inherited()
image_speed=0.33
image_angle=270

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"
size=2
myDist=16
