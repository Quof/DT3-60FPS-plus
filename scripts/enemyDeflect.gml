/*
This script checks if the player's projectile should be deflected or deal damage to the object.
(When attacking from the front)
use: enemyDeflect(NORMAL,PIERCE,ELEMENTAL,SHOT,EXPLOSION,SPECIAL)
Returns true if deflection occurs.
*/
var tType0,tType1,tType2,tType3,tType4,tType5;
tType0=argument0
tType1=argument1
tType2=argument2
tType3=argument3
tType4=argument4
tType5=argument5

var chkDeflect;
chkDeflect=0

if other.damageType="NORMAL" and tType0=1
{
  if (image_xscale=1 and x<other.x) or (image_xscale=-1 and x>other.x)
  {
    chkDeflect=1
  }
}
else if other.damageType="PIERCE" and tType1=1
{
  if (image_xscale=1 and x<other.x) or (image_xscale=-1 and x>other.x)
  {
    chkDeflect=1
  }
}
else if other.damageType="ELEMENTAL" and tType2=1
{
  if (image_xscale=1 and x<other.x) or (image_xscale=-1 and x>other.x)
  {
    chkDeflect=1
  }
}
else if other.damageType="SHOT" and tType3=1
{
  if (image_xscale=1 and x<other.x) or (image_xscale=-1 and x>other.x)
  {
    chkDeflect=1
  }
}
else if other.damageType="EXPLOSION" and tType4=1
{
  if (image_xscale=1 and x<other.x) or (image_xscale=-1 and x>other.x)
  {
    chkDeflect=1
  }
}
else if other.damageType="SPECIAL" and tType5=1
{
  if (image_xscale=1 and x<other.x) or (image_xscale=-1 and x>other.x)
  {
    chkDeflect=1
  }
}

/*if other.damageType="NORMAL" and tType0=1
{
  if image_xscale!=other.initFireDir
  {
    chkDeflect=1
  }
}
else if other.damageType="PIERCE" and tType1=1
{
  if image_xscale!=other.initFireDir
  {
    chkDeflect=1
  }
}
else if other.damageType="ELEMENTAL" and tType2=1
{
  if image_xscale!=other.initFireDir
  {
    chkDeflect=1
  }
}
else if other.damageType="SHOT" and tType3=1
{
  if image_xscale!=other.initFireDir
  {
    chkDeflect=1
  }
}
else if other.damageType="EXPLOSION" and tType4=1
{
  if image_xscale!=other.initFireDir
  {
    chkDeflect=1
  }
}
else if other.damageType="SPECIAL" and tType5=1
{
  if image_xscale!=other.initFireDir
  {
    chkDeflect=1
  }
}*/

if chkDeflect=1
{
  if other.bCanPierce=0
  {
    with other {instance_destroy()}
  }
}
return chkDeflect
