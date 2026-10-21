//Randomizer: every frame, the abilities the game turned on are the ones the player has found (rndAbilClamp); not in the
//boss gallery's own fights, which give their bosses' abilities. In Central City - South, the heart container the 7th
//trial gives comes as the trial ends (rndHC7). An Archipelago game trades with the DT3+ Client (rndApPoll). The
//trackers' state is written once something in it has changed (rndTrackWrite)
if global.rndActive=1
{
  if global.rndTrackDirty=1 {global.rndTrackDirty=0; rndTrackWrite()}
  //the Abomination beaten (its fight the game's own: gateHProg 200): its AP once the player is in the next room
  //(rndBossAPAward: the game gives none for it here, so a level's worth)
  if global.rndAbomAPSeen=0 {if global.gateHProg>=200 {global.rndAbomAPSeen=1; global.rndBossAPPending=-2}}
  if !(global.bBossGallery=1 and global.rndFight<0) {rndAbilClamp()}
  //(the ability sets the player has picked, outside an area that took them away and outside fights: picked again as
  //the area's left, the roomStart hook)
  if global.rndAbilGroup="" and global.rndFight<0 and global.bBossGallery=0 and global.activeCharacter<2
  {
    global.rndActSave[0]=global.activeAbility[0]
    global.rndActSave[1]=global.activeAbility[1]
    //(and each character's last set other than Gate 6's Game Powers, to go back to as Gate 6 is left: rndPickSets)
    if global.activeAbility[0]=1 or global.activeAbility[0]=2 {global.rndActReg[0]=global.activeAbility[0]}
    if global.activeAbility[1]=1 or global.activeAbility[1]=2 {global.rndActReg[1]=global.activeAbility[1]}
  }
  if room=rCCity_SGrove {rndHC7()}
  if global.rndAP=1 {rndApPoll()}
  if instance_exists(oPlayer1)
  {
    //in a randomizer boss fight: where the player is (they come back there once the boss is beaten: rndBossEnd). In one
    //with another fight after it (rndBossChainN), their life and ammo, which the next one starts with (rndBossNextLink:
    //the boss gallery the game goes back to in between refills them)
    if global.rndFight>=0
    {
      if room=global.rndBossRoom[global.rndFight] {global.rndFightLastX=oPlayer1.x; global.rndFightLastY=oPlayer1.y}
      if global.rndFightLink<global.rndBossChainN[global.rndFight] and room!=rBossGallery
      {
        global.rndChainSt[0]=oPlayer1.life
        global.rndChainSt[1]=global.hudLink_Arrows[0]
        global.rndChainSt[2]=global.hudBelmont_WeaponEn[0]
        global.rndChainSt[3]=global.hudSamus_Missiles[0]
        global.rndChainSt[4]=global.hudGame_WeaponEn[0]
      }
    }
    //in the room of a boss not beaten yet (the roomStart hook): the player walking up to where its fight starts (level
    //with it, and reaching it from the side they came in on), or one that starts as the room's come into, starts it.
    //The room starts again with the fight in it, the player where it starts (with Boss Rando, the fight of the boss
    //fought there: its own room)
    else if global.rndRoomBoss>=0 and global.bBossGallery=0 and global.gamePaused=false
    {
      var b,tGo;
      b=global.rndRoomBoss
      tGo=global.rndBossOnEntry[b]
      if abs(oPlayer1.y-global.rndBossFY[b])<96
      {
        if global.rndRoomSide=0 {tGo=1}
        else if global.rndRoomSide<0 and oPlayer1.x>=global.rndBossFX[b]-16 {tGo=1}
        else if global.rndRoomSide>0 and oPlayer1.x<=global.rndBossFX[b]+16 {tGo=1}
      }
      //(the fight just given up, rndBossEnd: not again while the player's still where it starts; once they've stepped
      //out of it, as any other time)
      if global.rndFightGrace=b
      {
        if tGo=1 {tGo=0}
        else {global.rndFightGrace=-1}
      }
      if tGo=1
      {
        global.rndRoomBoss=-1
        rndBossStart(b,room,-1,-1)
        global.newMapX=global.rndBossX[global.rndFight]
        global.newMapY=global.rndBossY[global.rndFight]
        with (oPlayer1) {writeToPlayerGlobals()}
        transition_kind=0
        if global.rndBossRoom[global.rndFight]=room {room_restart()}
        else {room_goto(global.rndBossRoom[global.rndFight])}
      }
    }
    //the CHAOS Warmaster's place before the Abomination is beaten (the roomStart hook): walking up to it says what his
    //fight waits for, once a visit
    else if global.rndRoomWait>=0 and global.bBossGallery=0 and global.gamePaused=false
    {
      var w;
      w=global.rndRoomWait
      if abs(oPlayer1.y-global.rndBossFY[w])<96 and abs(oPlayer1.x-global.rndBossFX[w])<64
      {
        global.rndRoomWait=-1
        rndMsg("The CHAOS Warmaster isn't here yet.#He comes once the Abomination is beaten (all 8 instruments).",2)
      }
    }
  }
  //(the trap items' time, and a Teleport Trap waiting: rndSnareTick)
  rndSnareTick()
  //(the character the player is: a room whose code switches it as they come in switches back to this, the roomStart
  //hook)
  global.rndCharSeen=global.activeCharacter
}
