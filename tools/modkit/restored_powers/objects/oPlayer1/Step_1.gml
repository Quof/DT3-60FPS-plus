//Restored Game Powers: the two Game Powers the game has the attacks for but no button: Jerry's Scatterbomb (a pod
//that fires missiles, oJCGameSBLauncher) and Claire's Flame Shield (fireballs that circle Claire and block
//projectiles, oJCGameFlameShield; its button code is commented out in playerTechStart). Up + Action C uses them, with
//a Game Power set on; Action C alone stays Bird Swarm / Chainblade Storm. Run in the Begin Step, before the player's
//own Step reads the keys (characterStepEvent): on an Up + C press, kActC is set as already held, so that Step sees no
//new press (kActCPressed 0) and the set's own C move doesn't also go off
if player=1 and global.gamePaused=false and kKeysRead=1
{
  var tGameSet;
  tGameSet=(global.activeCharacter=0 and global.activeAbility[0]=3) or (global.activeCharacter=1 and global.activeAbility[1]=3)
  if tGameSet and kActC=0 and scrController(8) and scrButtonLocked(8)=0 and scrController(3)
  {
    kActC=1 //(the press is this mod's: the Step below sees C as held, not newly pressed)
    if bTakingDamage=false and attackState=0 and (state=STANDING or state=RUNNING or state=JUMPING or state=FALLING or state=DUCKING or state=LOOKING_UP)
    {
      var playerAttack;
      if global.activeCharacter=0 //---------- Jerry: Scatterbomb ----------
      {
        if global.hudGame_WeaponEn[0]>=50-round(50*(global.skillTree[9]*0.03))
        {
          playSound(global.snd_PlayerAtk[0],0,1,1)
          //(thrown a little forward; the launcher falls to the ground and fires a missile every 3 ticks for 75 ticks)
          playerAttack=instance_create(x+(12*image_xscale),y-12,oJCGameSBLauncher)
          playerAttack.xVel=2*image_xscale
          playerAttack.yVel=-3
          global.hudGame_WeaponEn[0]-=50-round(50*(global.skillTree[9]*0.03))
          endAbilUse(ACT_FIRE,4,1,-1)
        }
      }
      else //---------- Claire: Flame Shield (the game's own code from playerTechStart and playerTechUse) ----------
      {
        if !instance_exists(oJCGameFlameShield) //Summon Flame
        {
          if global.hudGame_WeaponEn[0]>=50-global.skillTree[12]
          {
            playSound(global.snd_PlayerAtk[0],0,1,1)
            var tDir;
            tDir=0
            for(i=0;i<24;i+=1)
            {
              playerAttack=instance_create(x+(18*image_xscale),y-8,oJCGameFlameShield)
              playerAttack.shieldDir=tDir
              if i=0 {playerAttack.sprite_index=sJCGameDragonHead}
              tDir+=360/26
            }
            global.hudGame_WeaponEn[0]-=50-round(50*(global.skillTree[12]*0.03))
            endAbilUse(ACT_FIRE,4,1,-1)
          }
        }
        else //Split Flame
        {
          with (oJCGameFlameShield) {bSplit=1}
        }
      }
    }
  }
}
