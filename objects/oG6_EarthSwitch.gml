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
    if id=(GID(319740)) //Switch A
    {
      if activated=1
      {
        if (GID(319741)).y<(GID(319741)).ystart+192 {(GID(319741)).yVel=4} else {(GID(319741)).yVel=0}
      }
      else
      {
        if (GID(319741)).y>(GID(319741)).ystart {(GID(319741)).yVel=-2} else {(GID(319741)).yVel=0}
      }
    }
    else if id=(GID(319823)) //Switch B1
    {
      if activated=1
      {
        if (GID(319825)).y<(GID(319825)).ystart+128 {(GID(319825)).yVel=4} else {(GID(319825)).yVel=0}
      }
      else
      {
        if (GID(319825)).y>(GID(319825)).ystart {(GID(319825)).yVel=-2} else {(GID(319825)).yVel=0}
      }
    }
    else if id=(GID(319824)) //Switch B2
    {
      if activated=1
      {
        if (GID(319826)).y<(GID(319826)).ystart+128 {(GID(319826)).yVel=4} else {(GID(319826)).yVel=0}
      }
      else
      {
        if (GID(319826)).y>(GID(319826)).ystart {(GID(319826)).yVel=-2} else {(GID(319826)).yVel=0}
      }
    }
    else if id=(GID(320169)) //Switch C1
    {
      if activated=1
      {
        if (GID(320168)).y<(GID(320168)).ystart+80 {(GID(320168)).yVel=4} else {(GID(320168)).yVel=0}
      }
      else
      {
        if (GID(320168)).y>(GID(320168)).ystart {(GID(320168)).yVel=-2} else {(GID(320168)).yVel=0}
      }
    }
    else if id=(GID(320170)) //Switch C2
    {
      if activated=1
      {
        if (GID(320167)).y>(GID(320167)).ystart-128 {(GID(320167)).yVel=-4} else {(GID(320167)).yVel=0}
      }
      else
      {
        if (GID(320167)).y<(GID(320167)).ystart {(GID(320167)).yVel=2} else {(GID(320167)).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthB //----- Map: Earth B -----
  {
    if id=(GID(320207)) //Switch A1
    {
      if activated=1
      {
        if (GID(320418)).y>(GID(320418)).ystart-96 {(GID(320418)).yVel=-4} else {(GID(320418)).yVel=0}
      }
      else
      {
        if (GID(320418)).y<(GID(320418)).ystart {(GID(320418)).yVel=4} else {(GID(320418)).yVel=0}
      }
    }
    else if id=(GID(320205)) //Switch A2
    {
      if activated=1
      {
        if (GID(320416)).y>(GID(320416)).ystart-128 {(GID(320416)).yVel=-4} else {(GID(320416)).yVel=0}
      }
      else
      {
        if (GID(320416)).y<(GID(320416)).ystart {(GID(320416)).yVel=4} else {(GID(320416)).yVel=0}
      }
    }
    else if id=(GID(320206)) //Switch A3
    {
      if activated=1
      {
        if (GID(320417)).y>(GID(320417)).ystart-128 {(GID(320417)).yVel=-4} else {(GID(320417)).yVel=0}
      }
      else
      {
        if (GID(320417)).y<(GID(320417)).ystart {(GID(320417)).yVel=4} else {(GID(320417)).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthC //----- Map: Earth C -----
  {
    if id=(GID(321311)) //Switch A
    {
      if activated=1
      {
        if (GID(321319)).y<(GID(321319)).ystart+192 {(GID(321319)).yVel=4} else {(GID(321319)).yVel=0}
      }
      else
      {
        if (GID(321319)).y>(GID(321319)).ystart {(GID(321319)).yVel=-4} else {(GID(321319)).yVel=0}
      }
    }
    else if id=(GID(321312)) //Switch B1
    {
      if activated=1
      {
        if (GID(321317)).y<(GID(321317)).ystart+64 {(GID(321317)).yVel=4} else {(GID(321317)).yVel=0}
      }
      else
      {
        if (GID(321317)).y>(GID(321317)).ystart {(GID(321317)).yVel=-2} else {(GID(321317)).yVel=0}
      }
    }
    else if id=(GID(321313)) //Switch B2
    {
      if activated=1
      {
        if (GID(321318)).y<(GID(321318)).ystart+64 {(GID(321318)).yVel=4} else {(GID(321318)).yVel=0}
      }
      else
      {
        if (GID(321318)).y>(GID(321318)).ystart {(GID(321318)).yVel=-2} else {(GID(321318)).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthD //----- Map: Earth D -----
  {
    if id=(GID(321801)) //Switch A
    {
      if activated=1
      {
        if (GID(321823)).y<(GID(321823)).ystart+64 {(GID(321823)).yVel=4} else {(GID(321823)).yVel=0}
      }
      else
      {
        if (GID(321823)).y>(GID(321823)).ystart {(GID(321823)).yVel=-4} else {(GID(321823)).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthE //----- Map: Earth E -----
  {
    if id=(GID(322033)) //Switch A
    {
      if activated=1
      {
        if (GID(322034)).y<(GID(322034)).ystart+32 {(GID(322034)).yVel=2} else {(GID(322034)).yVel=0}
      }
      else
      {
        if (GID(322034)).y>(GID(322034)).ystart {(GID(322034)).yVel=-2} else {(GID(322034)).yVel=0}
      }
    }
    else if id=(GID(322094)) //Switch B
    {
      if activated=1
      {
        if (GID(322090)).y<(GID(322090)).ystart+160 {(GID(322090)).yVel=8} else {(GID(322090)).yVel=0}
      }
      else
      {
        if (GID(322090)).y>(GID(322090)).ystart {(GID(322090)).yVel=-8} else {(GID(322090)).yVel=0}
      }
    }
  }
  else if room=rGame6_EarthF //----- Map: Earth F -----
  {
    if id=(GID(322679)) //Switch A1
    {
      if activated=1
      {
        if (GID(322650)).y>(GID(322650)).ystart-128 {(GID(322650)).yVel=-4} else {(GID(322650)).yVel=0}
      }
      else
      {
        if (GID(322650)).y<(GID(322650)).ystart {(GID(322650)).yVel=4} else {(GID(322650)).yVel=0}
      }
    }
    else if id=(GID(322680)) //Switch A2
    {
      if activated=1
      {
        if (GID(322651)).y<(GID(322651)).ystart+160 {(GID(322651)).yVel=4} else {(GID(322651)).yVel=0}
      }
      else
      {
        if (GID(322651)).y>(GID(322651)).ystart {(GID(322651)).yVel=-4} else {(GID(322651)).yVel=0}
      }
    }
    else if id=(GID(322681)) //Switch A3
    {
      if activated=1
      {
        if (GID(322672)).x>(GID(322672)).xstart-160 {(GID(322672)).xVel=-4} else {(GID(322672)).xVel=0}
      }
      else
      {
        if (GID(322672)).x<(GID(322672)).xstart {(GID(322672)).xVel=4} else {(GID(322672)).xVel=0}
      }
    }
    else if id=(GID(322682)) //Switch A4
    {
      if activated=1
      {
        if (GID(322658)).y<(GID(322658)).ystart+64 {(GID(322658)).yVel=4} else {(GID(322658)).yVel=0}
      }
      else
      {
        if (GID(322658)).y>(GID(322658)).ystart {(GID(322658)).yVel=-4} else {(GID(322658)).yVel=0}
      }
    }
    else if id=(GID(322683)) //Switch A5
    {
      if activated=1
      {
        if (GID(322659)).y<(GID(322659)).ystart+64 {(GID(322659)).yVel=4} else {(GID(322659)).yVel=0}
      }
      else
      {
        if (GID(322659)).y>(GID(322659)).ystart {(GID(322659)).yVel=-4} else {(GID(322659)).yVel=0}
      }
    }
  }
  else if room=rGame6_FireExtra //----- Map: Fire Extra -----
  {
    if id=(GID(326085)) //Switch A1
    {
      if activated=1
      {
        if (GID(326240)).y<(GID(326240)).ystart+128 {(GID(326240)).yVel=4} else {(GID(326240)).yVel=0}
      }
      else
      {
        if (GID(326240)).y>(GID(326240)).ystart {(GID(326240)).yVel=-4} else {(GID(326240)).yVel=0}
      }
    }
    else if id=(GID(326088)) //Switch A2
    {
      if activated=1
      {
        if (GID(326241)).y<(GID(326241)).ystart+96 {(GID(326241)).yVel=4} else {(GID(326241)).yVel=0}
      }
      else
      {
        if (GID(326241)).y>(GID(326241)).ystart {(GID(326241)).yVel=-4} else {(GID(326241)).yVel=0}
      }
    }
  }
  else if room=rGame6_WindB //----- Map: Wind B -----
  {
    if id=(GID(328229)) //Switch A1
    {
      if activated=1
      {
        if (GID(328273)).y<(GID(328273)).ystart+64 {(GID(328273)).yVel=4} else {(GID(328273)).yVel=0}
      }
      else
      {
        if (GID(328273)).y>(GID(328273)).ystart {(GID(328273)).yVel=-4} else {(GID(328273)).yVel=0}
      }
    }
    else if id=(GID(328677)) //Switch B1
    {
      if activated=1
      {
        if (GID(328678)).x<(GID(328678)).xstart+128 {(GID(328678)).xVel=4} else {(GID(328678)).xVel=0}
      }
      else
      {
        if (GID(328678)).x>(GID(328678)).xstart {(GID(328678)).xVel=-4} else {(GID(328678)).xVel=0}
      }
    }
    else if id=(GID(328727)) //Switch C1
    {
      if activated=1
      {
        if (GID(328779)).x>(GID(328779)).xstart-64 {(GID(328779)).xVel=-4} else {(GID(328779)).xVel=0}
      }
      else
      {
        if (GID(328779)).x<(GID(328779)).xstart {(GID(328779)).xVel=4} else {(GID(328779)).xVel=0}
      }
    }
    else if id=(GID(328728)) //Switch C2
    {
      if activated=1
      {
        if (GID(328778)).x<(GID(328778)).xstart+64 {(GID(328778)).xVel=4} else {(GID(328778)).xVel=0}
      }
      else
      {
        if (GID(328778)).x>(GID(328778)).xstart {(GID(328778)).xVel=-4} else {(GID(328778)).xVel=0}
      }
    }
  }
  else if room=rGame6_WindD //----- Map: Wind D -----
  {
    if id=(GID(329157)) //Switch A1
    {
      if activated=1
      {
        if (GID(329587)).y>(GID(329587)).ystart-64 {(GID(329587)).yVel=-4} else {(GID(329587)).yVel=0}
      }
      else
      {
        if (GID(329587)).y<(GID(329587)).ystart {(GID(329587)).yVel=4} else {(GID(329587)).yVel=0}
      }
    }
    else if id=(GID(329357)) //Switch B1
    {
      if activated=1
      {
        if (GID(329588)).y>(GID(329588)).ystart-64 {(GID(329588)).yVel=-4} else {(GID(329588)).yVel=0}
      }
      else
      {
        if (GID(329588)).y<(GID(329588)).ystart {(GID(329588)).yVel=4} else {(GID(329588)).yVel=0}
      }
    }
    else if id=(GID(329301)) //Switch B2
    {
      if activated=1
      {
        if (GID(329589)).y<(GID(329589)).ystart+64 {(GID(329589)).yVel=4} else {(GID(329589)).yVel=0}
      }
      else
      {
        if (GID(329589)).y>(GID(329589)).ystart {(GID(329589)).yVel=-4} else {(GID(329589)).yVel=0}
      }
    }
  }
  else if room=rGame6_WindG //----- Map: Wind G -----
  {
    if id=(GID(331227)) //Switch A1
    {
      if activated=1
      {
        if (GID(331385)).y<(GID(331385)).ystart+32 {(GID(331385)).yVel=4} else {(GID(331385)).yVel=0}
      }
      else
      {
        if (GID(331385)).y>(GID(331385)).ystart {(GID(331385)).yVel=-4} else {(GID(331385)).yVel=0}
      }
    }
    else if id=(GID(331370)) //Switch B1
    {
      if activated=1
      {
        if (GID(331381)).y<(GID(331381)).ystart+64 {(GID(331381)).yVel=4} else {(GID(331381)).yVel=0}
      }
      else
      {
        if (GID(331381)).y>(GID(331381)).ystart {(GID(331381)).yVel=-4} else {(GID(331381)).yVel=0}
      }
    }
    else if id=(GID(331371)) //Switch B2
    {
      if activated=1
      {
        if (GID(331380)).y<(GID(331380)).ystart+64 {(GID(331380)).yVel=4} else {(GID(331380)).yVel=0}
      }
      else
      {
        if (GID(331380)).y>(GID(331380)).ystart {(GID(331380)).yVel=-4} else {(GID(331380)).yVel=0}
      }
    }
  }
}
