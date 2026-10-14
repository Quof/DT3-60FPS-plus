//sprite to spawn the fireballs from here
//  -180 to headROT if sprite naturally faces right
if global.gamePaused=false
{
  draw_sprite_ext(sRidleyHead,(dragontime>=dragondelay-10)+2*(dragontime<=-10),headX,headheight,-1,1,headROT-180-correction,c_white,1)
}
