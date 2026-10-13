if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  oPlayer1.life=oPlayer1.maxLife
  global.pLife=global.pMaxLife
  global.pGreenLife=0
  var tEquipA;
  tEquipA=0
  if global.alterEquip=0
  {
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=20
    {
      tEquipA=15
      break;
        }
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

  playSound(global.snd_HealingPlant,0,1,1)
  var tEffect;
  tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
  tEffect.sprite_index=sHeal
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
