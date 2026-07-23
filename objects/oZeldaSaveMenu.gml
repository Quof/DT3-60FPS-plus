#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
curPos=0

confirmationMenu=0
confirmMenuPos=1 //0:Confirm, 1:Cancel
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
if confirmationMenu=0
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if curPos=0
    {
      curPos=1
    }
    else
    {
      curPos-=1
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    if curPos=1
    {
      curPos=0
    }
    else
    {
      curPos+=1
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    resetKeyCodes()
    if curPos=0 //Save
    {
      global.recSaveNum+=1
      saveData()
    }
    else if curPos=1 //Return to title screen
    {
      confirmationMenu=1
      confirmMenuPos=1
    }
  }
  else if oKeyCodes.kCodePressed[6]=1 or oKeyCodes.kCodePressed[12]=1
  {
    io_clear()
    resetKeyCodes()
    playSound(global.snd_MenuClose,0,1,1)
    instance_destroy()
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///CONFIRMATION MENU
//Confirmation menu for 'Return to title screen'
if confirmationMenu=1
{
  if oKeyCodes.kCodePressed[3]=1
  {
    if confirmMenuPos=1
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=0
    }
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    if confirmMenuPos=0
    {
      playSound(global.snd_MenuCursor,0,1,1)
      confirmMenuPos=1
    }
  }

  if oKeyCodes.kCodePressed[5]=1
  {
    if confirmMenuPos=0 //Title Screen
    {
      playSound(global.snd_MenuCancel,0,1,1)
      room_goto(rTitle)
    }
    else if confirmMenuPos=1
    {
      confirmMenuPos=0
      confirmationMenu=0
      io_clear()
      resetKeyCodes()
    }
  }
  else if oKeyCodes.kCodePressed[6]=1
  {
    confirmMenuPos=0
    confirmationMenu=0
    io_clear()
    resetKeyCodes()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mainX=view_xview[0]+176
mainY=view_yview[0]+144

draw_set_color(c_black)
draw_set_alpha(1)
draw_rectangle(mainX+1,mainY+1,mainX+126,mainY+62,0)

draw_background_part(tileUtilZeldaSave,0,0,8,8,mainX,mainY) //top-left
draw_background_part(tileUtilZeldaSave,16,0,8,8,mainX+120,mainY) //top-right
draw_background_part(tileUtilZeldaSave,0,16,8,8,mainX,mainY+56) //bottom-left
draw_background_part(tileUtilZeldaSave,16,16,8,8,mainX+120,mainY+56) //bottom-right
for(i=0;i<14;i+=1) {draw_background_part(tileUtilZeldaSave,8,0,8,8,mainX+8+(i*8),mainY)} //top
for(i=0;i<14;i+=1) {draw_background_part(tileUtilZeldaSave,8,16,8,8,mainX+8+(i*8),mainY+56)} //bottom
for(i=0;i<6;i+=1) {draw_background_part(tileUtilZeldaSave,0,8,8,8,mainX,mainY+8+(i*8))} //left
for(i=0;i<6;i+=1) {draw_background_part(tileUtilZeldaSave,16,8,8,8,mainX+120,mainY+8+(i*8))} //right

draw_set_font(fnt_NES)
draw_set_halign(fa_middle)
draw_set_color(c_white)
draw_text(mainX+64,mainY+16,"SAVE GAME")
draw_text(mainX+64,mainY+40,"TITLE SCREEN")

draw_rectangle(mainX+10,mainY+14+(curPos*24),mainX+117,mainY+24+(curPos*24),1)

if confirmationMenu>0 //Confirmation menu
{
  var tConfirmMenuX,tConfirmMenuY;
  tConfirmMenuX=mainX+18
  tConfirmMenuY=mainY+4
  draw_sprite(sMenu_ConfirmMenu,0,tConfirmMenuX,tConfirmMenuY)
  draw_sprite(sPauseM_AbilArrow,0,tConfirmMenuX+15,tConfirmMenuY+14+(confirmMenuPos*19))
}
