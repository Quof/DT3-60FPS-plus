#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fingerSprite=0
setupVars=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<fingerAmt;i+=1)
{
  fingerWave[i]=0
  fingerBend[i]=pi/2
  fingerSize[i]=random(0.5)
}
setupVars=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if setupVars=1
{
  if checkScreenArea(x,y,fingerAmt*fingerSpc)=1
  {
    for(i=0;i<fingerAmt;i+=1)
    {
      fingerBend[i]+=0.3+(i*0.015)
      fingerWave[i]+=sin(fingerBend[i]/4)
      if i=0 or i=4 or i=8 or i=12 or i=16 or i=20
        fingerSprite=sBlackmoorFingerA
      else if i=1 or i=5 or i=9 or i=13 or i=17 or i=21
        fingerSprite=sBlackmoorFingerB
      else if i=2 or i=6 or i=10 or i=14 or i=18 or i=22
        fingerSprite=sBlackmoorFingerC
      else if i=3 or i=7 or i=11 or i=15 or i=19
        fingerSprite=sBlackmoorFingerD

      if direction=0
        draw_sprite_ext(fingerSprite,0,x+(i*fingerSpc),y,image_xscale+fingerSize[i],image_yscale+fingerSize[i],image_angle+fingerWave[i],c_black,image_alpha)
      else if direction=90
        draw_sprite_ext(fingerSprite,0,x,y+(i*fingerSpc),image_xscale+fingerSize[i],image_yscale+fingerSize[i],image_angle+fingerWave[i],c_black,image_alpha)
    }
  }
}
