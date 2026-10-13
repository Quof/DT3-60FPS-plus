var tNewAttack,tPDirChk;
if room!=rBT_Cousinoer5DeathEX
{
if oDeath.image_xscale=1
  tPDirChk=0
else
  tPDirChk=180
}
else
{
if oDeathEX.image_xscale=1
  tPDirChk=0
else
  tPDirChk=180  
}

tNewAttack=instance_create(other.x,other.y,oPassBullet)
tNewAttack.sprite_index=other.sprite_index; tNewAttack.atkPower=4
tNewAttack.bulletSpeed=15; tNewAttack.decayTime=-100; tNewAttack._direction=tPDirChk

with other {instance_destroy()}
