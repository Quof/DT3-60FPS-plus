//Randomizer: every frame, the abilities the game turned on are the ones the player has found (rndAbilClamp); not in the
//boss gallery's own fights, which give their bosses' abilities. In Central City - South, the heart container the 7th
//trial gives comes as the trial ends (rndHC7). An Archipelago game trades with the DT3+ Client (rndApPoll)
if global.rndActive=1
{
  if !(global.bBossGallery=1 and global.rndFight<0) {rndAbilClamp()}
  if room=rCCity_SGrove {rndHC7()}
  if global.rndAP=1 {rndApPoll()}
  if instance_exists(oPlayer1)
  {
    //in a randomizer boss fight: where the player is (they come back there once the boss is beaten: rndBossEnd)
    if global.rndFight>=0
    {
      if room=global.rndBossRoom[global.rndFight] {global.rndFightLastX=oPlayer1.x; global.rndFightLastY=oPlayer1.y}
    }
    //in the room of a boss not beaten yet (the roomStart hook): the player walking up to where its fight starts (level
    //with it, and reaching it from the side they came in on), or one that starts as the room's come into, starts it.
    //The room starts again with the fight in it, the player where it starts
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
      if tGo=1
      {
        global.rndRoomBoss=-1
        rndBossStart(b,room,-1,-1)
        global.newMapX=global.rndBossX[b]
        global.newMapY=global.rndBossY[b]
        with (oPlayer1) {writeToPlayerGlobals()}
        transition_kind=0
        room_restart()
      }
    }
  }
}
