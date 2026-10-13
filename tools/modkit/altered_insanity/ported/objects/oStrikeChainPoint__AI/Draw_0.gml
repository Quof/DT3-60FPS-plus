var tDX,tDY;
tDX=floor(x+0.5); tDY=floor(y+0.5) //60fps change (added): drawn on whole pixels, like the player hanging from it (characterStepEvent) (floor(v+0.5): GM8's round() rounds .5 to the even number, so a mover on half pixels stepped 0 then 2 pixels)
if room!=rC5_NoWalkBoss
{
for(i=0;i<4;i+=1)
{
  //if i=0 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,1)}
  //else if i=1 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,1)}
  //else if i=2 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,1)}
  //else if i=3 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,1)}
  if i=0 {draw_sprite_ext(sStrikeChainPole,0,tDX+poleExtendDist,tDY-poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
  else if i=1 {draw_sprite_ext(sStrikeChainPole,0,tDX-poleExtendDist,tDY-poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
  else if i=2 {draw_sprite_ext(sStrikeChainPole,0,tDX-poleExtendDist,tDY+poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
  else if i=3 {draw_sprite_ext(sStrikeChainPole,0,tDX+poleExtendDist,tDY+poleExtendDist,1,1,i*90,image_blend,1)} //60fps change: whole pixels
}
//draw_sprite_ext(sprite_index,0,x,y,1,1,0,image_blend,1)
//if reuseTime=0 {draw_sprite(sStrikeChainColor,0,x,y)}
//else {draw_sprite(sStrikeChainColor,1,x,y)}
draw_sprite_ext(sprite_index,0,tDX,tDY,1,1,0,image_blend,1) //60fps change: whole pixels
if reuseTime=0 {draw_sprite(sStrikeChainColor,0,tDX,tDY)} //60fps change: whole pixels
else {draw_sprite(sStrikeChainColor,1,tDX,tDY)} //60fps change: whole pixels
}
else //c5 override
{
for(i=0;i<4;i+=1)
{
  //if i=0 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,image_alpha)}
  //else if i=1 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y-poleExtendDist,1,1,i*90,image_blend,image_alpha)}
  //else if i=2 {draw_sprite_ext(sStrikeChainPole,0,x-poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,image_alpha)}
  //else if i=3 {draw_sprite_ext(sStrikeChainPole,0,x+poleExtendDist,y+poleExtendDist,1,1,i*90,image_blend,image_alpha)}
  if i=0 {draw_sprite_ext(sStrikeChainPole,0,tDX+poleExtendDist,tDY-poleExtendDist,1,1,i*90,image_blend,image_alpha)} //60fps change: whole pixels
  else if i=1 {draw_sprite_ext(sStrikeChainPole,0,tDX-poleExtendDist,tDY-poleExtendDist,1,1,i*90,image_blend,image_alpha)} //60fps change: whole pixels
  else if i=2 {draw_sprite_ext(sStrikeChainPole,0,tDX-poleExtendDist,tDY+poleExtendDist,1,1,i*90,image_blend,image_alpha)} //60fps change: whole pixels
  else if i=3 {draw_sprite_ext(sStrikeChainPole,0,tDX+poleExtendDist,tDY+poleExtendDist,1,1,i*90,image_blend,image_alpha)} //60fps change: whole pixels
}
//draw_sprite_ext(sprite_index,0,x,y,1,1,0,image_blend,image_alpha)
//if reuseTime=0 {draw_sprite_ext(sStrikeChainColor,0,x,y,1,1,0,image_blend,image_alpha)}
//else {draw_sprite_ext(sStrikeChainColor,1,x,y,1,1,0,image_blend,image_alpha)}
draw_sprite_ext(sprite_index,0,tDX,tDY,1,1,0,image_blend,image_alpha) //60fps change: whole pixels
if reuseTime=0 {draw_sprite_ext(sStrikeChainColor,0,tDX,tDY,1,1,0,image_blend,image_alpha)} //60fps change: whole pixels
else {draw_sprite_ext(sStrikeChainColor,1,tDX,tDY,1,1,0,image_blend,image_alpha)} //60fps change: whole pixels
}
