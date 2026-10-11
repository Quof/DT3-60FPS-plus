/*
Warmaster II: a puff of shadow smoke (vanishing and appearing).
argument0, argument1: position of the feet
argument2: colour blend
*/
var tF,i;
for(i=0;i<3;i+=1)
{
  tF=scrWM2_Fx(argument0-10+i*10,argument1,sWM2_Smoke,0.4,argument2,0)
  tF.image_xscale=choose(-1,1)*(1+random(0.3)); tF.image_yscale=1+random(0.3)
  tF.vx=(i-1)*0.8; tF.vy=-0.5-random(0.5); tF.image_alpha=0.85
}
