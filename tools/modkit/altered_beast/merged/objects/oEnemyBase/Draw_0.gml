if global.optShowHoverInfo=1 and bIsBoss=0 and hoverAlpha!=-1
{
  if place_meeting(x,y,oIdentifier) {hoverAlpha=1.5}
  if hoverAlpha>0 and oIdentifier.bCanScan=1
  {
    hoverAlpha-=0.05*gDeltaTime
    draw_set_font(fnt_EnemyName)
    draw_set_halign(fa_center)
    draw_set_alpha(hoverAlpha)
    var tHoverX,tHoverY;
    tHoverX=floor(bbox_left+(abs(sprite_width)/2))
    tHoverY=floor(bbox_top-14)
    textDropShadow(string(eName) +string(" (") +string(life) +string(")"),tHoverX,tHoverY-12,make_color_rgb(0,255,0),c_black,1)

    var tCheckWorth;
    tCheckWorth=pointWorth
    if global.pAPLevel>eLevel //Smaller award
    {
      var tLvDif,tLvMod,tLvTotal;
      tLvDif=abs(global.pAPLevel-eLevel)
      tLvMod=tCheckWorth*0.08
      tLvTotal=(tLvMod*tLvDif)+(tLvDif*1.5)

      tCheckWorth-=tLvTotal
      if tCheckWorth<round(pointWorth/3) {tCheckWorth=round(pointWorth/3)}
      if tCheckWorth<1 {tCheckWorth=1}
    }
    else if global.pAPLevel<eLevel //Bigger award
    {
      var tLvDif,tLvMod,tLvTotal;
      tLvDif=abs(global.pAPLevel-eLevel)
      tLvMod=tCheckWorth*0.05
      tLvTotal=(tLvMod*tLvDif)+(tLvDif*1.5)

      tCheckWorth+=tLvTotal
      if tCheckWorth>pointWorth*2 {tCheckWorth=pointWorth*2}
    }
    textDropShadow(string("AP Award: ") +string(round(tCheckWorth)),tHoverX,tHoverY,make_color_rgb(0,255,0),c_black,1)
  }
}
event_inherited()


if weakened > 0
{
    draw_sprite(sScanMenuHitDetect,0,round(bbox_left+(abs(sprite_width/2))),bbox_top-20)
}
