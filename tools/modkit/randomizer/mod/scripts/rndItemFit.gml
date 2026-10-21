//Randomizer: a pickup that has just taken its item's look (rndItemLook) stands as its own sprite did (argument0: the
//pickup's own sprite; argument1: its frame, -1 when it animates). The sprites' opaque pixels from their origins are in
//rndData (rndSprU*: all frames, rndSprF*: each). One that falls (setCollisionBounds: the keys, the starting items)
//lands on its look's bottom. One on the ground, or whose look would reach into it, has its look's bottom where its own
//sprite's was, centred where it was; one under a ceiling whose look would reach up into it has its look's top where
//its own sprite's was (Motor Desert 1's weapon upgrade spot: a skill point there was in the ceiling, out of reach);
//one in the air stays as it is. One hidden below the room till a trial is done
//(its creation code moved it down by room_height; oNPC_ChallengeMaster moves it back) is fitted where it will be
var os,of,nf,ol,orr,ob,ot,nl,nr,nt,nb,tMid,tMove,ty;
os=argument0
of=argument1
if os<0 or sprite_index<0 or os>global.rndSprMax or sprite_index>global.rndSprMax {exit}
if global.rndSprK[os]=0 or global.rndSprK[sprite_index]=0 {exit}
if of<0 or of>=global.rndSprN[os] {ol=global.rndSprUL[os]; orr=global.rndSprUR[os]; ob=global.rndSprUB[os]; ot=global.rndSprUT[os]}
else {ol=global.rndSprFL[os,of]; orr=global.rndSprFR[os,of]; ob=global.rndSprFB[os,of]; ot=global.rndSprFT[os,of]}
nf=floor(image_index)
if image_speed>0 or nf>=global.rndSprN[sprite_index]
{
  nl=global.rndSprUL[sprite_index]; nr=global.rndSprUR[sprite_index]; nt=global.rndSprUT[sprite_index]; nb=global.rndSprUB[sprite_index]
}
else
{
  nl=global.rndSprFL[sprite_index,nf]; nr=global.rndSprFR[sprite_index,nf]; nt=global.rndSprFT[sprite_index,nf]; nb=global.rndSprFB[sprite_index,nf]
}
//one that falls: its collision box (as wide as the game's, -6 to 6) under its look, ending at the look's bottom row
if variable_local_exists("collisionBoundsOffsetBottomY")
{
  tMid=round((nl+nr)/2)
  setCollisionBounds(tMid-6,nt,tMid+6,nb+1)
  exit
}
ty=y
if ty>room_height {ty-=room_height}
tMove=0
if collision_rectangle(x+ol,ty+ob-1,x+orr,ty+ob+3,oSolid,1,1)!=noone {tMove=1}
else if collision_rectangle(x+ol,ty+ob-1,x+orr,ty+ob+3,oPlatform,1,1)!=noone {tMove=1}
else if nb>ob {if collision_rectangle(x+nl,ty+ob+1,x+nr,ty+nb,oSolid,1,1)!=noone {tMove=1}}
if tMove=1
{
  x+=round((ol+orr)/2-(nl+nr)/2)
  y+=ob-nb
}
//(under a ceiling: the look's top where its own sprite's was, when it would reach up into a solid its own didn't)
else if nt<ot
{
  if collision_rectangle(x+nl,ty+nt,x+nr,ty+ot-1,oSolid,1,1)!=noone
  {
    x+=round((ol+orr)/2-(nl+nr)/2)
    y+=ot-nt
  }
}
