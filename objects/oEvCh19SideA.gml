#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if room=rMain_80
{
  platformSpawn=119
}
else if room=rHiddenVillage_Destroyed
{
  checkForOneInstr=0
  for(i=0;i<7;i+=1)
  {
    instrProg[i]=string_char_at(global.eGateProg,1)
    if instrProg[i]="9" {checkForOneInstr=1}
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rMain_79
  {
    if global.gameProgress=4530 //Jeremy tells the group to go 'through' a wall
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=560
      {
        msgCreate(0,0,"Jeremy","Trust me on this, just run at the wall.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
    }
  }
  else if room=rMain_80 //Automove platforms
  {
    platformSpawn+=1
    if platformSpawn mod 120=0
    {
      var tNewPlat;
      tNewPlat=instance_create(432,-16,oPlatformAutoMove)
      tNewPlat.sprite_index=sInvisibleSolidMask; tNewPlat.image_xscale=4; tNewPlat.spriteChange=2
      tNewPlat.moveSpeedX=0; tNewPlat.moveSpeedY=2
      tNewPlat=instance_create(1632,-16,oPlatformAutoMove)
      tNewPlat.sprite_index=sInvisibleSolidMask; tNewPlat.image_xscale=4; tNewPlat.spriteChange=2
      tNewPlat.moveSpeedX=0; tNewPlat.moveSpeedY=2
      tNewPlat=instance_create(2496,-16,oPlatformAutoMove)
      tNewPlat.sprite_index=sInvisibleSolidMask; tNewPlat.image_xscale=4; tNewPlat.spriteChange=2
      tNewPlat.moveSpeedX=0; tNewPlat.moveSpeedY=2
    }
  }
  else if room=rDiscoA
  {
    if global.gameProgress=4590 //Jeremy warns that Mario Maces deal double damage here
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=960
      {
        msgCreate(0,0,"Jeremy","Careful, those Mario Maces deal double damage in this place. In literal data form, they deal 12 damage instead of 6.",0,2,oMessagePerson,0)
        newMessage.fadingTime=150; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=150 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=2
      {
        msgCreate(0,0,"Jerry","Thank you, Jeremy, for that enlightening second bit.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
    }
  }
  else if room=rDCS_A //It's quiet here
  {
    if global.gameProgress=4730
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=1584
      {
        msgCreate(0,0,"Jeremy","Stand next, or on I guess, to that pillar... Someone goofed on that perspective.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
      else if charDialogue[0]=1 {convo[0]+=1;if convo[0]>=120 {charDialogue[0]+=1; convo[0]=0}}
      if charDialogue[0]=2 and oPlayer1.x>=2272
      {
        msgCreate(0,0,"Claire","You said CHAOS was here, but nothing is around... at all.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
      else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=90 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=4
      {
        msgCreate(0,0,"Jeremy","I detected them around, they're here, we just can't see them.",0,1,oMessagePerson,0)
        newMessage.fadingTime=95; charDialogue[0]+=1
      }
      else if charDialogue[0]=5 {convo[0]+=1;if convo[0]>=95 {charDialogue[0]+=1; convo[0]=0}}
    }
  }
  else if room=rHiddenVillage_Destroyed //Careful before going in
  {
    if global.gameProgress>=4970 and global.gateHProg<100
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=416
        {
          if global.eGateProg="99999990"
          {
            msgCreate(0,0,"Jeremy","I highly recommend you record your progress before going in that thing. I'm getting some super bad vibes from it.",0,3,oMessagePerson,0)
            newMessage.fadingTime=140
          }
          else
          {
            if checkForOneInstr=0
            {
              msgCreate(0,0,"Jeremy","This Gate is locked it seems. I think you need to do something in those other red Gates first.",0,3,oMessagePerson,0)
              newMessage.fadingTime=140
            }
            else
            {
              msgCreate(0,0,"Jeremy","This Gate looks like it won't open until you have the other 7 Instruments.",0,3,oMessagePerson,0)
              newMessage.fadingTime=140
            }
          }
          sceneProgress+=1
        }
      }
    }
  }
}
