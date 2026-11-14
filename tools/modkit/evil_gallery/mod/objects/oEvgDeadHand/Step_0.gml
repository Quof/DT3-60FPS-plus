//Evil Boss Gallery: Evil Dead Hand (rLink2_PalaceF_12: the game's Dead Hand made this by the fight's controller,
//oEvgFight). Its own fight (its Step), with 5600 life instead of 4000 and these besides, each tied to a turn of its
//rise-creep-sink cycle (evgCyc, counted as it comes up):
//  1 claw wave    just risen, it slams the ground (a rumble at its feet), and claws burst up along the floor away from
//                 it both ways (oEvgClawWave, 26 high): jump them, or be up on a block
//  2 ambush       its next rise: the floor rumbles under the player (a dark ring, 24 ticks), then it bursts up there,
//                 high (in the air the sword does double, as the game's jump), and creeps from where it lands
//  3 gravebound   (from its third phase) its next sink stops at its head: it can't be hurt but by bombs, and hands
//                 come faster. A bomb's blast on it yanks it out, stunned (75 ticks, every hit double); left alone, it
//                 sinks after 200 ticks
if !variable_local_exists("evgOn")
{
  evgOn=1
  eName="Evil Dead Hand"
  maxLife=5600
  life=maxLife
  evgMove=0
  evgT=0
  evgStage=0
  evgCyc=0
  evgPrev=atkSequence
  evgAmbush=0
  evgGrave=0
  ambX=0
  graveHands=0
  jeremyText="It's learned to hunt. It'll come up right under you, so watch for the ground shaking at your feet and move. The claws it sends along the floor can be jumped. And when it digs in with only its head showing, nothing touches it but a bomb, so feed it one and it'll come flying out."
}
if global.gamePaused=false and bActive=true and life>0
{
  //---------- where its cycle meets an evil move ----------
  if evgMove=0
  {
    if atkSequence=2 and evgPrev=0 //(just come up out of the ground)
    {
      evgCyc+=1
      if (evgCyc mod 3)=1 {evgMove=1}
      else if (evgCyc mod 3)=2 {evgAmbush=1}
      else if bossProgress>=2 and bPoeActive=0 {evgGrave=1}
    }
    if atkSequence=0 and evgPrev=5 and evgAmbush=1 {evgAmbush=0; evgMove=2}
    if atkSequence=4 and evgPrev!=4 and evgGrave=1 {evgGrave=0; evgMove=3}
    if evgMove>0 {evgT=0; evgStage=0}
  }
  evgPrev=atkSequence
}

if evgMove>0 and global.gamePaused=false and bActive=true and life>0
{
  event_user(3)
  enemyStepEvent()
}
else {event_inherited()}
