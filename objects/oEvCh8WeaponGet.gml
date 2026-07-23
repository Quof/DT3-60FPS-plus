#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
stopAllMusic()
transition_steps=10
transition_kind=21

clGrid=make_color_rgb(0,229,206)
clExtraText=make_color_rgb(121,124,201)
clOverlay=make_color_rgb(41,41,234)

wepProg=0
fadeOut=1
wepTAlpha=0
wepTFull[0]="- Getting current weapon data string..."
wepTFull[1]="- Searching for new weapon data..."
wepTFull[2]="- Inserting new weapon data into weapon data string..."
if global.newMapX=1
{
  wepTFull[3]="YOU GOT   SHOTGUN ICE"
  wepTFull[4]="- Press [Action Button B] to fire it."
}
else if global.newMapX=2
{
  wepTFull[3]="YOU GOT   GRAVITY WELL"
  wepTFull[4]="- Press [Action Button C] to fire it."
}
else if global.newMapX=3
{
  wepTFull[3]="YOU GOT   STRIKE CHAIN"
  wepTFull[4]="- Hold [Up] and press [Action Button A] to use it."
}

for(i=0;i<5;i+=1)
{
  wepTNew[i]=""
  wepTPos[i]=0
}
text_Pos=0
wepAreaScl=0
bottomOverlayY=0

playerSprite=sPlayerDiscombobulate
playerImage=0
playerY=-2

for(i=0;i<30;i+=1) {gridLineX[i]=i*16}
for(i=0;i<22;i+=1) {gridLineY[i]=i*16}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(clGrid)
for(i=0;i<30;i+=1)
{
  draw_line(gridLineX[i],-1,gridLineX[i],room_height+1)
  gridLineX[i]-=1
  if gridLineX[i]<0 {gridLineX[i]=room_width}
}
for(i=0;i<22;i+=1)
{
  draw_line(-1,gridLineY[i],room_width+1,gridLineY[i])
  gridLineY[i]-=1
  if gridLineY[i]<0 {gridLineY[i]=room_height}
}

wepProg+=1
if wepProg>=1 and wepProg<=10 {fadeOut-=0.1}

if wepProg=5 //----- Play music -----
{
  var tempMplay;
  tempMplay=findMusic(407)
  playMusic(tempMplay,0,1)
}
else if wepProg>=31 and wepProg<=199 //----- Grow weapon area -----
{
  wepAreaScl+=8
  if wepAreaScl>=480
  {
    wepAreaScl=480
    wepProg=200
  }

  if bottomOverlayY<57 {bottomOverlayY+=1}
}
else if wepProg=371 {playSound(global.snd_MMBeamDown,0,1,1)}
else if wepProg>=372 and wepProg<=399 //----- Beam player down -----
{
  playerY+=16
  if playerY>=284
  {
    playerY=284
    playerImage=1
    wepProg=400
  }
}
else if wepProg=403 {playerSprite=sJerryIdle; playerImage=0}

if global.newMapX=1 //Show Shotgun Ice
{
  if wepProg=470
  {
    playerSprite=sJerryBusterStand
    playerAttack=instance_create(100,252,oEvCh8WepTest)
    playerAttack.direction=0; playerAttack.type=1
  }
  else if wepProg=490 {playerSprite=sJerryIdle}
  else if wepProg=520
  {
    playerSprite=sJerryBusterStand
    playerAttack=instance_create(100,252,oEvCh8WepTest)
    playerAttack.direction=0; playerAttack.type=1
  }
  else if wepProg=540 {playerSprite=sJerryIdle}
}
else if global.newMapX=2 //Show Gravity Well
{
  if wepProg=470
  {
    playerSprite=sJerryBusterStand
    playerAttack=instance_create(100,252,oEvCh8WepTest)
    playerAttack.direction=0; playerAttack.type=11
  }
  else if wepProg=490 {playerSprite=sJerryIdle}
  else if wepProg=520
  {
    playerSprite=sJerryBusterStand
    playerAttack=instance_create(100,252,oEvCh8WepTest)
    playerAttack.direction=0; playerAttack.type=11;
  }
  else if wepProg=540 {playerSprite=sJerryIdle}
}
else if global.newMapX=3 //Show Strike Chain
{
  if wepProg=470
  {
    playerSprite=sJerryBusterStand
    playerAttack=instance_create(100,252,oEvCh8WepTest)
    playerAttack.direction=0; playerAttack.type=21
  }
  else if wepProg=490 {playerSprite=sJerryIdle}
  else if wepProg=520
  {
    playerSprite=sJerryBusterStand
    playerAttack=instance_create(100,252,oEvCh8WepTest)
    playerAttack.direction=0; playerAttack.type=21;
  }
  else if wepProg=540 {playerSprite=sJerryIdle}
}

