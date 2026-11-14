//Evil Boss Gallery: Evil Aqua Serpent (rLink2_PalaceW_12: the game's Aqua Serpent made this by the fight's controller,
//oEvgFight). Its own fight (its Step: its swims around and over the platform), with 4900 life instead of 3500, and
//every other time it finishes a swim (off the arena, moveProg back to 0), one of these first (user event 3, in turn):
//  1 tidal wave    the water heaves up at the platform's far end, then a wave 40 high rolls across it (oEvgTidalWave): a
//                  full jump clears it. One from each side, one after the other, from its third phase
//  2 spiral rings  its head rises out of the water under the platform and spits rings of shots up through it, each
//                  ring with a gap (where to stand), the gap moving each ring
//  3 undertow      the water drags the player toward the platform's far end (walk against it) while water spouts come up
//                  under them, one after another
if !variable_local_exists("evgOn")
{
  evgOn=1
  eName="Evil Aqua Serpent"
  maxLife=4900
  life=maxLife
  evgMove=0
  evgT=0
  evgStage=0
  evgEnds=0
  evgArmed=0
  evgPat="123"
  evgPatPos=0
  waveNum=0
  waveLeft=1
  ringNum=0
  ringGap=0
  pullDir=1
  spoutNum=0
  jeremyText="It's controlling the water itself now. When the water heaves at one end, a wave's coming: jump it. When its head comes up under the platform, its shots come in rings, so find the gap. And when the water starts pulling, walk against it and keep moving, because the spouts follow you."
}
if global.gamePaused=false and bActive=true and life>0
{
  if moveProg>=1 {evgArmed=1}
  if evgMove=0 and evgArmed=1 and moveProg<=0 and moveProg>-1
  {
    evgArmed=0
    evgEnds+=1
    if (evgEnds mod 2)=0
    {
      if evgPatPos>=string_length(evgPat) {evgPatPos=0}
      evgMove=real(string_char_at(evgPat,evgPatPos+1))
      evgPatPos+=1
      evgT=0
      evgStage=0
    }
  }
}

if evgMove>0 and global.gamePaused=false and bActive=true and life>0
{
  speed=0
  event_user(3)
  enemyStepEvent()
}
else {event_inherited()}
