//Evil Boss Gallery: the helmet hit, before the damage (user event 14): its life now (for the damage, Other_25), an
//arrow on a mirror (blue) helmet to send back, and a hit while it's diving (it gets knocked down)
lifeBefore=life
reflectNow=0
diveHit=0
if polarity=1 and mode!=2 and mode!=4 and other.weaponTag=1 {reflectNow=1}
if mode=1
{
  if diveStage=1 or diveStage=2 {diveHit=1}
}
