/*
input text change (added): draws a text like draw_text_ext, with its input [tokens] (scrInputCode) shown as the gamepad
buttons' icons (sKeyPressPad) while the gamepad is in use, or as the keys they're set to otherwise (scrInputText).
argument0: x
argument1: y
argument2: text
argument3: line separation (-1: the font's)
argument4: width to wrap at (-1: no wrapping)
argument5: draw the icons (0 for a drop shadow's passes: only the text, with room left for the icons)
With icons, the lines are laid out here (wrapped at spaces, # starts a new line, like draw_text_ext) and lined up by
global.inputAlign: fa_left unless the caller drawing centered text sets it first (scrDrawInputShadow sets it back).
*/
var tX,tY,s,tSep,tW,tIcons;
tX=argument0
tY=argument1
s=argument2
tSep=argument3
tW=argument4
tIcons=argument5
if global.gpLastUsed!=1 or !scrInputHas(s)
{
  draw_text_ext(tX,tY,scrInputText(s),tSep,tW)
  exit
}

var n,i,L,ch,cur,r,k,name,p,c,f,tH,tLH,tSpW,uT,uS,uW,uF,uL,uX,lineW,line,lx,pend,j,wW,tA,tL,ox,py,tAlpha,tPart,q;
tH=string_height("M")
if tSep<0 {tLH=tH} else {tLH=tSep}
tSpW=string_width(" ")

//---------- Pieces: 0 text, 1 icon, 2 space, 3 new line ----------
n=0
cur=""
i=1
L=string_length(s)
while i<=L
{
  ch=string_char_at(s,i)
  if ch="#" or ch=" "
  {
    if cur!="" {uT[n]=0; uS[n]=cur; uW[n]=string_width(cur); n+=1; cur=""}
    if ch="#" {uT[n]=3} else {uT[n]=2}
    uW[n]=0
    n+=1
    i+=1
    continue
  }
  if ch="["
  {
    r=string_copy(s,i+1,L-i)
    k=string_pos("]",r)
    if k>0
    {
      name=string_copy(r,1,k-1)
      if scrInputTokenKeys(name)!=""
      {
        if cur!="" {uT[n]=0; uS[n]=cur; uW[n]=string_width(cur); n+=1; cur=""}
        //one icon, or two joined by "+" ([Up+Action C])
        p=string_pos("+",name)
        for(q=0;q<2;q+=1)
        {
          if p=0 {tPart=name}
          else if q=0 {tPart=string_copy(name,1,p-1)}
          else {tPart=string_copy(name,p+1,string_length(name)-p)}
          if q=1 and p>0 {uT[n]=0; uS[n]="+"; uW[n]=string_width("+"); n+=1}
          c=scrInputCode(tPart)
          f=scrInputPadFrame(c)
          uT[n]=1
          uF[n]=f
          if (f>=4 and f<=11) or (f>=16 and f<=23) {uW[n]=11} else {uW[n]=10} //9 or 8 wide, 1px either side
          n+=1
          if p=0 {break}
        }
        i+=k+1
        continue
      }
    }
  }
  cur+=ch
  i+=1
}
if cur!="" {uT[n]=0; uS[n]=cur; uW[n]=string_width(cur); n+=1}

//---------- Lines: a word (pieces between spaces) goes on the next line when it doesn't fit ----------
line=0
lx=0
pend=0
lineW[0]=0
i=0
while i<n
{
  if uT[i]=3 {line+=1; lineW[line]=0; lx=0; pend=0; i+=1; continue}
  if uT[i]=2 {pend+=1; i+=1; continue}
  j=i
  wW=0
  while j<n
  {
    if uT[j]>=2 {break}
    wW+=uW[j]
    j+=1
  }
  if tW>0 and lx>0 and lx+pend*tSpW+wW>tW {line+=1; lineW[line]=0; lx=0; pend=0}
  lx+=pend*tSpW
  pend=0
  while i<j
  {
    uL[i]=line
    uX[i]=lx
    lx+=uW[i]
    i+=1
  }
  lineW[line]=lx
}

//---------- Draw ----------
tA=global.inputAlign
tAlpha=draw_get_alpha()
draw_set_halign(fa_left)
for(i=0;i<n;i+=1)
{
  if uT[i]<2
  {
    tL=lineW[uL[i]]
    if tA=fa_center {ox=floor(tX-tL/2)}
    else if tA=fa_right {ox=floor(tX-tL)}
    else {ox=tX}
    py=tY+uL[i]*tLH
    if uT[i]=0 {draw_text(ox+uX[i],py,uS[i])}
    else if tIcons {draw_sprite_ext(sKeyPressPad,uF[i],ox+uX[i]+5,py+floor(tH/2),1,1,0,c_white,tAlpha)}
  }
}
draw_set_halign(tA)
