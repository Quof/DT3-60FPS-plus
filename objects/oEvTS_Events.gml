#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
fadeColor=c_white
fadeAlpha=0
axeSpawnA=0
axeSpawnB=0
exitState=0
serenityEntry=100

if global.gameProgress>=4560
{
  serenityEntry=0
  fadeAlpha=1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rTS_A
  {
    if sceneProgress=0 //Grass and clouds
    {
      if oPlayer1.x>=320
      {
        var tDrawing;
        for(i=0;i<4;i+=1)
        {
          tDrawing=instance_create(64+(i*128),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(77,128,77)
          }
        }
        (393771).bStartMe=1; (393790).bStartMe=1; (393791).bStartMe=1; (393792).bStartMe=1; (393793).bStartMe=1;
        sceneProgress+=1
      }
    }
    else if sceneProgress=1 //A bit more grass
    {
      sceneDelay+=1
      if sceneDelay>=20
      {
        (394935).bStartMe=1;
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2 //Grass, clouds, and tree
    {
      if oPlayer1.x>=1072
      {
        var tDrawing;
        for(i=0;i<3;i+=1)
        {
          tDrawing=instance_create(992+(i*224),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(77,128,77)
          }
          tDrawing=instance_create(1104+(i*224),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_GrassB; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.33; drawSpd=2; drawTime=-1
            image_blend=make_color_rgb(77,128,77)
          }
        }
        axeSpawnA=1
        (394918).bStartMe=1;
        sceneProgress+=1
      }
    }
    else if sceneProgress=3 //Fence
    {
      if oPlayer1.x>=1632
      {
        var tDrawing;
        for(i=0;i<3;i+=1)
        {
          tDrawing=instance_create(1568+(i*112),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_FenceA; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.5; drawSpd=2; drawTime=-1
            image_blend=make_color_rgb(176,148,123)
          }
          tDrawing=instance_create(1472+(i*128),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(77,128,77)
          }
        }
        sceneProgress+=1
      }
    }
    else if sceneProgress=4 //Spawn Second Axe
    {
      if oPlayer1.x>=2336
      {
        var tDrawing;
        for(i=0;i<3;i+=1)
        {
          tDrawing=instance_create(1632+(i*96),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_SmallFlower; texWidth=128; texHeight=128
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(142,132,219)
          }
        }
        axeSpawnB=1
        sceneProgress+=1
      }
    }
    else if sceneProgress=5 //Lots of things to draw
    {
      if oPlayer1.x>=2640
      {
        var tDrawing;
        for(i=0;i<3;i+=1)
        {
          tDrawing=instance_create(2576+(i*112),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(77,128,77)
          }
        }
        sceneProgress+=1
      }
    }
    else if sceneProgress=6 //Lots more things to draw
    {
      sceneDelay+=1
      if sceneDelay=20
      {
        tDrawing=instance_create(2912,304,oTS_DrawingA)
        with tDrawing
        {
          activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
          lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
          image_blend=make_color_rgb(77,128,77)
        }
      }
      else if sceneDelay=35
      {
        tDrawing=instance_create(3024,304,oTS_DrawingA)
        with tDrawing
        {
          activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
          lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
          image_blend=make_color_rgb(77,128,77)
        }
      }
      else if sceneDelay=50
      {
        tDrawing=instance_create(3136,304,oTS_DrawingA)
        with tDrawing
        {
          activationType=1; targetPath=pth_GrassA; texWidth=256; texHeight=256
          lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
          image_blend=make_color_rgb(77,128,77)
        }
      }
      else if sceneDelay=90
      {
        var tDrawing;
        for(i=0;i<5;i+=1)
        {
          tDrawing=instance_create(2640+(i*112),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_GrassB; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(77,128,77)
          }
        }
      }
      else if sceneDelay=100 {(394958).bStartMe=1;}
      else if sceneDelay=110 {(394959).bStartMe=1;}
      else if sceneDelay=120 {(394960).bStartMe=1;}
      else if sceneDelay=180
      {
        var tDrawing;
        for(i=0;i<3;i+=1)
        {
          tDrawing=instance_create(2576+(i*160),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=0; activationDist=144; targetPath=pth_FlowerA; texWidth=256; texHeight=256
            lineType=sTS_LineA; lineScale=0.5; drawSpd=1; drawTime=-1
            image_blend=make_color_rgb(219,132,175)
          }
        }
      }
      else if sceneDelay=240 {(393794).bStartMe=1;}
      else if sceneDelay=360
      {
        var tDrawing;
        for(i=0;i<6;i+=1)
        {
          tDrawing=instance_create(2608+(i*108),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_SmallFlower; texWidth=128; texHeight=128
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(142,132,219)
          }
        }
      }
      else if sceneDelay=380 {(396566).bStartMe=1;}
      else if sceneDelay=510
      {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.image_alpha=0.25 tFlash.fadeSpeed=0.025
        with (394957){instance_destroy()}
      }
    }

    if axeSpawnA>0
    {
      axeSpawnA+=1
      if axeSpawnA=400
      {
        var tDrawing;
        for(i=0;i<6;i+=1)
        {
          tDrawing=instance_create(624+(i*104),304,oTS_DrawingA)
          with tDrawing
          {
            activationType=1; targetPath=pth_SmallFlower; texWidth=128; texHeight=128
            lineType=sTS_LineA; lineScale=0.25; drawSpd=1.25; drawTime=-1
            image_blend=make_color_rgb(142,132,219)
          }
        }
        var tClickItem;
        tClickItem=instance_create(1248,272,oTS_ClickItem)
        tClickItem.sprite_index=sTS_ItemB; tClickItem.maxDist=1440
        tClickItem.questTag=1; tClickItem.questSpotX=1103; tClickItem.questSpotY=281
      }
      else if axeSpawnA=450
      {
        if oPlayer1.x>=992
        {
          msgCreate(0,0,"Chao","I can 'drag' things like that axe around.#Hmm, I'm pretty sure it just needs to be moved somewhere specific.",0,2,oMessagePerson,0)
          newMessage.fadingTime=180
        }
        else {axeSpawnA-=5}
      }
    }
    if axeSpawnB>0
    {
      axeSpawnB+=1
      if axeSpawnB=270
      {
        var tClickItem;
        tClickItem=instance_create(2096,272,oTS_ClickItem)
        tClickItem.sprite_index=sTS_ItemB; tClickItem.maxDist=2560
        tClickItem.questTag=2; tClickItem.questSpotX=2414; tClickItem.questSpotY=281
      }
    }

    if exitState=0 //Check if player is far enough
    {
      if oPlayer1.x>=3232 {exitState=1}
    }
    else if exitState=1 //Fade to white
    {
      fadeAlpha+=0.02
      if fadeAlpha>=1 {exitState=2}
    }
    else if exitState>=2 //Take player to the Hidden Village
    {
      exitState+=1
      if exitState>=15
      {
        stopAllMusic()
        global.newMapX=104; global.newMapY=1216
        room_goto(rHiddenVillage)
      }
    }
  }

  if serenityEntry<100 //Entry after first visit
  {
    fadeAlpha-=0.04
    if fadeAlpha<=0 {serenityEntry=100}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
