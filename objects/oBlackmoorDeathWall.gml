#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_blend=c_black
image_yscale=3

//Enemy base statistics
atkPower=6
bCanTakeDamage=false
bShowHealthBar=false

fingerSprite=0
for(i=0;i<23;i+=1)
{
  fingerWave[i]=0
  fingerBend[i]=pi/2
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(0,y,x+1,y+192,0)

for(i=0;i<23;i+=1)
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
  draw_sprite_ext(fingerSprite,0,x+20,y+8+(i*8),1,1,90+fingerWave[i],c_black,0.66)
}

for(i=0;i<3;i+=1)
{
  draw_sprite_ext(sprite_index,0,x,y+(i*64),1,1,0,c_black,1)
}
