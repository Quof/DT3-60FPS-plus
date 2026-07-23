#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
activated=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_rectangle(x,y,x+sprite_width,y+sprite_height,oPushRock,0,1) or collision_rectangle(x,y,x+sprite_width,y+sprite_height,oPlayer1,0,1)
  {
    if activated=0
    {
      playSound(global.snd_RBSwitch,0,1,1)
      image_index=1
      activated=1
    }
  }
  else
  {
    if activated=1
    {
      image_index=0
      activated=0
    }
  }

  //---------- id checks: specific event per switch ----------
  if room=rGame6_EarthA //----- Map: Earth A -----
  {
    if id=(319740) //Switch A
    {
      if activated=1
      {
        if (319741).y<(319741).ystart+192 {(319741).yVel=4} else {(319741).yVel=0}
      }
      else
      {
        if (319741).y>(319741).ystart {(319741).yVel=-2} else {(319741).yVel=0}
      }
    }
    else if id=(319823) //Switch B1
    {
      if activated=1
      {
        if (319825).y<(319825).ystart+128 {(319825).yVel=4} else {(319825).yVel=0}
      }
      else
      {
        if (319825).y>(319825).ystart {(319825).yVel=-2} else {(319825).yVel=0}
      }
    }
    else if id=(319824) //Switch B2
    {
      if activated=1
      {
        if (319826).y<(319826).ystart+128 {(319826).yVel=4} else {(319826).yVel=0}
      }
      else
      {
        if (319826).y>(319826).ystart {(319826).yVel=-2} else {(319826).yVel=0}
      }
    }
    else if id=(320169) //Switch C1
    {
      if activated=1
      {
        if (320168).y<(320168).ystart+80 {(320168).yVel=4} else {(320168).yVel=0}
      }
      else
      {
        if (320168).y>(320168).ystart {(320168).yVel=-2} else {(320168).yVel=0}
      }
    }
    else if id=(320170) //Switch C2
    {
      if activated=1
      {
        if (320167).y>(320167).ystart-128 {(320167).yVel=-4} else {(320167).yVel=0}
      }
      else
      {
        if (320167).y<(320167).ystart {(320167).yVel=2} else {(320167).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthB //----- Map: Earth B -----
  {
    if id=(320207) //Switch A1
    {
      if activated=1
      {
        if (320418).y>(320418).ystart-96 {(320418).yVel=-4} else {(320418).yVel=0}
      }
      else
      {
        if (320418).y<(320418).ystart {(320418).yVel=4} else {(320418).yVel=0}
      }
    }
    else if id=(320205) //Switch A2
    {
      if activated=1
      {
        if (320416).y>(320416).ystart-128 {(320416).yVel=-4} else {(320416).yVel=0}
      }
      else
      {
        if (320416).y<(320416).ystart {(320416).yVel=4} else {(320416).yVel=0}
      }
    }
    else if id=(320206) //Switch A3
    {
      if activated=1
      {
        if (320417).y>(320417).ystart-128 {(320417).yVel=-4} else {(320417).yVel=0}
      }
      else
      {
        if (320417).y<(320417).ystart {(320417).yVel=4} else {(320417).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthC //----- Map: Earth C -----
  {
    if id=(321311) //Switch A
    {
      if activated=1
      {
        if (321319).y<(321319).ystart+192 {(321319).yVel=4} else {(321319).yVel=0}
      }
      else
      {
        if (321319).y>(321319).ystart {(321319).yVel=-4} else {(321319).yVel=0}
      }
    }
    else if id=(321312) //Switch B1
    {
      if activated=1
      {
        if (321317).y<(321317).ystart+64 {(321317).yVel=4} else {(321317).yVel=0}
      }
      else
      {
        if (321317).y>(321317).ystart {(321317).yVel=-2} else {(321317).yVel=0}
      }
    }
    else if id=(321313) //Switch B2
    {
      if activated=1
      {
        if (321318).y<(321318).ystart+64 {(321318).yVel=4} else {(321318).yVel=0}
      }
      else
      {
        if (321318).y>(321318).ystart {(321318).yVel=-2} else {(321318).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthD //----- Map: Earth D -----
  {
    if id=(321801) //Switch A
    {
      if activated=1
      {
        if (321823).y<(321823).ystart+64 {(321823).yVel=4} else {(321823).yVel=0}
      }
      else
      {
        if (321823).y>(321823).ystart {(321823).yVel=-4} else {(321823).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthE //----- Map: Earth E -----
  {
    if id=(322033) //Switch A
    {
      if activated=1
      {
        if (322034).y<(322034).ystart+32 {(322034).yVel=2} else {(322034).yVel=0}
      }
      else
      {
        if (322034).y>(322034).ystart {(322034).yVel=-2} else {(322034).yVel=0}
      }
    }
    else if id=(322094) //Switch B
    {
      if activated=1
      {
        if (322090).y<(322090).ystart+160 {(322090).yVel=8} else {(322090).yVel=0}
      }
      else
      {
        if (322090).y>(322090).ystart {(322090).yVel=-8} else {(322090).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthF //----- Map: Earth F -----
  {
    if id=(322679) //Switch A1
    {
      if activated=1
      {
        if (322650).y>(322650).ystart-128 {(322650).yVel=-4} else {(322650).yVel=0}
      }
      else
      {
        if (322650).y<(322650).ystart {(322650).yVel=4} else {(322650).yVel=0}
      }
    }
    else if id=(322680) //Switch A2
    {
      if activated=1
      {
        if (322651).y<(322651).ystart+160 {(322651).yVel=4} else {(322651).yVel=0}
      }
      else
      {
        if (322651).y>(322651).ystart {(322651).yVel=-4} else {(322651).yVel=0}
      }
    }
    else if id=(322681) //Switch A3
    {
      if activated=1
      {
        if (322672).x>(322672).xstart-160 {(322672).xVel=-4} else {(322672).xVel=0}
      }
      else
      {
        if (322672).x<(322672).xstart {(322672).xVel=4} else {(322672).xVel=0}
      }
    }
    else if id=(322682) //Switch A4
    {
      if activated=1
      {
        if (322658).y<(322658).ystart+64 {(322658).yVel=4} else {(322658).yVel=0}
      }
      else
      {
        if (322658).y>(322658).ystart {(322658).yVel=-4} else {(322658).yVel=0}
      }
    }
    else if id=(322683) //Switch A5
    {
      if activated=1
      {
        if (322659).y<(322659).ystart+64 {(322659).yVel=4} else {(322659).yVel=0}
      }
      else
      {
        if (322659).y>(322659).ystart {(322659).yVel=-4} else {(322659).yVel=0}
      }
    }
  }
  else if room=rGame6_FireExtra //----- Map: Fire Extra -----
  {
    if id=(326085) //Switch A1
    {
      if activated=1
      {
        if (326240).y<(326240).ystart+128 {(326240).yVel=4} else {(326240).yVel=0}
      }
      else
      {
        if (326240).y>(326240).ystart {(326240).yVel=-4} else {(326240).yVel=0}
      }
    }
    else if id=(326088) //Switch A2
    {
      if activated=1
      {
        if (326241).y<(326241).ystart+96 {(326241).yVel=4} else {(326241).yVel=0}
      }
      else
      {
        if (326241).y>(326241).ystart {(326241).yVel=-4} else {(326241).yVel=0}
      }
    }
  }
  else if room=rGame6_WindB //----- Map: Wind B -----
  {
    if id=(328229) //Switch A1
    {
      if activated=1
      {
        if (328273).y<(328273).ystart+64 {(328273).yVel=4} else {(328273).yVel=0}
      }
      else
      {
        if (328273).y>(328273).ystart {(328273).yVel=-4} else {(328273).yVel=0}
      }
    }
    else if id=(328677) //Switch B1
    {
      if activated=1
      {
        if (328678).x<(328678).xstart+128 {(328678).xVel=4} else {(328678).xVel=0}
      }
      else
      {
        if (328678).x>(328678).xstart {(328678).xVel=-4} else {(328678).xVel=0}
      }
    }
    else if id=(328727) //Switch C1
    {
      if activated=1
      {
        if (328779).x>(328779).xstart-64 {(328779).xVel=-4} else {(328779).xVel=0}
      }
      else
      {
        if (328779).x<(328779).xstart {(328779).xVel=4} else {(328779).xVel=0}
      }
    }
    else if id=(328728) //Switch C2
    {
      if activated=1
      {
        if (328778).x<(328778).xstart+64 {(328778).xVel=4} else {(328778).xVel=0}
      }
      else
      {
        if (328778).x>(328778).xstart {(328778).xVel=-4} else {(328778).xVel=0}
      }
    }
  }
  else if room=rGame6_WindD //----- Map: Wind D -----
  {
    if id=(329157) //Switch A1
    {
      if activated=1
      {
        if (329587).y>(329587).ystart-64 {(329587).yVel=-4} else {(329587).yVel=0}
      }
      else
      {
        if (329587).y<(329587).ystart {(329587).yVel=4} else {(329587).yVel=0}
      }
    }
    else if id=(329357) //Switch B1
    {
      if activated=1
      {
        if (329588).y>(329588).ystart-64 {(329588).yVel=-4} else {(329588).yVel=0}
      }
      else
      {
        if (329588).y<(329588).ystart {(329588).yVel=4} else {(329588).yVel=0}
      }
    }
    else if id=(329301) //Switch B2
    {
      if activated=1
      {
        if (329589).y<(329589).ystart+64 {(329589).yVel=4} else {(329589).yVel=0}
      }
      else
      {
        if (329589).y>(329589).ystart {(329589).yVel=-4} else {(329589).yVel=0}
      }
    }
  }
  else if room=rGame6_WindG //----- Map: Wind G -----
  {
    if id=(331227) //Switch A1
    {
      if activated=1
      {
        if (331385).y<(331385).ystart+32 {(331385).yVel=4} else {(331385).yVel=0}
      }
      else
      {
        if (331385).y>(331385).ystart {(331385).yVel=-4} else {(331385).yVel=0}
      }
    }
    else if id=(331370) //Switch B1
    {
      if activated=1
      {
        if (331381).y<(331381).ystart+64 {(331381).yVel=4} else {(331381).yVel=0}
      }
      else
      {
        if (331381).y>(331381).ystart {(331381).yVel=-4} else {(331381).yVel=0}
      }
    }
    else if id=(331371) //Switch B2
    {
      if activated=1
      {
        if (331380).y<(331380).ystart+64 {(331380).yVel=4} else {(331380).yVel=0}
      }
      else
      {
        if (331380).y>(331380).ystart {(331380).yVel=-4} else {(331380).yVel=0}
      }
    }
  }
}
