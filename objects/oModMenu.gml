#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//mods change (added): the title screen's Mods window (oInitializeGame opens it): the mods found in the Mods folder, each
//turned on or off with Confirm (kept in DT3Options.dts, section MODS). Mods are loaded when the game starts, so a change
//takes effect the next time it's started. Up/Down: mod, Confirm: on/off, Cancel: close. Runs on 30fps ticks (oKeyCodes)
mmRows=10 //mods shown at once
mmCursor=0
mmTop=0
mmChanged=0
mmErrors=string_count("ERROR",global.modLog) //from loading the mods that are on (Mods\mod_log.txt)
//the title reads oKeyCodesHighFPS but this reads oKeyCodes (ticks): the Confirm press that opened it could still be new to
//oKeyCodes on its next tick and turn the first mod on or off. Whatever is held now counts as already held (as oPauseMenu)
for(i=1;i<=18;i+=1)
{
  oKeyCodes.kCode[i]=scrController(i)
  oKeyCodes.kCodePressed[i]=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
if global.modCount>0
{
  if oKeyCodes.kCodePressed[3]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    mmCursor-=1
    if mmCursor<0 {mmCursor=global.modCount-1}
  }
  else if oKeyCodes.kCodePressed[4]=1
  {
    playSound(global.snd_MenuCursor,0,1,1)
    mmCursor+=1
    if mmCursor>=global.modCount {mmCursor=0}
  }
  if mmCursor<mmTop {mmTop=mmCursor}
  if mmCursor>=mmTop+mmRows {mmTop=mmCursor-mmRows+1}
  if oKeyCodes.kCodePressed[15]=1 //on/off
  {
    playSound(global.snd_MenuConfirm,0,0.95,1)
    global.modEnabled[mmCursor]=1-global.modEnabled[mmCursor]
    ini_open(global.saveDir+"DT3Options.dts")
    ini_write_real("MODS",global.modFolder[mmCursor],global.modEnabled[mmCursor])
    ini_close()
    mmChanged=1
  }
}
if oKeyCodes.kCodePressed[16]=1 //close
{
  io_clear()
  scrKeyCarryClear()
  resetKeyCodes()
  playSound(global.snd_MenuClose,0,1,1)
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//the jukebox's look (oJukeboxMenu)
var tColorTop,tColorBack,tColorBorder,tColorInfo,tColorTextA,tColorTextB,tColorOn,tColorOff,tX,tY,i,k,tRowY,tName,tOn,tBarH,tBarY;
tColorTop=make_color_rgb(12,16,15)
tColorBack=make_color_rgb(28,52,62)
tColorBorder=make_color_rgb(117,121,156)
tColorInfo=make_color_rgb(10,32,45)
tColorTextA=make_color_rgb(240,240,240)
tColorTextB=make_color_rgb(255,169,4)
tColorOn=make_color_rgb(120,232,96)
tColorOff=make_color_rgb(232,96,96)
tX=view_xview[0]+64
tY=view_yview[0]+30

//window
draw_set_alpha(0.85)
draw_set_color(tColorBack)
draw_rectangle(tX,tY,tX+351,tY+291,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX,tY,tX+351,tY+16,0)
draw_rectangle(tX,tY,tX+351,tY+291,1)
draw_set_color(tColorBorder)
draw_rectangle(tX+2,tY+2,tX+349,tY+289,1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)
draw_text(tX+8,tY+3,"MODS")

//list (mod names are drawn with draw_text: textDropShadow would read [brackets] in them as input keys)
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+22,tX+343,tY+187,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+22,tX+343,tY+187,1)
draw_set_font(fnt_PauseMenuText)
if global.modCount=0
{
  draw_set_color(tColorTop); draw_text(tX+15,tY+27,"No mods found. Put a mod's folder in the Mods folder.")
  draw_set_color(tColorTextA); draw_text(tX+14,tY+26,"No mods found. Put a mod's folder in the Mods folder.")
}
for(i=0;i<mmRows;i+=1)
{
  k=mmTop+i
  if k>=global.modCount {break}
  tRowY=tY+25+(i*16)
  tName=global.modName[k]
  if global.modVersion[k]!="" {tName+="  v"+global.modVersion[k]}
  draw_set_color(tColorTop); draw_text(tX+15,tRowY+1,tName)
  draw_set_color(tColorTextA); draw_text(tX+14,tRowY,tName)
  tOn=global.modEnabled[k]
  if tOn=1 {tName="ON"} else {tName="OFF"}
  if tOn!=global.modLoaded[k] {tName+=" (restart)"}
  draw_set_halign(fa_right)
  draw_set_color(tColorTop); draw_text(tX+329,tRowY+1,tName)
  if tOn=1 {draw_set_color(tColorOn)} else {draw_set_color(tColorOff)}
  draw_text(tX+328,tRowY,tName)
  draw_set_halign(fa_left)
}
if global.modCount>0
{
  draw_set_color(tColorTextB)
  draw_rectangle(tX+12,tY+24+((mmCursor-mmTop)*16),tX+331,tY+39+((mmCursor-mmTop)*16),1)
  draw_set_color(tColorTop)
  draw_rectangle(tX+335,tY+25,tX+340,tY+184,0)
  tBarH=max(8,round(160*min(1,mmRows/global.modCount)))
  tBarY=round((160-tBarH)*mmTop/max(1,global.modCount-mmRows))
  draw_set_color(tColorBorder)
  draw_rectangle(tX+336,tY+25+tBarY,tX+339,tY+24+tBarY+tBarH,0)
}

//the mod on the cursor
draw_set_alpha(0.75)
draw_set_color(tColorInfo)
draw_rectangle(tX+8,tY+193,tX+343,tY+258,0)
draw_set_alpha(1)
draw_set_color(tColorTop)
draw_rectangle(tX+8,tY+193,tX+343,tY+258,1)
if global.modCount>0
{
  tName=global.modAuthor[mmCursor]
  if tName!="" {tName="by "+tName+"   "}
  tName+="folder: Mods\"+global.modFolder[mmCursor]
  draw_set_color(tColorTop); draw_text(tX+15,tY+196,tName)
  draw_set_color(tColorTextB); draw_text(tX+14,tY+195,tName)
  draw_set_color(tColorTop); draw_text_ext(tX+15,tY+209,global.modDesc[mmCursor],10,320)
  draw_set_color(tColorTextA); draw_text_ext(tX+14,tY+208,global.modDesc[mmCursor],10,320)
}

//notices and controls
draw_set_font(fnt_Points)
if mmChanged=1 {textDropShadow("Mods are loaded when the game starts: restart it for this to take effect.",tX+14,tY+262,tColorTextB,tColorTop,4)}
else if mmErrors>0 {textDropShadow("There were errors loading the mods (Mods\mod_log.txt).",tX+14,tY+262,tColorOff,tColorTop,4)}
textDropShadow("[Up]/[Down] Mod     [Confirm] On/Off     [Cancel] Close",tX+14,tY+275,tColorTextA,tColorTop,4)