if wepProg>=641 and wepProg<=650 {fadeOut+=0.1}
else if wepProg=660 //End sequence
{
  global.hasAbilToken[3]=2+global.newMapX
  global.gameProgress+=1
  if global.gameProgress=1845
  {
    global.newMapX=208; global.newMapY=312
    room_goto(rMega4_Shop)
  }
  else {room_goto(rMega4_Map)}
}

//Bottom overlay
draw_set_color(clOverlay)
draw_set_alpha(0.5)
draw_rectangle(-1,room_height,room_width+1,room_height-bottomOverlayY,0)
//Top overlay
draw_rectangle(0,0,148,32,0)
draw_rectangle(149,0,480,59,0)
draw_triangle(122,33,149,33,149,59,0)
draw_set_alpha(1)
draw_line(0,33,122,33)
draw_line(122,33,148,59)
draw_line(148,59,480,59)

draw_set_font(fnt_Chapter)
draw_set_halign(fa_left)
draw_set_alpha(wepTAlpha)
textDropShadow("YOU GOT A NEW WEAPON!",136,16,clGrid,c_black,4)

//Flavor text
draw_set_font(fnt_StatRender)
if wepProg>=31 and wepProg<=40 {wepTAlpha+=0.1}
if wepProg>=50
{
  if wepTPos[0]<string_length(wepTFull[0])
  {
    textDropShadow(wepTNew[0],40,80,clExtraText,c_black,4)
    for(i=0;i<2;i+=1)
    {
      wepTPos[0]+=1
      wepTNew[0]+=string_char_at(wepTFull[0],wepTPos[0])
    }
  }
  else {textDropShadow(wepTFull[0],40,80,clExtraText,c_black,4)}
}
if wepProg>=210
{
  if wepTPos[1]<string_length(wepTFull[1])
  {
    textDropShadow(wepTNew[1],40,94,clExtraText,c_black,4)
    for(i=0;i<2;i+=1)
    {
      wepTPos[1]+=1
      wepTNew[1]+=string_char_at(wepTFull[1],wepTPos[1])
    }
  }
  else {textDropShadow(wepTFull[1],40,94,clExtraText,c_black,4)}
}
if wepProg>=300
{
  if wepTPos[2]<string_length(wepTFull[2])
  {
    textDropShadow(wepTNew[2],40,108,clExtraText,c_black,4)
    for(i=0;i<2;i+=1)
    {
      wepTPos[2]+=1
      wepTNew[2]+=string_char_at(wepTFull[2],wepTPos[2])
    }
  }
  else {textDropShadow(wepTFull[2],40,108,clExtraText,c_black,4)}
}

if wepProg>=410
{
  draw_set_font(fnt_Chapter)
  if wepTPos[3]<string_length(wepTFull[3])
  {
    textDropShadow(wepTNew[3],90,310,clGrid,c_black,4)
    if wepProg mod 2=0
    {
      if wepProg mod 4=0 {playSound(global.snd_MMText,0,1,1)}
      wepTPos[3]+=1
      wepTNew[3]+=string_char_at(wepTFull[3],wepTPos[3])
    }
  }
  else {textDropShadow(wepTFull[3],90,310,clGrid,c_black,4)}
}

if wepProg>=480
{
  draw_set_font(fnt_StatRender)
  if wepTPos[4]<string_length(wepTFull[4])
  {
    textDropShadow(wepTNew[4],40,140,clExtraText,c_black,4)
    for(i=0;i<2;i+=1)
    {
      wepTPos[4]+=1
      wepTNew[4]+=string_char_at(wepTFull[4],wepTPos[4])
    }
  }
  else {textDropShadow(wepTFull[4],40,140,clExtraText,c_black,4)}
}

if wepAreaScl>0 {draw_sprite_ext(sMMWepGetArea,0,0,258,wepAreaScl,1,0,c_white,1)}
draw_sprite_ext(playerSprite,playerImage,85,playerY,1,1,0,c_white,1)

if fadeOut>0
{
  draw_set_alpha(fadeOut)
  draw_set_color(c_black)
  draw_rectangle(-1,-1,room_width+1,room_height+1,0)
}
