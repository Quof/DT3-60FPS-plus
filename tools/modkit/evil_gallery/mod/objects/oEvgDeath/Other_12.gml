//Evil Boss Gallery: Death's Slash C (large arc curved up), with his evil sprites -- Intended for player to duck

atkSwingTime+=1*atkSwingScale*gDeltaTime
if atkSwingTime<=2
{
  sprite_index=sEvgDeathReadyC
}
else if atkSwingTime>=24 and atkSwingTime<=26 and bSwing=0
{
  playSound(global.snd_DeathSlash,0,0.97,35000)
  sprite_index=sEvgDeathSwingB
  image_index=0
  var newAtk;
  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashC; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(2*upwardSizeScale)*image_xscale; newAtk.image_yscale=2*(upwardSizeScale/1.25)

  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashC; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=upwardSizeScale*image_xscale; newAtk.image_yscale=upwardSizeScale/1.25

  //Straight up swing
  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashC; newAtk.atkPower=atkPower
  newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.34*atkSwingScale
  newAtk.image_xscale=(2*upwardSizeScale)*image_xscale; newAtk.image_yscale=2*(upwardSizeScale/1.25)
  if image_xscale=1 {newAtk.image_angle=45}
  else {newAtk.image_angle=315}
  bSwing=1
}
else if atkSwingTime>=33
{
  sprite_index=sEvgDeathWalk
  atkSwingTime=0
  atkSwingType=-1
  bSwing=0
}
