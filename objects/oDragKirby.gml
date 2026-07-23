#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.2
#define Collision_oCHAOS_DragSeg
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.suckReady=1 and oDragoonShip.bSucking=1
{
  if other.weaponGive<100 //Weapon
  {
    playSound(global.snd_Bite,0,1,1)
    playSound(global.snd_MorphBomb,0,0.92,32000)
    if global.activeCharacter=0
    {
      oDragoonShip.shotHP_Jerry=3
      oDragoonShip.charJerryShot=other.weaponGive
      oDragoonShip.shotType=oDragoonShip.charJerryShot
    }
    else
    {
      oDragoonShip.shotHP_Claire=3
      oDragoonShip.charClaireShot=other.weaponGive
      oDragoonShip.shotType=oDragoonShip.charClaireShot
    }
  }
  else if other.weaponGive>100 and other.weaponGive<200 //Assist
  {
    playSound(global.snd_Bite,0,1,1)
    playSound(global.snd_MorphBomb,0,0.92,32000)
    if oDragoonShip.multiple<4
    {
      oDragoonShip.shipAssist[oDragoonShip.multiple]=instance_create(oDragoonShip.x,oDragoonShip.y,oDragAssist)
      oDragoonShip.shipAssist[oDragoonShip.multiple].type=other.weaponGive-100
      oDragoonShip.multiple+=1
    }
    else
    {
      oDragoonShip.shipAssist[3].type=oDragoonShip.shipAssist[2].type
      oDragoonShip.shipAssist[2].type=oDragoonShip.shipAssist[1].type
      oDragoonShip.shipAssist[1].type=oDragoonShip.shipAssist[0].type
      oDragoonShip.shipAssist[0].type=other.weaponGive-100
    }
  }
  else if other.weaponGive>200 and other.weaponGive<300 //Heart Pickup
  {
    playSound(global.snd_HealthPickup,0,1,1)
    oPlayer1.life+=8
  }

  oDragoonShip.suckTime=0

  //Suck particle effect
  var tEffect;
  tEffect=instance_create(x,y,oEffectB)
  tEffect.type=2; tEffect.sprite_index=sEnemyDieStar; tEffect.newBlend=-1; tEffect.decay=15
  tEffect.direction=90; tEffect.speed=2; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=30
  tEffect.image_xscale=2; tEffect.image_yscale=2
  for(i=0;i<6;i+=1)
  {
    tEffect=instance_create(other.x,other.y,oKillEffect)
    tEffect.speed=2.66; tEffect.direction=i*60; tEffect.friction=0.11
    tEffect.fadeAlpha=0.025; tEffect.imageRot=0
  }
  with other
  {
    if bIsBoss=0 {instance_destroy()}
    else
    {
      bCanTakeDamage=false
      bCanDealDamage=false
      life=0
    }
  }
}
