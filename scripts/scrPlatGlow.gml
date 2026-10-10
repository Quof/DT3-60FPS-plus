/*
platinum glow change (added): the platinum medal's radiant shine (like Hollow Knight's radiant clears): a pulsing halo
and slowly turning light rays behind the medal, and sparkles twinkling around it in front. Timed by current_time, so it
looks the same at any frame rate. Draw the back layer, then the medal, then the front layer.
argument0, argument1: the medal's centre (sBossGalleryMedals' origin is its centre)
argument2: the medal's scale (1 on the doors, 0.5 on the record board)
argument3: a number that differs per medal (the boss index), so medals side by side don't shine in step
argument4: 0 = back layer (halo, rays), 1 = front layer (sparkles)
*/
var tX,tY,tS,tT,tA,tR,tPulse,i,ii,tDir,tLen,tW,tCol,tTw,tSX,tSY,tSz;
tX=argument0; tY=argument1; tS=argument2
tT=current_time/1000+argument3*0.37
tCol=make_color_rgb(255,244,200) //warm white
tPulse=0.5+0.5*sin(tT*2.4)
draw_set_blend_mode(bm_add)

if argument4=0
{
  //halo: fades out from the centre (additive, so black is clear)
  tR=(18+3*tPulse)*tS
  draw_set_alpha(0.55+0.25*tPulse)
  draw_circle_color(tX,tY,tR,tCol,c_black,false)
  draw_circle_color(tX,tY,tR*0.6,c_white,c_black,false)

  //rays: two sets turning opposite ways, each ray a thin triangle that fades out at its tip
  for(ii=0;ii<2;ii+=1)
  {
    if ii=0 {tA=tT*18; tLen=(26+5*tPulse)*tS; tW=5}
    else {tA=-tT*11+22.5; tLen=(20+4*(1-tPulse))*tS; tW=3.5}
    draw_primitive_begin(pr_trianglelist)
    for(i=0;i<8;i+=1)
    {
      tDir=tA+i*45
      draw_vertex_color(tX,tY,tCol,0.5)
      draw_vertex_color(tX+lengthdir_x(tLen,tDir-tW),tY+lengthdir_y(tLen,tDir-tW),c_black,0)
      draw_vertex_color(tX+lengthdir_x(tLen,tDir+tW),tY+lengthdir_y(tLen,tDir+tW),c_black,0)
    }
    draw_primitive_end()
  }
}
else
{
  //sparkles: four-point stars around the rim, each twinkling on its own
  for(i=0;i<4;i+=1)
  {
    tTw=sin(tT*3.1+i*1.7)
    if tTw>0
    {
      tDir=i*90+45+sin(tT*0.7+i)*20
      tSX=tX+lengthdir_x(13*tS,tDir); tSY=tY+lengthdir_y(13*tS,tDir)
      tSz=(2+4*tTw)*tS
      draw_primitive_begin(pr_trianglelist)
      for(ii=0;ii<4;ii+=1)
      {
        tDir=ii*90+tT*40
        draw_vertex_color(tSX+lengthdir_x(tSz,tDir),tSY+lengthdir_y(tSz,tDir),c_white,tTw)
        draw_vertex_color(tSX+lengthdir_x(tSz*0.25,tDir+90),tSY+lengthdir_y(tSz*0.25,tDir+90),c_white,tTw)
        draw_vertex_color(tSX+lengthdir_x(tSz*0.25,tDir-90),tSY+lengthdir_y(tSz*0.25,tDir-90),c_white,tTw)
      }
      draw_primitive_end()
    }
  }
}

draw_set_blend_mode(bm_normal)
draw_set_alpha(1)
