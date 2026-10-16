//Evil Boss Gallery: Death's Slash B (large arc forward), with his evil sprites -- Intended for player to dash behind Death

atkSwingTime+=1*atkSwingScale*gDeltaTime
if atkSwingTime<=2
{
  sprite_index=sEvgDeathReadyB
}
else if atkSwingTime>=30 and atkSwingTime<=32 and bSwing=0
{
  playSound(global.snd_DeathSlash,0,0.97,25000)
  sprite_index=sEvgDeathSwingB
  image_index=1
  var newAtk,tTooFar;
  tTooFar=1
  if chkMove>=192 and chkMove<=351 {tTooFar=1.5}
  else if chkMove>=352 {tTooFar=2}

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(3.1*forwardSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.5*forwardSizeScale)*tTooFar

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(2.325*forwardSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.375*forwardSizeScale)*tTooFar

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(1.55*forwardSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.25*forwardSizeScale)*tTooFar

  newAtk=instance_create(x,y-24,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashB; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=forwardSizeScale*tTooFar*image_xscale; newAtk.image_yscale=forwardSizeScale*tTooFar
  bSwing=1
}
else if atkSwingTime>=39
{
  sprite_index=sEvgDeathWalk
  atkSwingTime=0
  atkSwingType=-1
  bSwing=0
}
