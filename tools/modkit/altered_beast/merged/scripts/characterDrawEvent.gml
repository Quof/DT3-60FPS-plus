/*
This event should be placed in the draw event of the platform character.
It draws the "flySpeed" bar and the character sprite.
*/
//draws the sprite
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
/*if canRun
{
  xOffset=80
  if player=1
    yOffset=120
  else
    yOffset=143
  //draw the "flySpeed" bar, which shows how much speed the character has acquired while holding the "run" button
  draw_healthbar(view_xview[0]+224+xOffset,view_yview[0]+432+yOffset,view_xview[0]+400+xOffset,view_yview[0]+450+yOffset,flySpeed,make_color_rgb(0,64,128),c_blue,c_aqua,0,1,1)
}*/

//draw buffs
tEffect=0
if global.alterEquip=1
{
     if global.activeCharacter=0
     {
       for(i=0;i<3;i+=1)
       {
         if global.equipJerry[i]=14
         {
            tEffect=1
         }
       }    
     }
     else
     {
       for(i=0;i<3;i+=1)
       {
         if global.equipClaire[i]=14
         {
            tEffect=1
         }
       }  
     }
 }
 
buffXOffset=0
buffYOffset=-70

buffXSpacing= 26

buffNum = 0

if battleRage>0
    buffNum+=1

if momentumStacks>0
    buffNum+=1
    
if bloodlust>0
    buffNum+=1

if focusStacks>0
    buffNum+=1
    
if tEffect=1 and oPlayer1.lastElementHit!="NONE"
    buffNum+=1
draw_set_font(fnt_NES)
draw_set_halign(fa_center)


buffXOffset-=(buffNum-1)*(buffXSpacing/2)
if battleRage>0
{
    draw_sprite_ext(sEquipItemIcons, 4, x+buffXOffset, y+buffYOffset,1,1,0,image_blend,battleRage/90)
    buffXOffset+=buffXSpacing
}
if bloodlust>0
{
    draw_sprite_ext(sEquipItemIcons, 24, x+buffXOffset, y+buffYOffset,1,1,0,image_blend,1)
    buffXOffset+=buffXSpacing
}
if momentumStacks>0
{
    draw_sprite_ext(sEquipItemIcons, 27, x+buffXOffset, y+buffYOffset,1,1,0,image_blend,momentumTimer/60)
    //draw_text_color(x+buffXOffset,y+buffYOffset-20,string(momentumStacks),c_white,c_white,c_black,c_black,momentumTimer/60)
    textDropShadow(string(momentumStacks),x+buffXOffset,y+buffYOffset-20,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
    buffXOffset+=buffXSpacing
}
if focusStacks>0
{
    alpha=0.5
    if focusStacks=5
    {
        alpha=1
    }
    draw_sprite_ext(sEquipItemIcons, 16, x+buffXOffset, y+buffYOffset,1,1,0,image_blend,alpha)
    //draw_text_color(x+buffXOffset,y+buffYOffset-20,string(focusStacks),c_white,c_white,c_black,c_black,1)
    textDropShadow(string(focusStacks),x+buffXOffset,y+buffYOffset-20,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
    buffXOffset+=buffXSpacing
}
if tEffect=1 and oPlayer1.lastElementHit!="NONE"
{
    typeIndex=0
    if oPlayer1.lastElementHit="NORMAL"
    {
        typeIndex=0
    }
    if oPlayer1.lastElementHit="PIERCE"
    {
        typeIndex=1
    }
    if oPlayer1.lastElementHit="ELEMENTAL"
    {
        typeIndex=2
    }
    if oPlayer1.lastElementHit="SHOT"
    {
        typeIndex=3
    }
    if oPlayer1.lastElementHit="EXPLOSION"
    {
        typeIndex=4
    }
    if oPlayer1.lastElementHit="SPECIAL"
    {
        typeIndex=5
    }
    draw_sprite_ext(sEquipItemIcons, 13, x+buffXOffset, y+buffYOffset,1,1,0,image_blend,1)
    draw_sprite_ext(sDamageTypes, typeIndex, x+buffXOffset-8, y+buffYOffset-30,1,1,0,image_blend,1)
    buffXOffset+=buffXSpacing
}
