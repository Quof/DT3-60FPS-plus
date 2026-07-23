#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.5
displayBack=make_color_rgb(187,187,188)
displayBorder=make_color_rgb(255,0,255)

haveKey=0
if global.tempAction[1]=0 {global.tempAction[1]=1500}

vaultMaze[0]=string_char_at(global.gameVaultProg,1)
vaultMaze[1]=string_char_at(global.gameVaultProg,2)
vaultMaze[2]=string_char_at(global.gameVaultProg,3)
vaultMaze[3]=string_char_at(global.gameVaultProg,4)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  vaultMaze[0]=string_char_at(global.gameVaultProg,1)
  vaultMaze[1]=string_char_at(global.gameVaultProg,2)
  vaultMaze[2]=string_char_at(global.gameVaultProg,3)
  vaultMaze[3]=string_char_at(global.gameVaultProg,4)

  //Key timer
  if global.tempAction[2]>0 {global.tempAction[2]-=1}
  haveKey=0
  for(i=0;i<4;i+=1) //Check for key
  {
    if vaultMaze[i]="1" {haveKey=1}
  }
  if haveKey=1 and global.tempAction[2]<=0 //Time runs out
  {
    var tWhichKey;
    tWhichKey=1
    for(i=0;i<4;i+=1)
    {
      if vaultMaze[i]="1" {break;}
      tWhichKey+=1
    }
    var tNewString;
    tNewString=string_delete(global.gameVaultProg,tWhichKey,1)
    tNewString=string_insert("0",tNewString,tWhichKey)
    global.gameVaultProg=tNewString

    global.tempAction[2]=0
  }

  //Shift time
  if oPlayer1.state=oPlayer1.LOOKING_UP {global.tempAction[1]-=12}
  else {global.tempAction[1]-=1}
  if global.tempAction[1]<=0 //Shift rooms
  {
    playSound(global.snd_HardHit1,0,0.98,7000)
    tSrnInv=instance_create(0,0,oScreenInvert); tSrnInv.invertTime=20

    global.vaultRooms+=1
    if global.vaultRooms=5 {global.vaultRooms=1}
    if room=rVault_R_A
    {
      if global.vaultRooms=1 or global.vaultRooms=3
      {
        with (257026) {toRoom=rVault_R_B}
        with (257033) {toRoom=rVault_R_B}
        with (257034) {toRoom=rVault_R_B}
        with (257035) {toRoom=rVault_R_B}
        with (257036) {toRoom=rVault_R_B}
        with (257037) {toRoom=rVault_R_B}
        with (257038) {toRoom=rVault_R_D}
      }
      else if global.vaultRooms=2 or global.vaultRooms=4
      {
        with (257026) {toRoom=rVault_R_D}
        with (257033) {toRoom=rVault_R_D}
        with (257034) {toRoom=rVault_R_D}
        with (257035) {toRoom=rVault_R_D}
        with (257036) {toRoom=rVault_R_D}
        with (257037) {toRoom=rVault_R_D}
        with (257038) {toRoom=rVault_R_B}
      }
    }
    else if room=rVault_R_B
    {
      if global.vaultRooms=1 or global.vaultRooms=3
      {
        with (257039) {toRoom=rVault_R_A}
        with (257040) {toRoom=rVault_R_A}
        with (257041) {toRoom=rVault_R_A}
        with (257042) {toRoom=rVault_R_A}
        with (257043) {toRoom=rVault_R_A}
        with (257044) {toRoom=rVault_R_A}
        with (257045) {toRoom=rVault_R_C}
      }
      else if global.vaultRooms=2 or global.vaultRooms=4
      {
        with (257039) {toRoom=rVault_R_C}
        with (257040) {toRoom=rVault_R_C}
        with (257041) {toRoom=rVault_R_C}
        with (257042) {toRoom=rVault_R_C}
        with (257043) {toRoom=rVault_R_C}
        with (257044) {toRoom=rVault_R_C}
        with (257045) {toRoom=rVault_R_A}
      }
    }
    else if room=rVault_R_C
    {
      if global.vaultRooms=1 or global.vaultRooms=3
      {
        with (257046) {toRoom=rVault_R_D}
        with (257047) {toRoom=rVault_R_D}
        with (257063) {toRoom=rVault_R_D}
        with (257064) {toRoom=rVault_R_D}
        with (257065) {toRoom=rVault_R_D}
        with (257066) {toRoom=rVault_R_D}
        with (257067) {toRoom=rVault_R_B}
      }
      else if global.vaultRooms=2 or global.vaultRooms=4
      {
        with (257046) {toRoom=rVault_R_B}
        with (257047) {toRoom=rVault_R_B}
        with (257063) {toRoom=rVault_R_B}
        with (257064) {toRoom=rVault_R_B}
        with (257065) {toRoom=rVault_R_B}
        with (257066) {toRoom=rVault_R_B}
        with (257067) {toRoom=rVault_R_D}
      }
    }
    else if room=rVault_R_D
    {
      if global.vaultRooms=1 or global.vaultRooms=3
      {
        with (257068) {toRoom=rVault_R_C}
        with (257069) {toRoom=rVault_R_C}
        with (257070) {toRoom=rVault_R_C}
        with (257071) {toRoom=rVault_R_C}
        with (257072) {toRoom=rVault_R_C}
        with (257073) {toRoom=rVault_R_C}
        with (257074) {toRoom=rVault_R_A}
      }
      else if global.vaultRooms=2 or global.vaultRooms=4
      {
        with (257068) {toRoom=rVault_R_A}
        with (257069) {toRoom=rVault_R_A}
        with (257070) {toRoom=rVault_R_A}
        with (257071) {toRoom=rVault_R_A}
        with (257072) {toRoom=rVault_R_A}
        with (257073) {toRoom=rVault_R_A}
        with (257074) {toRoom=rVault_R_C}
      }
    }
    global.tempAction[1]=1500
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//------------------------------ Set up position vars ------------------------------
timerMainX=view_xview[0]+353
mapMainX=view_xview[0]+384
mapMainY=view_yview[0]+1
//------------------------------ Draw main display ------------------------------
draw_set_alpha(1)
draw_set_color(displayBack)
draw_rectangle(mapMainX,mapMainY,mapMainX+94,mapMainY+94,0)
draw_rectangle(timerMainX,mapMainY,timerMainX+31,mapMainY+63,0)
draw_set_color(displayBorder)
draw_rectangle(mapMainX,mapMainY,mapMainX+94,mapMainY+94,1)
draw_rectangle(timerMainX,mapMainY,timerMainX+31,mapMainY+47,1)
draw_line_width(timerMainX,mapMainY+16,timerMainX+31,mapMainY+16,2)
draw_line_width(timerMainX,mapMainY+32,timerMainX+31,mapMainY+32,2)
draw_line_width(timerMainX+16,mapMainY+16,timerMainX+16,mapMainY+48,2)
draw_rectangle(timerMainX,mapMainY+48,timerMainX+31,mapMainY+63,1)
draw_set_color(c_red)
draw_set_alpha(0.35)
//------------------------------ Draw map ------------------------------
tPX=0; tPY=0
if global.vaultRooms=1
{
  draw_sprite(sVaultMazeMap,0,mapMainX+2,mapMainY+2)
  draw_sprite(sVaultMazeMap,1,mapMainX+49,mapMainY+2)
  draw_sprite(sVaultMazeMap,2,mapMainX+49,mapMainY+49)
  draw_sprite(sVaultMazeMap,3,mapMainX+2,mapMainY+49)

  if room=rVault_R_A {draw_rectangle(mapMainX+1,mapMainY+1,mapMainX+46,mapMainY+46,0); tPX=4; tPY=4}
  else if room=rVault_R_B {draw_rectangle(mapMainX+48,mapMainY+1,mapMainX+93,mapMainY+46,0); tPX=51; tPY=4}
  else if room=rVault_R_C {draw_rectangle(mapMainX+48,mapMainY+48,mapMainX+93,mapMainY+93,0); tPX=51; tPY=51}
  else if room=rVault_R_D {draw_rectangle(mapMainX+1,mapMainY+48,mapMainX+46,mapMainY+93,0); tPX=4; tPY=51}
}
else if global.vaultRooms=2
{
  draw_sprite(sVaultMazeMap,3,mapMainX+2,mapMainY+2)
  draw_sprite(sVaultMazeMap,0,mapMainX+49,mapMainY+2)
  draw_sprite(sVaultMazeMap,1,mapMainX+49,mapMainY+49)
  draw_sprite(sVaultMazeMap,2,mapMainX+2,mapMainY+49)

  if room=rVault_R_A {draw_rectangle(mapMainX+48,mapMainY+1,mapMainX+93,mapMainY+46,0); tPX=51; tPY=4}
  else if room=rVault_R_B {draw_rectangle(mapMainX+48,mapMainY+48,mapMainX+93,mapMainY+93,0); tPX=51; tPY=51}
  else if room=rVault_R_C {draw_rectangle(mapMainX+1,mapMainY+48,mapMainX+46,mapMainY+93,0); tPX=4; tPY=51}
  else if room=rVault_R_D {draw_rectangle(mapMainX+1,mapMainY+1,mapMainX+46,mapMainY+46,0); tPX=4; tPY=4}
}
else if global.vaultRooms=3
{
  draw_sprite(sVaultMazeMap,2,mapMainX+2,mapMainY+2)
  draw_sprite(sVaultMazeMap,3,mapMainX+49,mapMainY+2)
  draw_sprite(sVaultMazeMap,0,mapMainX+49,mapMainY+49)
  draw_sprite(sVaultMazeMap,1,mapMainX+2,mapMainY+49)

  if room=rVault_R_A {draw_rectangle(mapMainX+48,mapMainY+48,mapMainX+93,mapMainY+93,0); tPX=51; tPY=51}
  else if room=rVault_R_B {draw_rectangle(mapMainX+1,mapMainY+48,mapMainX+46,mapMainY+93,0); tPX=4; tPY=51}
  else if room=rVault_R_C {draw_rectangle(mapMainX+1,mapMainY+1,mapMainX+46,mapMainY+46,0); tPX=4; tPY=4}
  else if room=rVault_R_D {draw_rectangle(mapMainX+48,mapMainY+1,mapMainX+93,mapMainY+46,0); tPX=51; tPY=4}
}
else if global.vaultRooms=4
{
  draw_sprite(sVaultMazeMap,1,mapMainX+2,mapMainY+2)
  draw_sprite(sVaultMazeMap,2,mapMainX+49,mapMainY+2)
  draw_sprite(sVaultMazeMap,3,mapMainX+49,mapMainY+49)
  draw_sprite(sVaultMazeMap,0,mapMainX+2,mapMainY+49)

  if room=rVault_R_A {draw_rectangle(mapMainX+1,mapMainY+48,mapMainX+46,mapMainY+93,0); tPX=4; tPY=51}
  else if room=rVault_R_B {draw_rectangle(mapMainX+1,mapMainY+1,mapMainX+46,mapMainY+46,0); tPX=4; tPY=4}
  else if room=rVault_R_C {draw_rectangle(mapMainX+48,mapMainY+1,mapMainX+93,mapMainY+46,0); tPX=51; tPY=4}
  else if room=rVault_R_D {draw_rectangle(mapMainX+48,mapMainY+48,mapMainX+93,mapMainY+93,0); tPX=51; tPY=51}
}
//------------------------------ Draw timer ------------------------------
draw_set_font(fnt_Points)
draw_set_halign(fa_center)
draw_set_alpha(1)
draw_set_color(c_black)
draw_text(timerMainX+16,mapMainY+1,global.tempAction[1])
if global.tempAction[2]>0 {draw_text(timerMainX+16,mapMainY+49,global.tempAction[2])}
//------------------------------ Draw key progress ------------------------------
var tKeyX, tKeyY;
draw_set_color(c_red)
if vaultMaze[0]="0"
{
  draw_rectangle(timerMainX+3,mapMainY+19,timerMainX+12,mapMainY+28,1)
  if global.vaultRooms=1 {tKeyX=11; tKeyY=17}
  else if global.vaultRooms=2 {tKeyX=58; tKeyY=17}
  else if global.vaultRooms=3 {tKeyX=58; tKeyY=63}
  else if global.vaultRooms=4 {tKeyX=11; tKeyY=63}
  if haveKey=0 {draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_red,1)}
}
else if vaultMaze[0]="1"
{
  draw_rectangle(timerMainX+3,mapMainY+19,timerMainX+12,mapMainY+28,1)
  draw_set_alpha(0.35)
  draw_rectangle(timerMainX+3,mapMainY+19,timerMainX+12,mapMainY+28,0)
  if global.vaultRooms=1 {tKeyX=82; tKeyY=13}
  else if global.vaultRooms=2 {tKeyX=82; tKeyY=60}
  else if global.vaultRooms=3 {tKeyX=35; tKeyY=60}
  else if global.vaultRooms=4 {tKeyX=35; tKeyY=13}
  draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_red,1)
}
else if vaultMaze[0]="9" {draw_rectangle(timerMainX+3,mapMainY+19,timerMainX+12,mapMainY+28,0)}
draw_set_alpha(1)
draw_set_color(c_blue)
if vaultMaze[1]="0"
{
  draw_rectangle(timerMainX+19,mapMainY+19,timerMainX+28,mapMainY+28,1)
  if global.vaultRooms=1 {tKeyX=78; tKeyY=27}
  else if global.vaultRooms=2 {tKeyX=78; tKeyY=74}
  else if global.vaultRooms=3 {tKeyX=31; tKeyY=74}
  else if global.vaultRooms=4 {tKeyX=31; tKeyY=27}
  if haveKey=0 {draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_blue,1)}
}
else if vaultMaze[1]="1"
{
  draw_rectangle(timerMainX+19,mapMainY+19,timerMainX+28,mapMainY+28,1)
  draw_set_alpha(0.35)
  draw_rectangle(timerMainX+19,mapMainY+19,timerMainX+28,mapMainY+28,0)
  if global.vaultRooms=1 {tKeyX=87; tKeyY=66}
  else if global.vaultRooms=2 {tKeyX=40; tKeyY=66}
  else if global.vaultRooms=3 {tKeyX=40; tKeyY=18}
  else if global.vaultRooms=4 {tKeyX=87; tKeyY=18}
  draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_blue,1)
}
else if vaultMaze[1]="9" {draw_rectangle(timerMainX+19,mapMainY+19,timerMainX+28,mapMainY+28,0)}
draw_set_alpha(1)
draw_set_color(c_green)
if vaultMaze[2]="0"
{
  draw_rectangle(timerMainX+19,mapMainY+35,timerMainX+28,mapMainY+44,1)
  if global.vaultRooms=1 {tKeyX=68; tKeyY=74}
  else if global.vaultRooms=2 {tKeyX=21; tKeyY=74}
  else if global.vaultRooms=3 {tKeyX=21; tKeyY=27}
  else if global.vaultRooms=4 {tKeyX=68; tKeyY=27}
  if haveKey=0 {draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_green,1)}
}
else if vaultMaze[2]="1"
{
  draw_rectangle(timerMainX+19,mapMainY+35,timerMainX+28,mapMainY+44,1)
  draw_set_alpha(0.35)
  draw_rectangle(timerMainX+19,mapMainY+35,timerMainX+28,mapMainY+44,0)
  if global.vaultRooms=1 {tKeyX=40; tKeyY=70}
  else if global.vaultRooms=2 {tKeyX=40; tKeyY=23}
  else if global.vaultRooms=3 {tKeyX=87; tKeyY=23}
  else if global.vaultRooms=4 {tKeyX=87; tKeyY=70}
  draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_green,1)
}
else if vaultMaze[2]="9" {draw_rectangle(timerMainX+19,mapMainY+35,timerMainX+28,mapMainY+44,0)}
draw_set_alpha(1)
draw_set_color(c_orange)
if vaultMaze[3]="0"
{
  draw_rectangle(timerMainX+3,mapMainY+35,timerMainX+12,mapMainY+44,1)
  if global.vaultRooms=1 {tKeyX=10; tKeyY=56}
  else if global.vaultRooms=2 {tKeyX=10; tKeyY=9}
  else if global.vaultRooms=3 {tKeyX=57; tKeyY=9}
  else if global.vaultRooms=4 {tKeyX=57; tKeyY=56}
  if haveKey=0 {draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_orange,1)}
}
else if vaultMaze[3]="1"
{
  draw_rectangle(timerMainX+3,mapMainY+35,timerMainX+12,mapMainY+44,1)
  draw_set_alpha(0.35)
  draw_rectangle(timerMainX+3,mapMainY+35,timerMainX+12,mapMainY+44,0)
  if global.vaultRooms=1 {tKeyX=11; tKeyY=40}
  else if global.vaultRooms=2 {tKeyX=58; tKeyY=40}
  else if global.vaultRooms=3 {tKeyX=58; tKeyY=87}
  else if global.vaultRooms=4 {tKeyX=11; tKeyY=87}
  draw_sprite_ext(sMMMapPlacer,image_index,mapMainX+tKeyX,mapMainY+tKeyY,0.5,0.5,0,c_orange,1)
}
else if vaultMaze[3]="9" {draw_rectangle(timerMainX+3,mapMainY+35,timerMainX+12,mapMainY+44,0)}
draw_set_alpha(1)
//------------------------------ Draw player position ------------------------------
playerMapX=mapMainX+tPX+round(oPlayer1.x/39)
playerMapY=mapMainY+tPY+round(oPlayer1.y/39)
draw_set_color(c_green)
draw_rectangle(playerMapX-2,playerMapY-2,playerMapX+2,playerMapY+2,0)
