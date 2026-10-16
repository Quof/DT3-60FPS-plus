//Evil Boss Gallery: the game over screen's hint in an evil fight (argument0 0: the bosses' hints, which the game has
//set from the boss's name by now). One of the boss's, in turn with the deaths there (rmDeaths)
if argument0=0
{
  var k;
  k=global.rmDeaths mod 3
  if room=rEvgBowser
  {
    if k=0 {hintMessage="When the floor starts to glow, find a Paratroopa. Hold jump as you land on one and you'll bounce right back up."}
    else if k=1 {hintMessage="Up at the ceiling he follows you, but once he flashes he's committed. Move then, and hop his shockwaves."}
    else {hintMessage="Hammers fly past whoever stands close to him. Close, not touching."}
  }
  else if room=rEvgHelmet
  {
    if k=0 {hintMessage="Red helmets shrug off the sword: shoot them. Blue helmets throw arrows back: cut them."}
    else if k=1 {hintMessage="A helmet coming down on you can be knocked out of the air. Then hit it while it's dazed."}
    else {hintMessage="His shield only covers his front. Jump over the charge and get him from behind."}
  }
  else if room=rEvgDeath
  {
    if k=0 {hintMessage="Holy water breaks his pentagram. Its fire burns his sickles out of the air too."}
    else if k=1 {hintMessage="You can't outrun the phantoms. Dash through them."}
    else {hintMessage="When he starts pulling you in, dash away, or break it with holy water."}
  }
}
