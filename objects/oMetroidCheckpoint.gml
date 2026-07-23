#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Metroid checkpoint script.
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  global.metCheckpoint[0]=room
  global.metCheckpoint[1]=x+16
  global.metCheckpoint[2]=y+32
  oPlayer1.life=oPlayer1.maxLife
  global.pLife=global.pMaxLife
  global.pCurrBreath=global.pBreathMax

  var tEquipA,tEquipB,tEquipC;
  tEquipA=0; tEquipB=0; tEquipC=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=23
    {
      tEquipA=15
      break;
    }
  }
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=21
    {
      tEquipB=10
      break;
    }
  }
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=22
    {
      tEquipC=10
      break;
    }
  }
  global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
  global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-tEquipA
  global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
  global.hudMega_BusterEn[0]=32
  global.hudMega_ShotIceEn[0]=32
  global.hudMega_GravityEn[0]=32
  global.hudSamus_CannonEn[0]=0
  global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
  global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

  playSound(global.snd_HealingPlant,0,1,0)
  var tEffect;
  tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
  tEffect.sprite_index=sHeal
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

  instance_create(0,0,oCheckpointNotice)
  instance_create(view_xview[0]+240,view_yview[0]+128,oSaveReminder)
}
