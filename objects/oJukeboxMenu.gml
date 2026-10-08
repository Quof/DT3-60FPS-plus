#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//jukebox change (added): the music room jukebox's track list (oJukebox opens it and pauses the game, as a shop window
//does). Up/Down: track (hold to scroll), Left/Right: first track of the previous/next area, Confirm: play it, Cancel:
//close. The list itself is scrJukeboxList. It runs on 30fps ticks (oKeyCodes), like the shop windows
scrJukeboxList()
jbRows=12 //lines shown at once
jbHoldTime=-1 //ticks Up/Down has been held since it was pressed in here (-1: not pressed in here yet)
jbCursor=1 //line 0 is the first area name
jbPlaying=-1 //line of the track playing (-1: none from the list)
for(i=0;i<jbLines;i+=1)
{
  if jbLineSong[i]!=0 and jbLineSong[i]=global.currentMusic {jbCursor=i; jbPlaying=i}
}
jbTop=0 //first line shown
event_user(0)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
var tMove,tLine;
tMove=0
if oKeyCodes.kCodePressed[3]=1 {tMove=-1; jbHoldTime=0}
else if oKeyCodes.kCodePressed[4]=1 {tMove=1; jbHoldTime=0}
else if jbHoldTime>=0 and (oKeyCodes.kCode[3]=1 or oKeyCodes.kCode[4]=1)
{
  jbHoldTime+=1
  if jbHoldTime>=8 and jbHoldTime mod 2=0
  {
    if oKeyCodes.kCode[3]=1 {tMove=-1}
    else {tMove=1}
  }
}

if tMove!=0 //previous/next track, past the area names, around the ends of the list
{
  playSound(global.snd_MenuCursor,0,1,1)
  do
  {
    jbCursor+=tMove
    if jbCursor<0 {jbCursor=jbLines-1}
    else if jbCursor>=jbLines {jbCursor=0}
  }
  until (jbLineSong[jbCursor]!=0)
  event_user(0)
}
else if oKeyCodes.kCodePressed[1]=1 or oKeyCodes.kCodePressed[2]=1 //first track of the previous/next area
{
  playSound(global.snd_MenuCursor,0,1,1)
  tLine=jbCursor
  if oKeyCodes.kCodePressed[2]=1
  {
    do {tLine+=1; if tLine>=jbLines {tLine=0}} until (jbLineSong[tLine]=0)
  }
  else
  {
    while (jbLineSong[tLine]!=0) {tLine-=1} //this area's name
    do {tLine-=1; if tLine<0 {tLine=jbLines-1}} until (jbLineSong[tLine]=0)
  }
  jbCursor=tLine+1
  jbTop=tLine //the area's name at the top
  event_user(0)
}

if oKeyCodes.kCodePressed[15]=1 //play it (from the start if it's the one playing)
{
  var tSong,tempMplay;
  tSong=jbLineSong[jbCursor]
  if tSong=global.currentMusic {stopAllMusic()}
  tempMplay=findMusic(tSong)
  playMusic(tempMplay,0,0)
  //at normal speed (double in speed mode, as playMusic does): a speed a room set on a track stays set on it
  if global.modeSpeed=1 {scrMusicFreq(tempMplay,44100)}
  else {scrMusicFreq(tempMplay,22050)}
  jbPlaying=jbCursor
}

