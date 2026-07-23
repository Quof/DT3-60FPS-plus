#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
bShowHealthBar=false
bActive=true

//Enemy base statistics
eName="Lv.?? Evil Shadowy Counsilman"
eLevel=27
maxLife=10
life=maxLife
pointWorth=50
expValue=100
atkPower=4
bCanBeBlocked=1
blockCost=20
affiliation=6
dieEffect=0

dialogueSeq=0
dialogueDelay=0
fullSequence=0

deathAnim=0

jeremyText="This guy doesn't do anything but spew back story or something else not relevant to him. No really, he just stands there talking."
chaoText="I'm not sure if I should be happy these guys are so bad or sad."
devText="The Evil Shadowy Council, like the High Heels Girl, were not part of the first pass. The map before this led straight to the Overlord boss fight in that version."
extraInfo="Pretty worthless."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and life>0
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    if dialogueSeq>0
    {
      if dialogueDelay=0
      {
        if fullSequence=1 //Achievement
        {
          var tCheckAchieve;
          tCheckAchieve=string_char_at(global.tokenRecognitions,24)
          if tCheckAchieve="0"
          {
            var tAchievement;
            tAchievement=instance_create(0,0,oAchievementNotice)
            tAchievement.myAchievement="Avid Listener"; tAchievement.checkNum=24
          }
        }

        if type=1 //Counsilman A
        {
          if dialogueSeq=1
          {
            msgCreate(0,0,"Evil Shadowy Councilman A","He showed us a world outside of our own. I don't fully understand it all, but wow is it more than imagined!",6,3,oMessagePerson,0)
            newMessage.fadingTime=130; dialogueDelay=130
          }
          else if dialogueSeq=2
          {
            msgCreate(0,0,"Evil Shadowy Councilman A","It had some problems though. I couldn't figure out what they were. I simply couldn't put my finger on it.",6,3,oMessagePerson,0)
            newMessage.fadingTime=130; dialogueDelay=130
          }
          else if dialogueSeq=3
          {
            msgCreate(0,0,"Evil Shadowy Councilman A","Unnecessary conflicts out there. Can't everyone get along? See that we can all work together?",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
          else if dialogueSeq=4
          {
            msgCreate(0,0,"Evil Shadowy Councilman A","Hmm, now where was I in the story? ... OH RIGHT!!",6,3,oMessagePerson,0)
            newMessage.fadingTime=90; dialogueDelay=90
          }
        }
        else if type=2 //Counsilman B
        {
          if dialogueSeq=1
          {
            msgCreate(0,0,"Evil Shadowy Councilman B","Ah yes, the best part of it all is that he learned more of the outside world from the Overlord!",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
          else if dialogueSeq=2
          {
            msgCreate(0,0,"Evil Shadowy Councilman B","These 'bots'. I've started to somewhat comprehend the understanding that I too am one of them.",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
          else if dialogueSeq=3
          {
            msgCreate(0,0,"Evil Shadowy Councilman B","The outside world has an army of bots. A scary and powerful army. The Overlord showed us.",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
          else if dialogueSeq=4
          {
            msgCreate(0,0,"Evil Shadowy Councilman B","He showed us how they could take over and crush all opposition. They could even invade our lands.",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
          else if dialogueSeq=5
          {
            msgCreate(0,0,"Evil Shadowy Councilman B","And... uh oh, I think I forgot what I was talking about. Hmm... ah yes, the best part I think!",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
        }
        else if type=3 //Counsilman C
        {
          if dialogueSeq=1
          {
            msgCreate(0,0,"Evil Shadowy Councilman C","You see, in the world beyond ours is a grand creature. It will tear the land apart.",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
          else if dialogueSeq=2
          {
            msgCreate(0,0,"Evil Shadowy Councilman C","The Overlord showed it to me. If the creature is not saved, it will bring about a catastrope greater than anyone is able to contain.",6,3,oMessagePerson,0)
            newMessage.fadingTime=140; dialogueDelay=140
          }
          else if dialogueSeq=3
          {
            msgCreate(0,0,"Evil Shadowy Councilman C","An unstoppable invincible creature. But he said there is a way to stop it.",6,3,oMessagePerson,0)
            newMessage.fadingTime=110; dialogueDelay=110
          }
          else if dialogueSeq=4
          {
            msgCreate(0,0,"Evil Shadowy Councilman C","But one would need to do so before that rampage begins. Before it is called into action by the one who controls it.",6,3,oMessagePerson,0)
            newMessage.fadingTime=130; dialogueDelay=130
          }
          else if dialogueSeq=5
          {
            msgCreate(0,0,"Evil Shadowy Councilman C","That control must be severed. Which can, eh... what was that next part? Oh memories, there you are!",6,3,oMessagePerson,0)
            newMessage.fadingTime=120; dialogueDelay=120
          }
        }
      }
      else
      {
        dialogueDelay-=1
        if dialogueDelay=0 //Increment dialogue sequence up by 1
        {
          dialogueSeq+=1
          if type=1 and dialogueSeq=5 {fullSequence=1; dialogueSeq=1}
          else if type=2 and dialogueSeq=6 {fullSequence=1; dialogueSeq=1}
          else if type=3 and dialogueSeq=6 {fullSequence=1; dialogueSeq=1}
        }
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    image_speed=0
    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_HardHit1,0,0.9,1)}
      tEffect=instance_create(x+random_range(-18,18),y-(sprite_height/2)+random_range(-18,18),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

      tEffect=instance_create(x+random_range(-36,36),y-(sprite_height/2)+random_range(-36,36),oEffect)
      tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

      tEffect=instance_create(x+random_range(-54,54),y-(sprite_height/2)+random_range(-54,54),oEffect)
      tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0
    {
      oEvCh15MainA.sceneProgress=0
      if type=1 {global.gameProgress=3852}
      else if type=2 {global.gameProgress=3853}
      else if type=3 {global.gameProgress=3854}
      instance_destroy()
    }
  }
  enemyStepEvent()
}
