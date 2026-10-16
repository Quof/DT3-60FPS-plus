//Evil Boss Gallery: Death's Slash A (spin), with his evil sprites -- Intended for player to jump

atkSwingTime+=1*atkSwingScale*gDeltaTime
if atkSwingTime<=2
{
  sprite_index=sEvgDeathReadyA
}
else if atkSwingTime>=24 and atkSwingTime<=26 and bSwing=0
{
  playSound(global.snd_DeathSlash,0,0.97,30000)
  sprite_index=sEvgDeathSwingA
  var newAtk,tTooFar;
  tTooFar=1
  if chkMove>=192 and chkMove<=351 {tTooFar=1.25}
  else if chkMove>=352 {tTooFar=1.5}

  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashA
  newAtk.atkPower=atkPower; newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.25*atkSwingScale
  newAtk.image_xscale=(1.75*spinSizeScale)*tTooFar*image_xscale; newAtk.image_yscale=(1.75*spinSizeScale)*tTooFar

  newAtk=instance_create(x,y-26,oDeathScytheAtk)
  newAtk.sprite_index=sEvgDeathScytheSlashA
  newAtk.atkPower=atkPower; newAtk.decay=round(10/atkSwingScale); newAtk.atkSpd=0.25*atkSwingScale
  newAtk.image_xscale=spinSizeScale*tTooFar*image_xscale; newAtk.image_yscale=spinSizeScale*tTooFar
  bSwing=1
}
else if atkSwingTime>=33
{
  sprite_index=sEvgDeathWalk
  atkSwingTime=0
  atkSwingType=-1
  bSwing=0
}
