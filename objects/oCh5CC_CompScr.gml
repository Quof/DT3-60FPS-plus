#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xPos=176
yPos=192
sequence=0
timer=3600

stringUse[0]=">Chk Disk..."
stringUse[1]=">Init Boot Sequence..."
stringUse[2]=">Boot Sequence Started..."
stringUse[3]=">Chk Ctrl Instr..."
stringUse[4]=">Loading Control Prog..."
stringUse[5]=">Loading Countdown..."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sequence=1
  {
    timer-=1
    if timer<=0 //Game Over
    {
      oPlayer1.life-=oPlayer1.maxLife
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(c_black)
draw_set_halign(fa_left)
draw_set_font(fnt_CompText)
draw_rectangle(xPos,yPos,xPos+96,yPos+64,1)
draw_set_color(c_green)
if sequence=0
{
  for(i=0;i<6;i+=1)
  {
    draw_text(xPos+2,yPos+2+(i*10),stringUse[i])
  }
}
else if sequence=1
{
  draw_text(xPos+2,yPos+2,">COUNTDOWN TO CITY#CONTROL LOCKDOWN")
  draw_set_font(fnt_Timer)
  draw_text(xPos+2,yPos+32,timer)
}
else if sequence=2
{
  draw_text(xPos+2,yPos+2,string(">YOU BEASTED#THAT THING!!#>Time Remaining: ") +string(timer))
}
