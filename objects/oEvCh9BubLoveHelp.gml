#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

bubbProg=0
bubbTime=0
bubbBubble=0
bubbleBub=0
loveProg=0
loveTime=0
loveBubble=0
bubbleLove=0

if global.gameProgress=2090
{
  npcBubblin=instance_create(1264,960,oMisc)
  npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_speed=0.05; npcBubblin.type=1
  npcLovelun=instance_create(1264,896,oMisc)
  npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.image_speed=0.05; npcLovelun.type=1
}
else
{
  npcBubblin=instance_create(1948,80,oMisc)
  npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_speed=0.05; npcBubblin.type=1; npcBubblin.image_xscale=-1
  npcLovelun=instance_create(1924,80,oMisc)
  npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.image_speed=0.05; npcLovelun.type=1
  bubbProg=1000
  loveProg=1000
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sceneProgress=0 //Wait for player to reach the right spot
  {
    if oPlayer1.x>=1200 and oPlayer1.y<=968
    {
      sceneProgress=1
    }
  }
  else if sceneProgress=1
  {
    //---------------------------------------- BUBBLIN ----------------------------------------
    if npcBubblin.sprite_index=sBubblun_Idle {npcBubblin.image_speed=0.05}
    else if npcBubblin.sprite_index=sBubblun_Walk
    {
      npcBubblin.image_speed=0.15
      if npcBubblin.image_xscale=1 {npcBubblin.x+=2}
      else {npcBubblin.x-=2}
    }
    else if npcBubblin.sprite_index=sBubblun_BubbleBlow
    {
      bubbBubble+=1
      if bubbBubble=5 {npcBubblin.sprite_index=sBubblun_Idle; bubbBubble=0}
    }
    else if npcBubblin.sprite_index=sBubblun_Jump {npcBubblin.y-=6}
    else if npcBubblin.sprite_index=sBubblun_Fall {npcBubblin.y+=4}

    if bubbProg!=100 {bubbTime+=1}
    if bubbProg=0 //---------- First Bubble ----------
    {
      if bubbTime=10
      {
        npcBubblin.sprite_index=sBubblun_BubbleBlow
        var tBubble; tBubble=instance_create(npcBubblin.x+8,npcBubblin.y-8,oBubblePlatform); tBubble.shiftMax=42
      }
      else if bubbTime=21 {npcBubblin.sprite_index=sBubblun_Walk; npcBubblin.image_xscale=-1}
      else if bubbTime=48 {npcBubblin.sprite_index=sBubblun_Idle}
      else if bubbTime=53 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump; npcBubblin.image_xscale=1}
      else if bubbTime>=59 and bubbTime<=64
      {
        npcBubblin.x+=4
        if bubbTime=62 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=64 {npcBubblin.sprite_index=sBubblun_Idle}
      }
      else if bubbTime=71 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
      else if bubbTime>=85 and bubbTime<=88 {npcBubblin.x+=4}
      else if bubbTime>=89 and bubbTime<=92
      {
        npcBubblin.x+=4
        if bubbTime=89 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=92 {npcBubblin.sprite_index=sBubblun_Idle}
      }
      else if bubbTime=98 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime=115 {npcBubblin.sprite_index=sBubblun_Idle; bubbTime=0; bubbProg+=1}
    }
    else if bubbProg=1 //---------- Second Bubble ----------
    {
      if bubbTime=20
      {
        npcBubblin.sprite_index=sBubblun_BubbleBlow
        var tBubble; tBubble=instance_create(npcBubblin.x+8,npcBubblin.y-8,oBubblePlatform); tBubble.shiftMax=60
      }
      else if bubbTime=37 {npcBubblin.sprite_index=sBubblun_Walk; npcBubblin.image_xscale=-1}
      else if bubbTime=55 {npcBubblin.sprite_index=sBubblun_Idle}
      else if bubbTime=74 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
      else if bubbTime>=94 and bubbTime<=98
      {
        npcBubblin.x-=4
        if bubbTime=95 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=98 {npcBubblin.sprite_index=sBubblun_Idle}
      }
      else if bubbTime>=107 and bubbTime<=123
      {
        npcBubblin.x-=4
        if bubbTime=107 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
        if bubbTime=120 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=123 {npcBubblin.sprite_index=sBubblun_Idle}
      }
      else if bubbTime>=132 and bubbTime<=147
      {
        npcBubblin.x+=4
        if bubbTime=132 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump; npcBubblin.image_xscale=1}
        if bubbTime=144 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=147 {npcBubblin.sprite_index=sBubblun_Idle}
      }
      else if bubbTime=152 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime=194 {npcBubblin.sprite_index=sBubblun_Idle; bubbTime=0; bubbProg+=1}
    }
    else if bubbProg=2 //---------- Third Bubble ----------
    {
      if bubbTime=60
      {
        npcBubblin.sprite_index=sBubblun_BubbleBlow
        var tBubble; tBubble=instance_create(npcBubblin.x+8,npcBubblin.y-8,oBubblePlatform); tBubble.shiftMax=52
      }
      else if bubbTime=68
      {
        npcBubblin.sprite_index=sBubblun_BubbleBlow
        bubbleBub=instance_create(npcBubblin.x-1,npcBubblin.y-9,oMisc); bubbleBub.sprite_index=sBubBubble
        bubbleBub.image_speed=0; bubbleBub.type=1; bubbleBub.image_alpha=0.6; bubbleBub.depth=39
        bubbleBub.image_xscale=0.1; bubbleBub.image_yscale=0.1
      }
      else if bubbTime>=71 and bubbTime<=82 {bubbleBub.image_xscale+=0.1; bubbleBub.image_yscale+=0.1}
      else if bubbTime>=83 and bubbTime<=122 {bubbleBub.y-=4; npcBubblin.y-=4}
      else if bubbTime=123
      {
        var tFFScl,tEffect;
        for(i=0;i<8;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(bubbleBub.x-8+random(16),bubbleBub.y-8+random(16),oEffectB); tEffect.image_alpha=0.6
          tEffect.type=3; tEffect.sprite_index=sBubBubble; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
          tEffect.direction=random_range(60,120); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
          tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
        with bubbleBub {instance_destroy()}
        bubbTime=0; bubbProg+=1
      }
    }
    else if bubbProg=3 //---------- Fourth Bubble ----------
    {
      if bubbTime=50
      {
        npcBubblin.sprite_index=sBubblun_BubbleBlow
        var tBubble; tBubble=instance_create(npcBubblin.x+8,npcBubblin.y-8,oBubblePlatform); tBubble.shiftMax=52
      }

      else if bubbTime=58
      {
        npcBubblin.sprite_index=sBubblun_BubbleBlow
        bubbleBub=instance_create(npcBubblin.x-1,npcBubblin.y-9,oMisc); bubbleBub.sprite_index=sBubBubble
        bubbleBub.image_speed=0; bubbleBub.type=1; bubbleBub.image_alpha=0.6; bubbleBub.depth=39
        bubbleBub.image_xscale=0.1; bubbleBub.image_yscale=0.1
      }
      else if bubbTime>=61 and bubbTime<=72 {bubbleBub.image_xscale+=0.1; bubbleBub.image_yscale+=0.1}
      else if bubbTime>=73 and bubbTime<=148 {bubbleBub.y-=4; npcBubblin.y-=4}
      else if bubbTime=149
      {
        var tFFScl,tEffect;
        for(i=0;i<8;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(bubbleBub.x-8+random(16),bubbleBub.y-8+random(16),oEffectB); tEffect.image_alpha=0.6
          tEffect.type=3; tEffect.sprite_index=sBubBubble; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
          tEffect.direction=random_range(60,120); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
          tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
        with bubbleBub {instance_destroy()}
        bubbTime=0; bubbProg+=1
      }
    }
    else if bubbProg=4 //---------- Walk toward Heart Island ----------
    {
      if bubbTime=10 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime>=45 and bubbTime<=50
      {
        npcBubblin.x+=4
        if bubbTime=45 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
        if bubbTime=49 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=50 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.y+=4}
      }
      else if bubbTime=51 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime>=66 and bubbTime<=71
      {
        npcBubblin.x+=4
        if bubbTime=66 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
        if bubbTime=70 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=71 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.y+=4}
      }
      else if bubbTime=72 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime>=130 and bubbTime<=148
      {
        npcBubblin.x+=4
        if bubbTime=130 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
        if bubbTime=138 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=148 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.y+=4}
      }
      else if bubbTime=149 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime>=150 and bubbTime<=162 {npcBubblin.y-=1}
      else if bubbTime>=178 and bubbTime<=192 {npcBubblin.y+=1}
      else if bubbTime>=195 and bubbTime<=215
      {
        npcBubblin.x+=4
        if bubbTime=195 {event_user(0); npcBubblin.sprite_index=sBubblun_Jump}
        if bubbTime=203 {npcBubblin.sprite_index=sBubblun_Fall}
        if bubbTime=215 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.y+=4}
      }
      else if bubbTime=216 {npcBubblin.sprite_index=sBubblun_Walk}
      else if bubbTime>=220 and bubbTime<=235 {npcBubblin.y-=1}
      else if bubbTime>=239 and bubbTime<=253 {npcBubblin.y+=1}
      else if bubbTime=269 {npcBubblin.sprite_index=sBubblun_Idle; npcBubblin.image_xscale=-1; bubbProg=1000}
    }

    //---------------------------------------- LOVELUN ----------------------------------------
    if npcLovelun.sprite_index=sLovelun_Idle {npcLovelun.image_speed=0.05}
    else if npcLovelun.sprite_index=sLovelun_Walk
    {
      npcLovelun.image_speed=0.15
      if npcLovelun.image_xscale=1 {npcLovelun.x+=2}
      else {npcLovelun.x-=2}
    }
    else if npcLovelun.sprite_index=sLovelun_BubbleBlow
    {
      bubbBubble+=1
      if bubbBubble=5 {npcLovelun.sprite_index=sLovelun_Idle; bubbBubble=0}
    }
    else if npcLovelun.sprite_index=sLovelun_Jump {npcLovelun.y-=6}
    else if npcLovelun.sprite_index=sLovelun_Fall {npcLovelun.y+=4}

    if loveProg!=100 {loveTime+=1}
    if loveProg=0 //---------- First Bubble ----------
    {
      if loveTime=60
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        var tBubble; tBubble=instance_create(npcLovelun.x+8,npcLovelun.y-8,oBubblePlatform); tBubble.shiftMax=52
      }
      else if loveTime=71 {npcLovelun.sprite_index=sLovelun_Walk; npcLovelun.image_xscale=-1}
      else if loveTime=86 {npcLovelun.sprite_index=sLovelun_Idle}
      else if loveTime=87 {npcLovelun.sprite_index=sLovelun_Fall}
      else if loveTime=91 {npcLovelun.sprite_index=sLovelun_Idle}
      else if loveTime=96 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
      else if loveTime>=111 and loveTime<=114
      {
        npcLovelun.x-=4
        if loveTime=111 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=114 {npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.image_xscale=1}
      }
      else if loveTime>=118 and loveTime<=134
      {
        npcLovelun.x+=4
        if loveTime=118 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=134 {npcLovelun.sprite_index=sLovelun_Idle}
      }
      else if loveTime=139 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime=157 {npcLovelun.sprite_index=sLovelun_Idle; loveTime=0; loveProg+=1}
    }
    else if loveProg=1 //---------- Second Bubble ----------
    {
      if loveTime=60
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        var tBubble; tBubble=instance_create(npcLovelun.x+8,npcLovelun.y-8,oBubblePlatform); tBubble.shiftMax=52
      }
      else if loveTime=67 {npcLovelun.sprite_index=sLovelun_Walk; npcLovelun.image_xscale=-1}
      else if loveTime=85 {npcLovelun.sprite_index=sLovelun_Idle}
      else if loveTime>=87 and loveTime<=97
      {
        npcLovelun.x-=4
        if loveTime=87 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=94 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=97 {npcLovelun.sprite_index=sLovelun_Idle}
      }
      else if loveTime=101 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump; npcLovelun.image_xscale=1}
      else if loveTime>=102 and loveTime<=117
      {
        npcLovelun.x+=3
        if loveTime=102 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=114 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=117 {npcLovelun.sprite_index=sLovelun_Idle}
      }
      else if loveTime=120 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime=138 {npcLovelun.sprite_index=sLovelun_Idle; loveTime=0; loveProg+=1}
    }
    else if loveProg=2 //---------- Third Bubble ----------
    {
      if loveTime=10
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        var tBubble; tBubble=instance_create(npcLovelun.x+8,npcLovelun.y-8,oBubblePlatform); tBubble.shiftMax=64
      }
      else if loveTime=40
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        bubbleLove=instance_create(npcLovelun.x-1,npcLovelun.y-9,oMisc); bubbleLove.sprite_index=sBubBubble
        bubbleLove.image_speed=0; bubbleLove.type=1; bubbleLove.image_alpha=0.6; bubbleLove.depth=39
        bubbleLove.image_xscale=0.1; bubbleLove.image_yscale=0.1
      }
      else if loveTime>=43 and loveTime<=54 {bubbleLove.image_xscale+=0.1; bubbleLove.image_yscale+=0.1}
      else if loveTime>=55 and loveTime<=90 {bubbleLove.y-=4; npcLovelun.y-=4}
      else if loveTime=91
      {
        var tFFScl,tEffect;
        for(i=0;i<8;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(bubbleLove.x-8+random(16),bubbleLove.y-8+random(16),oEffectB); tEffect.image_alpha=0.6
          tEffect.type=3; tEffect.sprite_index=sBubBubble; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
          tEffect.direction=random_range(60,120); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
          tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
        with bubbleLove {instance_destroy()}
        loveTime=0; loveProg+=1
      }
    }
    else if loveProg=3 //---------- Fourth Bubble ----------
    {
      if loveTime=40
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        var tBubble; tBubble=instance_create(npcLovelun.x+8,npcLovelun.y-8,oBubblePlatform); tBubble.shiftMax=72
      }
      else if loveTime=80
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        bubbleLove=instance_create(npcLovelun.x-1,npcLovelun.y-9,oMisc); bubbleLove.sprite_index=sBubBubble
        bubbleLove.image_speed=0; bubbleLove.type=1; bubbleLove.image_alpha=0.6; bubbleLove.depth=39
        bubbleLove.image_xscale=0.1; bubbleLove.image_yscale=0.1
      }
      else if loveTime>=83 and loveTime<=94 {bubbleLove.image_xscale+=0.1; bubbleLove.image_yscale+=0.1}
      else if loveTime>=95 and loveTime<=134 {bubbleLove.y-=4; npcLovelun.y-=4}
      else if loveTime=135
      {
        var tFFScl,tEffect;
        for(i=0;i<8;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(bubbleLove.x-8+random(16),bubbleLove.y-8+random(16),oEffectB); tEffect.image_alpha=0.6
          tEffect.type=3; tEffect.sprite_index=sBubBubble; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
          tEffect.direction=random_range(60,120); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
          tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
        with bubbleLove {instance_destroy()}
        loveTime=0; loveProg+=1
      }
    }
    else if loveProg=4 //---------- Fifth Bubble ----------
    {
      if loveTime=70
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        var tBubble; tBubble=instance_create(npcLovelun.x+8,npcLovelun.y-8,oBubblePlatform); tBubble.shiftMax=72
      }
      else if loveTime=90
      {
        npcLovelun.sprite_index=sLovelun_BubbleBlow
        bubbleLove=instance_create(npcLovelun.x-1,npcLovelun.y-9,oMisc); bubbleLove.sprite_index=sBubBubble
        bubbleLove.image_speed=0; bubbleLove.type=1; bubbleLove.image_alpha=0.6; bubbleLove.depth=39
        bubbleLove.image_xscale=0.1; bubbleLove.image_yscale=0.1
      }
      else if loveTime>=93 and loveTime<=104 {bubbleLove.image_xscale+=0.1; bubbleLove.image_yscale+=0.1}
      else if loveTime>=105 and loveTime<=160 {bubbleLove.y-=4; npcLovelun.y-=4}
      else if loveTime=161
      {
        var tFFScl,tEffect;
        for(i=0;i<8;i+=1)
        {
          tFFScl=random(0.1)
          tEffect=instance_create(bubbleLove.x-8+random(16),bubbleLove.y-8+random(16),oEffectB); tEffect.image_alpha=0.6
          tEffect.type=3; tEffect.sprite_index=sBubBubble; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
          tEffect.direction=random_range(60,120); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
          tEffect.fadeSpd=0.035
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
        }
        with bubbleLove {instance_destroy()}
        loveTime=0; loveProg+=1
      }
    }
    else if loveProg=5 //---------- Walk toward Heart Island ----------
    {
      if loveTime=10 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime>=45 and loveTime<=50
      {
        npcLovelun.x+=4
        if loveTime=45 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=49 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=50 {npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.y+=4}
      }
      else if loveTime=51 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime>=66 and loveTime<=71
      {
        npcLovelun.x+=4
        if loveTime=66 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=70 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=71 {npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.y+=4}
      }
      else if loveTime=72 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime>=130 and loveTime<=148
      {
        npcLovelun.x+=4
        if loveTime=130 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=138 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=148 {npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.y+=4}
      }
      else if loveTime=149 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime>=150 and loveTime<=162 {npcLovelun.y-=1}
      else if loveTime>=178 and loveTime<=192 {npcLovelun.y+=1}
      else if loveTime>=195 and loveTime<=215
      {
        npcLovelun.x+=4
        if loveTime=195 {event_user(1); npcLovelun.sprite_index=sLovelun_Jump}
        if loveTime=203 {npcLovelun.sprite_index=sLovelun_Fall}
        if loveTime=215 {npcLovelun.sprite_index=sLovelun_Idle; npcLovelun.y+=4}
      }
      else if loveTime=216 {npcLovelun.sprite_index=sLovelun_Walk}
      else if loveTime>=220 and loveTime<=235 {npcLovelun.y-=1}
      else if loveTime>=239 and loveTime<=253 {npcLovelun.y+=1}
      else if loveTime=260 {npcLovelun.sprite_index=sLovelun_Idle; loveProg=1000}
    }

    //----- FALL CONDITION -----
    if oPlayer1.y>=896
    {
      if bubbProg>=1 and bubbProg<=10
      {
        if npcBubblin.sprite_index=sBubblun_Idle
        {
          showEmote(npcBubblin.id,0,-26,sEmMad)
          npcBubblin.image_xscale=1
          if instance_exists(bubbleBub) {with bubbleBub {instance_destroy()}}
          bubbTime=0; bubbProg=100
        }
      }
      if loveProg>=1 and loveProg<=10
      {
        if npcLovelun.sprite_index=sLovelun_Idle
        {
          showEmote(npcLovelun.id,0,-26,sEmThinking)
          npcLovelun.image_xscale=1
          if instance_exists(bubbleLove) {with bubbleLove {instance_destroy()}}
          loveTime=0; loveProg=100
        }
      }
    }

    if bubbProg=100 and loveProg=100
    {
      bubbTime+=1
      if bubbTime=30
      {
        npcBubblin.visible=0; npcLovelun.visible=0
        var tEffect;
        tEffect=instance_create(npcBubblin.x,npcBubblin.y-9,oEffect); tEffect.sprite_index=sDustCloud
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(npcLovelun.x,npcLovelun.y-9,oEffect); tEffect.sprite_index=sDustCloud
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if bubbTime=45
      {
        npcBubblin.x=1264; npcBubblin.y=960; npcLovelun.x=1264; npcLovelun.y=896
        npcBubblin.visible=1; npcLovelun.visible=1
        var tEffect;
        tEffect=instance_create(npcBubblin.x,npcBubblin.y-9,oEffect); tEffect.sprite_index=sDustCloud
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect=instance_create(npcLovelun.x,npcLovelun.y-9,oEffect); tEffect.sprite_index=sDustCloud
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      else if bubbTime=60
      {
        bubbTime=0; loveTime=0
        bubbProg=0; loveProg=0
        sceneProgress=0
      }
    }
    if bubbProg=1000 and loveProg=1000
    {
      heartEmit=instance_create(1932,62,oEfHeartEmitter); heartEmit.efDelay=40
      bubbProg=1001; loveProg=1001
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tEffect;
tEffect=instance_create(npcBubblin.x,npcBubblin.y+2,oEffect)
tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tEffect;
tEffect=instance_create(npcLovelun.x,npcLovelun.y+2,oEffect)
tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
