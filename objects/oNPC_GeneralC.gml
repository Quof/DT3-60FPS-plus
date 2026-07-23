#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: progTag
makeActive()
setCollisionBounds(-8,-46,8,-1)
bWaitForInput=false
bTalking=0
sceneProgress=0
progTag=0
event_user(0)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=true and bTalking=1
{
  if bWaitForInput=false
    msgCreate(0,0,myChar[sceneProgress],myString[sceneProgress],0,3,oMessageCutscene,1)

  keyWaitForInput()

  if sceneProgress>=maxString
  {
    if progTag>0 //Check for game state progress
    {
      global.gameProgress+=progTag
      progTag=0
      with oNPC_GeneralC //Set new npc state if needed
      {
        event_user(0)
      }
    }
    sceneProgress=0
    bTalking=0
    global.gamePaused=false
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  if oPlayer1.state=oPlayer1.STANDING or oPlayer1.state=oPlayer1.RUNNING or oPlayer1.state=oPlayer1.DUCKING or oPlayer1.state=oPlayer1.LOOKING_UP
  {
    global.recPeopleTalkNum+=1
    with oMessageNPCchat {instance_destroy()}
    sceneProgress=0
    scenePChk(oPlayer1.x,oPlayer1.y,0,0.1,1)
    if oPlayer1.x<=x {oPlayer1.x=x-32; oPlayer1.image_xscale=1}
    else {oPlayer1.x=x+32; oPlayer1.image_xscale=-1}

    if sprite_index=sWarmasterA_Idle
    {
      if x<=oPlayer1.x {image_xscale=1.25}
      else {image_xscale=-1.25}
    }
    else
    {
      if x<=oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }
    bTalking=1
    global.gamePaused=true
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if npcTag=1 //------------------------- Hometown - NPC A -------------------------
{
  if global.gameProgress<=3430
  {
    maxString=6
    myChar[0]="Claire"
    myString[0]="Why didn't you bring him inside?"
    myChar[1]="NPC A"
    myString[1]="We can't go in any of the houses here. The designers never got around to making that."
    myChar[2]="Claire"
    myString[2]="So you know what we're in then..."
    myChar[3]="NPC A"
    myString[3]="A lot of bots are aware, at least those of us who were given the ability to do so. You might be surprised how many of us there are."
    myChar[4]="Claire"
    myString[4]="That's interesting... So what happened to everyone else in this town?"
    myChar[5]="NPC A"
    myString[5]="They all moved to the 'Plot Related Town'. Bunch of good for nothings! I didn't want to leave, so here I am. I prefer to be out here alone anyway."
  }
  else if global.gameProgress>=3440 and global.gameProgress<=3450
  {
    maxString=2
    myChar[0]="Claire"
    myString[0]="Where is the Earth Temple?"
    myChar[1]="NPC A"
    myString[1]="To the west, just north of the Plains of the Hero."
  }
  else if global.gameProgress>=3460 and global.gameProgress<=3510
  {
    maxString=5
    myChar[0]="Claire"
    myString[0]="So you just let Jerry go? Just like that? You didn't tell him where we were going?"
    myChar[1]="NPC A"
    myString[1]="I was distracted?"
    myChar[2]="Claire"
    myString[2]="Nevermind, I've got a dungeon level to complete."
    myChar[3]="Jeremy"
    myString[3]="And EXP to grind!"
    myChar[4]="Claire"
    myString[4]="Nope!"
  }
  else if global.gameProgress>=3520 and global.gameProgress<=3530
  {
    maxString=2
    myChar[0]="Claire"
    myString[0]="You said the Fire Temple is south?"
    myChar[1]="NPC A"
    myString[1]="Yes, though it's more of a cave. Still, it has a Crystal in it."
  }
  else if global.gameProgress>=3540 and global.gameProgress<=3570
  {
    maxString=4
    myChar[0]="NPC A"
    myString[0]="Great, you found your friend! All is as it should be."
    myChar[1]="Jerry"
    myString[1]="Serious question...#Did you hit me in the face with a large object when I landed here?"
    myChar[2]="NPC A"
    myString[2]="It was a frying pan, and yes. You startled me!"
    myChar[3]="Jerry"
    myString[3]="Conversation over then."
  }
  else if global.gameProgress>=3580
  {
    maxString=6
    myChar[0]="NPC A"
    myString[0]="Making your way to the Wind Temple I see."
    myChar[1]="Jerry"
    myString[1]="It's a scary thought. Wind usually means awful things."
    myChar[2]="NPC A"
    myString[2]="raocow will undoubtedly fall many times."
    myChar[3]="Jerry"
    myString[3]="What?"
    myChar[4]="NPC A"
    myString[4]="Carry on."
    myChar[5]="Jerry"
    myString[5]="Uh, sure buddy."
  }
}
else if npcTag=2 //------------------------- Hero Plains E - Cat -------------------------
{
  maxString=5
  myChar[0]="Claire"
  myString[0]="What are you doing out here?"
  myChar[1]="Cat NPC"
  myString[1]="I'm a cat."
  myChar[2]="Claire"
  myString[2]="So..."
  myChar[3]="Cat NPC"
  myString[3]="I like to be alone... Hint hint."
  myChar[4]="Claire"
  myString[4]="Whatever."
}
else if npcTag=3 //------------------------- Plot Related Town - NPC B -------------------------
{
  if global.gameProgress=3580
  {
    progTag=1
    maxString=5
    myChar[0]="NPC B"
    myString[0]="What brings you to our town?"
    myChar[1]="Claire"
    myString[1]="We need to get into the Wind Temple."
    myChar[2]="NPC B"
    myString[2]="Oh the ledge that's too high. Ha! It stops everyone!"
    myChar[3]="Claire"
    myString[3]="Any way to get past that?"
    myChar[4]="NPC B"
    myString[4]="I don't know, but I'm sure someone else in town would know how."
  }
  else if global.gameProgress>=3581 and global.gameProgress<=3589
  {
    maxString=1
    myChar[0]="NPC B"
    myString[0]="I love that 'just a bit too high' ledge."
  }
  else if global.gameProgress>=3590
  {
    maxString=3
    myChar[0]="NPC B"
    myString[0]="I'm a bit disappointed that you figured out how to get past the barely too high ledge. It's such a great joke."
    myChar[1]="Claire"
    myString[1]="And you're the only one laughing. I really hate the NPCs in this place."
    myChar[2]="Jerry"
    myString[2]="They're not so bad."
  }
}
else if npcTag=4 //------------------------- Plot Related Town - NPC C -------------------------
{
  if global.gameProgress=3580
  {
    maxString=2
    myChar[0]="NPC C"
    myString[0]="These flowers won't tend to themselves, so I don't have much to say right now."
    myChar[1]="Claire"
    myString[1]="I completely understand."
  }
  else if global.gameProgress=3581
  {
    progTag=1
    maxString=9
    myChar[0]="NPC C"
    myString[0]="Can't you see I'm looking at the flowers? If I don't do it, who else will?"
    myChar[1]="Claire"
    myString[1]="I was wondering if you knew how to get past the first ledge in the Wind Temple?"
    myChar[2]="NPC C"
    myString[2]="Sure, jump higher."
    myChar[3]="Claire"
    myString[3]="Oh right, I TOTALLY DIDN'T THINK OF THAT!?"
    myChar[4]="NPC C"
    myString[4]="That's why I told you."
    myChar[5]="Claire"
    myString[5]="Ugh, nevermind. You obviously don't know."
    myChar[6]="NPC C"
    myString[6]="Of course I do, I told you to jump higher."
    myChar[7]="Claire"
    myString[7]="Okay, how do I jump higher?"
    myChar[8]="NPC C"
    myString[8]="Someone else in town will probably know that."
  }
  else if global.gameProgress>=3582 and global.gameProgress<=3589
  {
    maxString=1
    myChar[0]="NPC C"
    myString[0]="I already told you, go find someone else who knows how to jump higher."
  }
  else if global.gameProgress>=3590
  {
    maxString=3
    myChar[0]="NPC C"
    myString[0]="I overheard your conversation with NPC D and man you suck. This whole time you could have easily just gone into the cave forest... whatever, and obtained that ability and not wasted any time here. Such a shame."
    myChar[1]="Claire"
    myString[1]="I really don't like you."
    myChar[2]="NPC C"
    myString[2]="Nobody does... except these flowers."
  }
}
else if npcTag=5 //------------------------- Plot Related Town - NPC D -------------------------
{
  if global.gameProgress<=3581
  {
    maxString=5
    myChar[0]="NPC D"
    myString[0]="I once jumped again while in the air!"
    myChar[1]="Claire"
    myString[1]="That is very special."
    myChar[2]="Jerry"
    myString[2]="I'd love to have a double jump."
    myChar[3]="Claire"
    myString[3]="We have air dashing."
    myChar[4]="Jerry"
    myString[4]="That's not even close to the same thing."
  }
  else if global.gameProgress=3582 and global.gameProgress<=3589
  {
    progTag=8
    maxString=6
    myChar[0]="Claire"
    myString[0]="Do you know anything about jumping higher?"
    myChar[1]="NPC D"
    myString[1]="You mean the greatest feat in existence!"
    myChar[2]="Jerry"
    myString[2]="Yep, that. How do we do it!"
    myChar[3]="NPC D"
    myString[3]="Just north of here is a cave that's not really a cave. In that is an object that allows one to jump once again while in the air."
    myChar[4]="Claire"
    myString[4]="That's it?"
    myChar[5]="NPC D"
    myString[5]="Yep, it's the easiest thing to acquire, too. I'm not sure how you didn't already."
  }
  else if global.gameProgress>=3590
  {
    maxString=2
    myChar[0]="Claire"
    myString[0]="Thanks for the help, even if that last bit was a bit condescending."
    myChar[1]="NPC D"
    myString[1]="Spreading joy while making myself look better is what I do!"
  }
}
else if npcTag=6 //------------------------- Plot Related Town - NPC E -------------------------
{
  if global.gameProgress>=3580 and global.gameProgress<=3791
  {
    maxString=1
    myChar[0]="NPC E"
    myString[0]="One day, I hope to reveal to a great adventurer the location of the Great Bird."
  }
  else if global.gameProgress=3792
  {
    progTag=8
    maxString=11
    myChar[0]="Claire"
    myString[0]="We need to find the Great Bird. Do you know of its location."
    myChar[1]="NPC E"
    myString[1]="OMG OMG OMG!!!! I HAVE ALWAYS WANTED TO REVEAL IT'S LOCATION TO A GREAT ADVENTURER!!!! ARE YOU A GREAT ADVENTURER?!?!"
    myChar[2]="Claire"
    myString[2]="We most certainly are. We're actually the greatest of adventurers!"
    myChar[3]="NPC E"
    myString[3]="Oh man oh man oh man!"
    myChar[4]="NPC E"
    myString[4]="IT'S IN WHISPERING WOODS!!!!"
    myChar[5]="Claire"
    myString[5]="Huh? But I've been to that place. It's just a patch of trees. There's no bird there."
    myChar[6]="NPC E"
    myString[6]="It's there, but only if you go there with the intention of finding it."
    myChar[7]="Claire"
    myString[7]="So basically an event flag. Gotcha."
    myChar[8]="NPC E"
    myString[8]="There's no race here."
    myChar[9]="Claire"
    myString[9]="You are absolutely right, we'll be moving on now. Thanks for the help."
    myChar[10]="NPC E"
    myString[10]="MY PLEASURE!!"
  }
  else if global.gameProgress>=3800
  {
    maxString=3
    myChar[0]="NPC E"
    myString[0]="Why did you want to know where the Great Bird was?"
    myChar[1]="Claire"
    myString[1]="So we can take on the Overlord."
    myChar[2]="NPC E"
    myString[2]="Oh, I'm so sorry I told you where the Great Bird was."
  }
}
else if npcTag=7 //------------------------- Plot Related Town - NPC F -------------------------
{
  if global.gameProgress>=3580 and global.gameProgress<=3790
  {
    maxString=4
    myChar[0]="Claire"
    myString[0]="Did any of you ever live in Hometown?"
    myChar[1]="NPC F"
    myString[1]="All of us used to, but NPC A is a bit crazy. Some say he has a great big secret."
    myChar[2]="Claire"
    myString[2]="What did he do?"
    myChar[3]="NPC F"
    myString[3]="He's just, crazy. You know? He used to ask a lot of questions."
  }
  else if global.gameProgress=3791
  {
    progTag=1
    maxString=11
    myChar[0]="Claire"
    myString[0]="We need to get to the Overlord. Would you be willing to tell us how we can do that?"
    myChar[1]="NPC F"
    myString[1]="Oh that's easy. You just need to find the Great Bird!"
    myChar[2]="Claire"
    myString[2]="What about once we get to the castle? Are there any locks or seals?"
    myChar[3]="NPC F"
    myString[3]="Oh that's easy. You just need to find the Great Bird!"
    myChar[4]="Claire"
    myString[4]="What? You... already said that."
    myChar[5]="NPC F"
    myString[5]="Oh that's easy. You just need to find the Great Bird!"
    myChar[6]="Chao"
    myString[6]="I think she's bugged."
    myChar[7]="Claire"
    myString[7]="I know what you're going to say to that, Jerry. Don't even try it."
    myChar[8]="Jerry"
    myString[8]="Yeah yeah."
    myChar[9]="NPC F"
    myString[9]="Oh that's easy. You just need to find the Great Bird!"
    myChar[10]="Claire"
    myString[10]="Ugh."
  }
  else if global.gameProgress>=3792
  {
    maxString=1
    myChar[0]="NPC F"
    myString[0]="Oh that's easy. You just need to find the Great Bird!"
  }
}
else if npcTag=8 //------------------------- Plot Related Town - NPC G -------------------------
{
  if global.gameProgress>=3580 and global.gameProgress<=3780
  {
    maxString=3
    myChar[0]="NPC G"
    myString[0]="I hope the Great Evil Overlord never comes back. My god, you don't want to know what it was like with him around."
    myChar[1]="Claire"
    myString[1]="Isn't he in his castle?"
    myChar[2]="NPC G"
    myString[2]="Heck no, his true powers have been sealed away. But if he were to have them back... I... I don't want to think about that. We simply don't have the answers!!"
  }
  else if global.gameProgress=3790
  {
    progTag=1
    maxString=8
    myChar[0]="Claire"
    myString[0]="Didn't you mention you never wanted the Overlord to come back... well... he's back."
    myChar[1]="NPC G"
    myString[1]="Whoa WHAT?! How did that happen?!"
    myChar[2]="Claire"
    myString[2]="He shattered the Crystals and regained his lost power."
    myChar[3]="NPC G"
    myString[3]="No... oh no. He's going to do it again!"
    myChar[4]="Claire"
    myString[4]="What's he going to do again?"
    myChar[5]="NPC G"
    myString[5]="You don't want to know, trust me. Just... HOW DOES HE KNOW SO MUCH?!"
    myChar[6]="Claire"
    myString[6]="Okay, so how do we get to his castle? We need to defeat him."
    myChar[7]="NPC G"
    myString[7]="I would never send anyone to that horrible fate. You'll need to ask someone else about that."
  }
  else if global.gameProgress=3791
  {
    maxString=1
    myChar[0]="NPC G"
    myString[0]="Find someone else to tell you how to get to him. I think someone nearer to the left side of town would do something like that."
  }
  else if global.gameProgress>=3792
  {
    maxString=1
    myChar[0]="NPC G"
    myString[0]="Good luck with the Great Evil Overlord. He's the most horrible dude in the land."
  }
}
else if npcTag=9 //------------------------- Monster Isle - NPC H -------------------------
{
  maxString=9
  myChar[0]="NPC H"
  myString[0]="Welcome to one of the most boring places in the world!"
  myChar[1]="Jerry"
  myString[1]="That's quite a selling point. For science though, why is it so boring here?"
  myChar[2]="NPC H"
  myString[2]="All that happens is very high level monsters spawning in at fairly random places."
  myChar[3]="Jerry"
  myString[3]="So it's for grinding?"
  myChar[4]="NPC H"
  myString[4]="They spawn too slow for them to be effective for even that."
  myChar[5]="Jerry"
  myString[5]="How slow are we talking here?"
  myChar[6]="NPC H"
  myString[6]="The first spawns in around 12 seconds, the rest are every 24 seconds. Like I said, this place sucks."
  myChar[7]="Jerry"
  myString[7]="You said boring."
  myChar[8]="NPC H"
  myString[8]="Same thing."
}
else if npcTag=10 //------------------------- Central City (Story House) - John -------------------------
{
  if global.gameProgress<=4180
  {
    maxString=9
    myChar[0]="John"
    myString[0]="You guys must hate me and the team for this."
    myChar[1]="Jeremy"
    myString[1]="That's silly, we have no reason to. Your core team really wanted to do something awesome, none of you saw something crazy like this happening."
    myChar[2]="John"
    myString[2]="We had a silly joke amongst the team that we'd make the game to end all games."
    myChar[3]="Jeremy"
    myString[3]="Irony's a bitch.#So, do you hate what you've made?"
    myChar[4]="John"
    myString[4]="A part of me says yes, but I look around and just think about how amazing this is. Frightening, but amazing."
    myChar[5]="Jeremy"
    myString[5]="Jerry and I grew up talking about how cool it would be to live in the worlds of the games we played."
    myChar[6]="John"
    myString[6]="I did the same with my friends. Do you still think the same as you did back then?"
    myChar[7]="Jeremy"
    myString[7]="I don't know what to think. Video games were my passion and a hobby growing up, and then later became an escape. Maybe they still are now."
    myChar[8]="John"
    myString[8]="I hope you figure it out soon."
  }
  else if global.gameProgress>=4190 and global.gameProgress<=4500
  {
    maxString=4
    myChar[0]="Jeremy"
    myString[0]="What brought you to this project anyway? To work on it?"
    myChar[1]="John"
    myString[1]="I wanted to create a world that everyone could enjoy and share, I think is the easiest answer. But moreso, there's something I wanted to create for someone that I knew would be special to me."
    myChar[2]="Jeremy"
    myString[2]="Do you think you succeeded?"
    myChar[3]="John"
    myString[3]="No, she couldn't be here to see it."
    myChar[4]="Jeremy"
    myString[4]="A girlfriend of yours?"
    myChar[5]="John"
    myString[5]="No, and you should get going to the hidden facility that CHAOS has."
  }
  else if global.gameProgress>=4510 and global.gameProgress<=4570
  {
    maxString=6
    myChar[0]="John"
    myString[0]="So the two are sending you through the Tranquil Serenity... I'd rather not hear about it honestly."
    myChar[1]="Jerry"
    myString[1]="Why is that?"
    myChar[2]="Claire"
    myString[2]="JERRY!"
    myChar[3]="Jerry"
    myString[3]="What?... Oh fine. I'll leave it be."
    myChar[4]="John"
    myString[4]="It's not some harsh place, it's just... special."
    myChar[5]="Jerry"
    myString[5]="Fair enough. Sorry to bring it up."
  }
  else if global.gameProgress>=4580 and global.gameProgress<=4700
  {
    maxString=7
    myChar[0]="John"
    myString[0]="Their idea is sending you to Kirby? None of us have seen him in a long time."
    myChar[1]="Jeremy"
    myString[1]="What's going on with Kirby anyway?"
    myChar[2]="John"
    myString[2]="That bot just likes to keep to himself most of the time. I guess the program wasn't exactly sure what sort of personality to give to him. So he's a bit out there, and rarely talks to humans. Heck, he barely talks to me!"
    myChar[3]="Jeremy"
    myString[3]="Do you think Kirby will give us any resistance?"
    myChar[4]="John"
    myString[4]="He may decide not to help you, but he's not dangerous. Well, at least as long as you leave when he wants you to."
    myChar[5]="Jeremy"
    myString[5]="If he at least gives us his Dragoon part, we can get the other bots in that village to help us."
    myChar[6]="John"
    myString[6]="I wouldn't be surprised if some of them come over to help you find Kirby. Trust me, most of the bots there are very willing to help you fight CHAOS."
  }
  else if global.gameProgress>=4710
  {
    maxString=3
    myChar[0]="John"
    myString[0]="Damn, I didn't think Hex would do this."
    myChar[1]="Jeremy"
    myString[1]="I'm very sure he did it only to mess with us. I doubt he cared whether Kirby lives or dies."
    myChar[2]="John"
    myString[2]="It makes me worry what he's going to do with that warship and the CHAOS army."
  }
}
else if npcTag=11 //------------------------- Bot Village - Bubblun -------------------------
{
  if global.gameProgress<=4700
  {
    maxString=10
    myChar[0]="Bubblun"
    myString[0]="You probably couldn't get to the place Kirby is hiding in before now since the path used to be closed up."
    myChar[1]="Bubblun"
    myString[1]="The creature that escaped from the Vault has been moving around in the desert more, so it probably moved some of the rocks in the process."
    myChar[2]="Jeremy"
    myString[2]="What's up with that thing anyway? The Abomination I believe it was called."
    myChar[3]="Bubblun"
    myString[3]="It is just a creature that was made from a bunch of parts the program had. It has immense destructive power and is incredibly dangerous if it is upset."
    myChar[4]="Jeremy"
    myString[4]="But what's the deal with it? What's really going on, if you know."
    myChar[5]="Bubblun"
    myString[5]="The creature isn't inherently bad. But due to what it is capable of, it had to be put away. Maybe the program could have put it somewhere away from everyone that wasn't the Vault."
    myChar[6]="Bubblun"
    myString[6]="Left how it is, and it'll rampage through the Mainland eventually. Someone will disturb it."
    myChar[7]="Jeremy"
    myString[7]="When Jerry and Claire were running from it in the Vault, it was actively chasing them. It seemed like it was following Hex' commands."
    myChar[8]="Bubblun"
    myString[8]="I really hope that isn't the case and you all were just unlucky."
    myChar[9]="Jeremy"
    myString[9]="That's a lot of unlucky moments."
  }
  else if global.gameProgress>=4710
  {
    maxString=5
    myChar[0]="Bubblun"
    myString[0]="Remember, you're trying to find some old temple in the southern parts of the Farreaches."
    myChar[1]="Jerry"
    myString[1]="Hey... thanks."
    myChar[2]="Bubblun"
    myString[2]="For what?"
    myChar[3]="Jerry"
    myString[3]="Not yelling at us about Kirby, I mean, you haven't always been the nicest one to us."
    myChar[4]="Bubblun"
    myString[4]="That wasn't your fault."
  }
}
else if npcTag=12 //------------------------- Bot Village - Lovelun -------------------------
{
  if global.gameProgress<=4700
  {
    maxString=4
    myChar[0]="Lovelun"
    myString[0]="I think you guys will have no problems convincing Kirby to help everyone. He doesn't like CHAOS any more than any of us here. If you tell him what they're doing, I'm sure he'll want to help."
    myChar[1]="Chao"
    myString[1]="Thanks for the vote of confidence. I think we'll have no problems too."
    myChar[2]="Lovelun"
    myString[2]="Good luck you guys! Oh yes, Chao! After all of this is over, I'd love to, oh what's the word... hang out with you! I have so many things to ask about humans!"
    myChar[3]="Chao"
    myString[3]="We will do this!"
  }
  else if global.gameProgress>=4710
  {
    maxString=8
    myChar[0]="Chao"
    myString[0]="Sorry about what happened. Is Bubblun going to be okay?"
    myChar[1]="Bubblun"
    myString[1]="I'm right here!"
    myChar[2]="Lovelun"
    myString[2]="Yes, he'll be fine."
    myChar[3]="Chao"
    myString[3]="Do you know anything about this temple we're going to?"
    myChar[4]="Lovelun"
    myString[4]="Only what Bubby does, and it isn't much. It's mostly just a place filled with some old traps."
    myChar[5]="Chao"
    myString[5]="Jerry and Claire are good at avoiding those, I think this will be a piece of cake!"
    myChar[6]="Lovelun"
    myString[6]="I hope that means you can get the piece quick. The quicker you guys stop CHAOS, the quicker the two of us can hang out!"
    myChar[7]="Chao"
    myString[7]="Yes! It's gonna be great!"
  }
}
else if npcTag=13 //------------------------- Central City (North B) - Business Man -------------------------
{
  if global.gameProgress<=1510
  {
    maxString=10
    myChar[0]="Business Man"
    myString[0]="Syrus said to keep this barrier up. I can't take it down right now. Though I know who you guys are, orders are orders."
    myChar[1]="Jerry"
    myString[1]="What's on the other side?"
    myChar[2]="Business Man"
    myString[2]="Just some land that we haven't explored much lately. When the virus took over, the bots in the area became aggressive."
    myChar[3]="Jerry"
    myString[3]="I guess nothing can get in at least."
    myChar[4]="Business Man"
    myString[4]="That's the idea.#So have you guys heard of CHAOS?"
    myChar[5]="Jerry"
    myString[5]="Nope. Is that an acronym for something?"
    myChar[6]="Business Man"
    myString[6]="I don't think so. It's just what a certain very large group of bots call themselves."
    myChar[7]="Jeremy"
    myString[7]="Are they hostile at all?"
    myChar[8]="Business Man"
    myString[8]="Not sure, but the friendly bots around here don't speak too kindly of them. Rumor has it that they can build other bots, but you know how rumors go. Bots creating other bots? I don't think so."
    myChar[9]="Jeremy"
    myString[9]="Other than standard summoning, definitely not."
  }
  else if global.gameProgress>=1520 and global.gameProgress<=1530
  {
    maxString=1
    myChar[0]="Business Man"
    myString[0]="We've lifted the barrier, but if you need to get through, you'll have to come back in a moment. I had to activate the barrier again while I test something."
  }
  else if global.gameProgress>=1540 and global.gameProgress<=1760
  {
    maxString=3
    myChar[0]="Business Man"
    myString[0]="The barrier has been lifted. X wanted to head out this way for something, but he didn't say what."
    myChar[1]="Jeremy"
    myString[1]="We've got business out there too."
    myChar[2]="Business Man"
    myString[2]="You'll be busting those virus infected bots along the way then? I'll keep the barrier open, then."
  }
  else if global.gameProgress>=1770 and global.gameProgress<=3900
  {
    maxString=2
    myChar[0]="Business Man"
    myString[0]="X is never coming back? This is a sad day for all of us. He helped Syrus and Gene so much to get this place up and running after the program let us all out."
    myChar[1]="Jerry"
    myString[1]="Yeah..."
  }
  else if global.gameProgress>=3910
  {
    maxString=2
    myChar[0]="Business Man"
    myString[0]="Wow, who knew that those CHAOS guys had an army that large."
    myChar[1]="Jerry"
    myString[1]="Naturally we fought them off... Because we're awesome."
  }
}
else if npcTag=14 //------------------------- Earth Temple - Friend Earth Golem -------------------------
{
  maxString=3
  myChar[0]="Friendly Earth Golem"
  myString[0]="Did you notice that you also gain EXP here, noted on the bottom-left of the view when you defeat an enemy? Well when you level up here, your attack power increases for any ability gained here."
  myChar[1]="Claire"
  myString[1]="That's helpful to know."
  myChar[2]="Friendly Earth Golem"
  myString[2]="The Game Power that you have been collecting is also useful. Every attack you perform takes energy, which recovers over time. Collecting more Game Power gives you a larger energy pool to draw from, giving you less down time."
}
else if npcTag=15 //------------------------- Central City North Alley - BOB -------------------------
{
  maxString=5
  myChar[0]="BOB"
  myString[0]="Oh hey, you're playing on Nightmare Mode for some reason. Since you're doing that, I think I've got some info which could be helpful for you. Let's get to it!"
  myChar[1]="BOB"
  myString[1]="For the Link set...#When at full life, you fire a Sword Wave from the sword."
  myChar[2]="BOB"
  myString[2]="For the Belmont set...#Press: Down -> Down -> Action B"
  myChar[3]="BOB"
  myString[3]="For the Mega Man set...#You can store up to 3 charged shots. Some people call it the 'Moogy Buster.'"
  myChar[4]="BOB"
  myString[4]="For the Metroid set...#After getting Morph Bombs, hold Action A while in Morph Ball mode."
}
else if npcTag=100 //------------------------- Bot Village - Jerry Boy -------------------------
{
  maxString=4
  myChar[0]="Claire"
  myString[0]="Oh hey, it's Jerry."
  myChar[1]="Jerry"
  myString[1]="Yep."
  myChar[2]="Chao"
  myString[2]="The question is, which one spoke there?"
  myChar[3]="Jerry"
  myString[3]="Who knows."
}
else if npcTag=101 //------------------------- Bot Village - Firebrand -------------------------
{
  maxString=1
  myChar[0]="Firebrand"
  myString[0]="It was John that made the Tranquil Serenity before the program used its Phase Distortion and brought in all the humans. He never finished it though, I wonder why he would just stop making something so nice."
}
else if npcTag=102 //------------------------- Bot Village - Arthur -------------------------
{
  maxString=11
  myChar[0]="Arthur"
  myString[0]="Bubblun told me why you're here. I just want to let you know that I'll help you fight CHAOS. The bots here don't want to deal with humans, so we stay here away from them, but we can't condone what CHAOS is trying to do."
  myChar[1]="Chao"
  myString[1]="If you guys don't want humans here, then why is the passage to get here open like that? The Tranquil Serenity wasn't really... an obstacle."
  myChar[2]="Arthur"
  myString[2]="It's the only way to get to this place. No way most would be able to climb the mountains to get here. And, it's a sort of doorway that will only allow those who have been given permission to pass through it."
  myChar[3]="Chao"
  myString[3]="That's a nifty lock."
  myChar[4]="Jerry"
  myString[4]="Oh man, you guys... YOU GUYS!! I just thought of something!"
  myChar[5]="Jeremy"
  myString[5]="What's up, Jerry?"
  myChar[6]="Jerry"
  myString[6]="Imagine if the final ability that Claire got was a Ghouls n' Ghost thing? Now THAT would be awesome. You know what I'm getting at, right?"
  myChar[7]="Claire"
  myString[7]="Wow Jerry, really?"
  myChar[8]="Jerry"
  myString[8]="Really."
  myChar[9]="Claire"
  myString[9]="Ugh, that's actually somewhat clever."
  myChar[10]="Jerry"
  myString[10]="Compliment and points!"
}
else if npcTag=103 //------------------------- Bot Village - Ristar -------------------------
{
  maxString=13
  myChar[0]="Ristar"
  myString[0]="Most of the bots here have heard about you guys. In fact, I doubt there is a bot on the Mainland that doesn't know who you are by now."
  myChar[1]="Claire"
  myString[1]="How so?"
  myChar[2]="Ristar"
  myString[2]="You're really asking? First your boyfriend there goes off against the program when it was attempting to segregate all the humans."
  myChar[3]="Ristar"
  myString[3]="And now that it lost control and rogue bot groups are allowed to do what they want, you guys go against one of them."
  myChar[4]="Claire"
  myString[4]="There's other groups like CHAOS?"
  myChar[5]="Ristar"
  myString[5]="There's some small ones, but they're nothing like CHAOS. I understand the Warmaster doesn't like humans, even some of us don't. But we don't agree with how he wants to handle this."
  myChar[6]="Claire"
  myString[6]="Things got complicated pretty fast then."
  myChar[7]="Ristar"
  myString[7]="The program kept groups like CHAOS in check. Since the Virus removed its control, they're now able to do what they want."
  myChar[8]="Chao"
  myString[8]="I've got a question... Would you rather have the program keeping things under control, or do you prefer the way it is now?"
  myChar[9]="Ristar"
  myString[9]="Maybe things were safer back then, but at least now we all have the freedom to do what we want. All the program does now is provide the world and the rules."
  myChar[10]="Chao"
  myString[10]="Jeremy and I have looked at the world stability and it wasn't ever in that much danger, even when the Virus was around. I doubt it destroying the program was ever the intention."
  myChar[11]="Ristar"
  myString[11]="I've had that same thought. I guess the Virus was just able to hide that fact. I wish I knew who made the Virus and set it in the program. Probably a pretty bad dude."
  myChar[12]="Jeremy"
  myString[12]="Yeah... maybe."
}
else if npcTag=104 //------------------------- Bot Village - Battletoad -------------------------
{
  maxString=3
  myChar[0]="Battletoad"
  myString[0]="Oh man, humans. Haven't seen any of you in a long time! It's cool to finally see one here aside from John."
  myChar[1]="Jerry"
  myString[1]="You..."
  myChar[2]="Claire"
  myString[2]="Don't mind him."
}
else if npcTag=105 //------------------------- Bot Village - Klonoa -------------------------
{
  maxString=7
  myChar[0]="Jerry"
  myString[0]="Oh hey, we've seen you out near the Bubble Tower."
  myChar[1]="Klonoa"
  myString[1]="It's my usual spot, but I wanted to come back here for now and catch up."
  myChar[2]="Jerry"
  myString[2]="Anything cool to note?"
  myChar[3]="Klonoa"
  myString[3]="I've heard word of this thing called the 'Decimator 10000'. Did you hear about it in the Weapon Facility?"
  myChar[4]="Jerry"
  myString[4]="No, but it sounds bad ass."
  myChar[5]="Klonoa"
  myString[5]="It's another one of those scary CHAOS machines."
  myChar[6]="Jerry"
  myString[6]="This is foreshadowing, isn't it?"
}
else if npcTag=200 //------------------------- Warship - Warmaster -------------------------
{
  maxString=5
  myChar[0]="Jeremy"
  myString[0]="Where will you go after this?"
  myChar[1]="Warmaster"
  myString[1]="Away from all of you. Just shut this thing down."
  myChar[2]="Jeremy"
  myString[2]="Fair enough."
  myChar[3]="Warmaster"
  myString[3]="Just a thought, how were you expecting to fight when Hex took your abilities from you?"
  myChar[4]="Jeremy"
  myString[4]="Eh... we would have figured something out."
}