if oKeyCodes.kCodePressed[16]=1 //close
{
  io_clear()
  scrKeyCarryClear()
  resetKeyCodes()
  playSound(global.snd_MenuCancel,0,1,1)
  global.gamePaused=false
  instance_destroy()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//keeps the cursor's line shown, with its area name when that's right above it
if jbLineSong[jbCursor-1]=0 and jbCursor-1<jbTop {jbTop=jbCursor-1}
else if jbCursor<jbTop {jbTop=jbCursor}
if jbCursor>jbTop+jbRows-1 {jbTop=jbCursor-jbRows+1}
if jbTop>jbLines-jbRows {jbTop=jbLines-jbRows}
if jbTop<0 {jbTop=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//the shop windows' look (displayShopWindow)
var tColorTop,tColorBack,tColorBorder,tColorInfo,tColorTextA,tColorTextB,tX,tY,tLine,tRowY,tName,tBarH,tBarY;
tColorTop=make_color_rgb(12,16,15)
tColorBack=make_color_rgb(28,52,62)
tColorBorder=make_color_rgb(117,121,156)
tColorInfo=make_color_rgb(10,32,45)
tColorTextA=make_color_rgb(240,240,240)
tColorTextB=make_color_rgb(255,169,4)
tX=view_xview[0]+64
tY=view_yview[0]+30

//window
draw_set_alpha(0.75)
draw_set_color(tColorBack)
draw_rectangle(tX,tY,tX+351,tY+291,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX,tY,tX+351,tY+16,0) //top margin
draw_rectangle(tX,tY,tX+351,tY+291,1) //border
draw_set_color(tColorBorder)
draw_rectangle(tX+2,tY+2,tX+349,tY+289,1) //blue border (slight inset)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(tX+8,tY+3,"JUKEBOX")

//list
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+22,tX+343,tY+219,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+22,tX+343,tY+219,1)
for(i=0;i<jbRows;i+=1)
{
  tLine=jbTop+i
  if tLine>=jbLines {break}
  tRowY=tY+25+(i*16)
  if jbLineSong[tLine]=0 //area name
  {
    textDropShadow(jbLineText[tLine],tX+14,tRowY,tColorTextB,tColorTop,4)
    draw_set_color(tColorTextB)
    draw_line(tX+20+string_width(jbLineText[tLine]),tRowY+7,tX+329,tRowY+7)
  }
  else //track
  {
    if tLine=jbPlaying //playing: a play mark
    {
      draw_set_color(tColorTextB)
      draw_triangle(tX+18,tRowY+3,tX+18,tRowY+11,tX+23,tRowY+7,0)
    }
    textDropShadow(jbLineText[tLine],tX+28,tRowY,tColorTextA,tColorTop,4)
  }
}
draw_set_color(tColorTextB)
draw_rectangle(tX+12,tY+24+((jbCursor-jbTop)*16),tX+331,tY+39+((jbCursor-jbTop)*16),1) //cursor
draw_set_color(tColorTop)
draw_rectangle(tX+335,tY+25,tX+340,tY+216,0) //scroll bar
tBarH=max(8,round(192*jbRows/jbLines))
tBarY=round((192-tBarH)*jbTop/max(1,jbLines-jbRows))
draw_set_color(tColorBorder)
draw_rectangle(tX+336,tY+25+tBarY,tX+339,tY+24+tBarY+tBarH,0)

//now playing
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+225,tX+343,tY+258,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+225,tX+343,tY+258,1)
if global.optMusic<=0 {tName="(Music Volume is off)"}
else if jbPlaying>=0 {tName=jbLineText[jbPlaying]}
else {tName="-"}
textDropShadow("NOW PLAYING:",tX+14,tY+227,tColorTextB,tColorTop,4)
textDropShadow(tName,tX+22+string_width("NOW PLAYING:"),tY+227,tColorTextA,tColorTop,4)
if global.optMusic>0 and jbPlaying>=0 //where it's from (scrMusicCredit)
{
  tName=scrMusicCredit(jbLineSong[jbPlaying])
  if tName!="" {scrTextFit(tName,tX+14,tY+242,322,tColorTextB,tColorTop)}
}

//controls
draw_set_font(fnt_Points)
textDropShadow(string("[Up/Down] Song     [Left/Right] Area     [") +string(global.ctrlConfirm) +string("] Play     [") +string(global.ctrlCancel) +string("] Close"),tX+14,tY+267,tColorTextA,tColorTop,4)
