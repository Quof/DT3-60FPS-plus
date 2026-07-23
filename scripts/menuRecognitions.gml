/*
This script is called in the menuRecords script in the HUD pause menu and is an extension of it.
It is used to display the Recognitions(Achievements) submenu.
argument0: What page to display
*/

var tRecognitionPage;
tRecognitionPage=argument0

if tRecognitionPage=1 //============================== PAGE 1 ==============================
{
  if tokens[1]="0" //-------------------- First Steps --------------------
  {
    textDropColor("FIRST STEPS",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="I'm not really sure how you beat the game and don't have this achievement... Oh right, you must have beaten the game and then restarted. Well then, congrats on winning!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("FIRST STEPS",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Took a step!#Wow, you took a step!"}
  }
  if tokens[2]="0" //-------------------- Dirty Cheater --------------------
  {
    textDropColor("DIRTY CHEATER",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Remember the keys when getting the jump boots? I wonder what would happen if you abused save/load features.#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("DIRTY CHEATER",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Attempt to cheat at the beginning of the game!#It was worth a try."}
  }
  if tokens[3]="0" //-------------------- Did You Go Eat --------------------
  {
    textDropColor("DID YOU GO EAT",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Right now, go read the whole wikipedia article on sandwiches. Just... you know, don't leave the game paused."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("DID YOU GO EAT",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Stand idle for 5 minutes!#Sometimes you just gotta go do something else."}
  }
  if tokens[4]="0" //-------------------- Call of Dootied --------------------
  {
    textDropColor("CALL OF DOOTIED",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="What do you do to snipers you've killed in FPS games?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("CALL OF DOOTIED",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Teabag a sniper!#Damn campers!"}
  }
  if tokens[5]="0" //-------------------- Fourth Trimester --------------------
  {
    textDropColor("FOURTH TRIMESTER",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Cackletta sure does summon a lot of bats..."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("FOURTH TRIMESTER",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Kill all 4 bats in a single volley from Cackletta!#Yep."}
  }
  if tokens[6]="0" //-------------------- 30 AP --------------------
  {
    textDropColor("30 AP",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Did you know that Skull Balls always award 30 AP regardless of your level?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("30 AP",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Kill a Skull Ball!#Was it worth it?"}
  }
}
else if tRecognitionPage=2 //============================== PAGE 2 ==============================
{
  if tokens[7]="0" //-------------------- You Are Awesome --------------------
  {
    textDropColor("YOU ARE AWESOME",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Just keep being awesome."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("YOU ARE AWESOME",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Earn 12345678 Awesome Points.#That's pretty awesome, though you probably farmed for this so, maybe not THAT awesome."}
  }
  if tokens[8]="0" //-------------------- Beehind You --------------------
  {
    textDropColor("BEEHIND YOU",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Those Wasp Bots when defending X before Gate 4. They sure are a bother.#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("BEEHIND YOU",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Kill both Wasp Bots in the Chapter 7 Virus fight.#Some puns just sting."}
  }
  if tokens[9]="0" //-------------------- Swordswoman --------------------
  {
    textDropColor("SWORDSWOMAN",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Perhaps Claire just needs to perfectly fight and speed run a certain swordsman."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("SWORDSWOMAN",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Defeat Sephiroth in under 35 seconds without taking damage.#You weren't using Jerry for this anyway."}
  }
  if tokens[10]="0" //-------------------- Remember That --------------------
  {
    textDropColor("REMEMBER THAT",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="How do I even give you a clue for this? That second part of the ship in Subconscious Filter... Remember what you could do in Mario 3?#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("REMEMBER THAT",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Stay under the second ship in the Subconscious Filter.#Except it was easier back then."}
  }
  if tokens[11]="0" //-------------------- U Mad Bro --------------------
  {
    textDropColor("U MAD BRO",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Bros sure do get mad when their bros are harmed... what about when one is already upset?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("U MAD BRO",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Jump on a Hammer Bro when it is angered!#Pixel perfection."}
  }
  if tokens[12]="0" //-------------------- Just Goofy --------------------
  {
    textDropColor("JUST GOOFY",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="You've already beaten the game so like... yeah. You get this in the story no matter what."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("JUST GOOFY",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Defeated Pete!#Was a rough battle."}
  }
}
else if tRecognitionPage=3 //============================== PAGE 3 ==============================
{
  if tokens[13]="0" //-------------------- Quick Engineer --------------------
  {
    textDropColor("QUICK ENGINEER",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="The Control Virus... Yeah, that's the only clue you get. I mean just read the title of this one and that clue."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("QUICK ENGINEER",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Defeat the Control Virus with 1000 or greater time remaining!#You were all over the place."}
  }
  if tokens[14]="0" //-------------------- Gamer's Intuition --------------------
  {
    textDropColor("GAMER'S INTUITION",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="You've either cheated or beaten the game. If you played the game already, then you know where this one is gotten... obtained? Is gotten even a word? Go look it up for me."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("GAMER'S INTUITION",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Shared a moment with friends on abstract understanding!#Sometimes you just know things."}
  }
  if tokens[15]="0" //-------------------- Coin Islander --------------------
  {
    textDropColor("COIN ISLANDER",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Go to the first map in Begonia."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("COIN ISLANDER",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Grabbed all 12 coins on the Begonia 1 tile islands!#Why would you even do this?"}
  }
  if tokens[16]="0" //-------------------- Zephyr Loves You --------------------
  {
    textDropColor("ZEPHYR LOVES YOU",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="I really dislike copy machines."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("ZEPHYR LOVES YOU",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Destroyed something like 5 copy machines!#Destroy all the damned things!"}
  }
  if tokens[17]="0" //-------------------- Wonky Block --------------------
  {
    textDropColor("WONKY BLOCK",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="If you got the real ending then... oh right, you must have restarted if you're seeing this."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("WONKY BLOCK",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Dealt with Gate D wonky collision blocks.#Who even enjoys getting stuck?"}
  }
  if tokens[18]="0" //-------------------- Infinity Plus One --------------------
  {
    textDropColor("INFINITY PLUS ONE",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Remember the hidden 1up in 1-1?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("INFINITY PLUS ONE",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Found the hidden and rather useless 1up!#You already have infinite lives, why is this here?"}
  }
}
else if tRecognitionPage=4 //============================== PAGE 4 ==============================
{
  if tokens[19]="0" //-------------------- Major League Plumbing --------------------
  {
    textDropColor("MAJOR LEAGUE PLUMBING",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="You just gotta hop along a bunch of enemies in Gate 1-1."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("MAJOR LEAGUE PLUMBING",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Mario hopped along a bunch of enemies in Gate 1-1!#That's really specific, but hey you did it!"}
  }
  if tokens[20]="0" //-------------------- Useless Achievement --------------------
  {
    textDropColor("USELESS ACHIEVEMENT",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="There's a toad that talks about how useless the achievements are in this game. You just gotta talk to him. Huh... that's kinda silly... and useless... like this achievement?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("USELESS ACHIEVEMENT",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Talked to the upset gamer toad!#Because this just needed to exist."}
  }
  if tokens[21]="0" //-------------------- Should Have Known --------------------
  {
    textDropColor("SHOULD HAVE KNOWN",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="There's a time in Gate 1 where I'll tell you to jump to your death... you should do that."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("SHOULD HAVE KNOWN",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Tricked to your death in Gate 1!#Why would you even do that? You really should have known better. Now you have this achievement as proof of your error."}
  }
  if tokens[22]="0" //-------------------- Double Cutscene --------------------
  {
    textDropColor("DOUBLE CUTSCENE",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="There's a flashback to something... just you know... stay for the whole flashback.#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("DOUBLE CUTSCENE",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Watched the flashback to something that just happened!#That's pretty sad."}
  }
  if tokens[23]="0" //-------------------- Level 64 --------------------
  {
    textDropColor("LEVEL 64",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="There's a level cap in Gate 6."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("LEVEL 64",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Reached Level 64 in Gate 6!#And you didn't even have to grind... I hope."}
  }
  if tokens[24]="0" //-------------------- Avid Listener --------------------
  {
    textDropColor("AVID LISTENER",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Those Counselman guys have a story to tell. Listen to it all.#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("AVID LISTENER",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Listened to all of at least one Counselman's story!#Were you actually interested though?"}
  }
}
else if tRecognitionPage=5 //============================== PAGE 5 ==============================
{
  if tokens[25]="0" //-------------------- You Know Everything --------------------
  {
    textDropColor("YOU KNOW EVERYTHING",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="The full Trivia Quiz... Do you know all the answers?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("YOU KNOW EVERYTHING",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Got a perfect score on the full Trivia Quiz!#Did you use Google? Don't lie... did you?"}
  }
  if tokens[26]="0" //-------------------- No Head --------------------
  {
    textDropColor("NO HEAD",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="So that map with the Medusa Heads in Castle Corridor... no damage, no dashing, from left to right... GO!!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("NO HEAD",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Got past the Medusa Heads in Castle Corridor without taking damage or dashing!#As a player, you must get these... eww that sounds dirty."}
  }
  if tokens[27]="0" //-------------------- Drowning in Spring --------------------
  {
    textDropColor("DROWNING IN SPRING",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="That spring in Gate 6..."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("DROWNING IN SPRING",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Drown yourself in the Spring Water of Gate 6!#I saw Hadriex do this in a beta playthrough, just had to add this."}
  }
  if tokens[28]="0" //-------------------- Chicken'd Out --------------------
  {
    textDropColor("CHICKEN'D OUT",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Those Zelda Chickens... have you attempted to kill one... I don't recommend that you do, they have a bazillion HP... well, it definitely feels like that when you're attempting to."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("CHICKEN'D OUT",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Killed a Zelda Chicken!#Why would you do that? How long did that take?"}
  }
  if tokens[29]="0" //-------------------- Ultra Combo --------------------
  {
    textDropColor("ULTRA COMBO",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Have you gotten a big combo?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("ULTRA COMBO",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Get a 100 hit combo!#Non-stop action man!"}
  }
  if tokens[30]="0" //-------------------- This Combo isn't Possible --------------------
  {
    textDropColor("THIS COMBO ISN'T POSSIBLE",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Have you gotten a really big combo? I wonder where such a thing could even be done."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("THIS COMBO ISN'T POSSIBLE",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Get a 1000 hit combo!#Did you cheat for this... or were you in the Tower Defense segment?"}
  }
}
else if tRecognitionPage=6 //============================== PAGE 6 ==============================
{
  if tokens[31]="0" //-------------------- Stuck in the Mountains --------------------
  {
    textDropColor("STUCK IN THE MOUNTAINS",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Jerry and Claire can be rather mean to one another in the water segment of Begonia Temple.#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("STUCK IN THE MOUNTAINS",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Get either Jerry or Claire stuck in the water puzzle in Begonia Temple!#That wasn't a very nice thing to do."}
  }
  if tokens[32]="0" //-------------------- Press Everything to Not Die --------------------
  {
    textDropColor("PRESS EVERYTHING TO NOT DIE",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="MASH ALL THE BUTTONS!! Oh man, this one breaks the menu a little.#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("PRESS EVERYTHING TO NOT DIE",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Get 150 hits or more on a 'MASH BUTTONS!!' sequence!#You mash buttons good. Wow, this achievement breaks the menu a bit."}
  }
  if tokens[33]="0" //-------------------- Lavaception --------------------
  {
    textDropColor("LAVACEPTION",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Have you ever seen lava inside lava?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("LAVACEPTION",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Take damage from the red lava in Lower Norfair!#You're already in lava... I guess technically it's magma."}
  }
  if tokens[34]="0" //-------------------- Laser Point Precision --------------------
  {
    textDropColor("LASER POINT PRECISION",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="The header text in Sigma 1 - Map 4... Go read that."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("LASER POINT PRECISION",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Get through Sigma 1 - Map 4 without the lasers detecting you!#Get smart!"}
  }
  if tokens[35]="0" //-------------------- Picking on the Little Guy --------------------
  {
    textDropColor("PICKING ON THE LITTLE GUY",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Somewhere there is a very small Ball De Voux. Well... pretend you're a bully."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("PICKING ON THE LITTLE GUY",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Destroy the extremely small Ball De Voux!#You probably thought it was funny at the time."}
  }
  if tokens[36]="0" //-------------------- Because... Why Not --------------------
  {
    textDropColor("BECAUSE... WHY NOT",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="In the Vault is a sign that says 'why not?' Are you thinking what I'm thinking of doing around that sign?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("BECAUSE... WHY NOT",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Took damage from the 'why not?' spikes in the Vault!#You just had to, didn't you?"}
  }
}
else if tRecognitionPage=7 //============================== PAGE 7 ==============================
{
  if tokens[37]="0" //-------------------- Let None Live --------------------
  {
    textDropColor("LET NONE LIVE",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="In Bubble Tower... everything must die!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("LET NONE LIVE",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Kill the Monster Crab by the Zelda switches in Bubble Tower!#You must really hate crabs."}
  }
  if tokens[38]="0" //-------------------- Vending Machine Error --------------------
  {
    textDropColor("VENDING MACHINE ERROR",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="You ever had your money stolen by vending machines? Yeah me too, it sucks. There's a certain time when they may do that..."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("VENDING MACHINE ERROR",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Get your money stolen by the vending machines at 4:04 AM/PM!#We've all gotten this achievement in real life."}
  }
  if tokens[39]="0" //-------------------- Top Gun --------------------
  {
    textDropColor("TOP GUN",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Bullet Bills... what? I can't just tell you."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("TOP GUN",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Destroy a Bullet Bill without jumping on it!#It's easier to just jump on them, you know?"}
  }
  if tokens[40]="0" //-------------------- Burn Bad Smileys --------------------
  {
    textDropColor("BURN BAD SMILEYS",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="It's kinda hard to miss this one during a normal playthrough. Just look for the smiley that can be destroyed... and destroy it! Location: Subconscious Filter#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("BURN BAD SMILEYS",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Destroyed the awful smiley!#They really all should be."}
  }
  if tokens[41]="0" //-------------------- Aqua Bomb Serpent --------------------
  {
    textDropColor("AQUA BOMB SERPENT",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="The Aqua Serpent needs to be blown up and only blown up... nothing else."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("AQUA BOMB SERPENT",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Defeat the Aqua Serpent with bombs only!#This must have taken you forever... good job."}
  }
  if tokens[42]="0" //-------------------- Dash Dance --------------------
  {
    textDropColor("DASH DANCE",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Dash! Dash! Dash!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("DASH DANCE",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Dashed back and forth with Jerry!#Just need some disco balls."}
  }
}
else if tRecognitionPage=8 //============================== PAGE 8 ==============================
{
  if tokens[43]="0" //-------------------- Not This Time --------------------
  {
    textDropColor("NOT THIS TIME",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Jeremy's mech is too heavy to be pushed back by screams..."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("NOT THIS TIME",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Unaffected by a Malignant Ooze's scream!#You're not putting up with their crap this time."}
  }
  if tokens[44]="0" //-------------------- Smarter than the Brain --------------------
  {
    textDropColor("SMARTER THAN THE BRAIN",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Did you try cheating on the Mother Brain fight? You kinda can."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("SMARTER THAN THE BRAIN",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Hit Mother Brain from behind!#Kind of cheating on a boss fight that is already pretty easy... whatever."}
  }
  if tokens[45]="0" //-------------------- Goomba Stomped --------------------
  {
    textDropColor("GOOMBA STOMPED",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="The Warmaster can kinda Goomba Stomp... Ever had that happen to you?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("GOOMBA STOMPED",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Got Goomba Stomped by the Warmaster!#Yeah, he does that too!"}
  }
  if tokens[46]="0" //-------------------- But Thou Must --------------------
  {
    textDropColor("BUT THOU MUST",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Tell the Trivia Lord, No!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("BUT THOU MUST",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Answer 'No.' on the Trivia Lord's 50th question!#You had no choice, you had to answer."}
  }
  if tokens[47]="0" //-------------------- Got an Onion --------------------
  {
    textDropColor("GOT AN ONION",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="If you watch raocow's DT2 LP, pay close attention to what he calls an onion."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("GOT AN ONION",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Get a bronze medal or better on any boss in the boss gallery!#Wait... why did you have to look at the board to get this?"}
  }
  if tokens[48]="0" //-------------------- Farreaching Bird --------------------
  {
    textDropColor("FARREACHING BIRD",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="There's a bird in Farreaches that must be reached!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("FARREACHING BIRD",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Got up to the bird in Farreaches - Extrapolate!#Magical jumping powers ahoy! It's like you also had wings!"}
  }
}
else if tRecognitionPage=9 //============================== PAGE 9 ==============================
{
  if tokensSS[1]="0" //-------------------- Overcoming Yourself --------------------
  {
    textDropColor("OVERCOMING YOURSELF",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Perhaps if you did something outside of the game..."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("OVERCOMING YOURSELF",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="After attempting to cheat via save editing, you realized your mistake and accepted the punishment!#Did you think I'd have made it that easy?"}
  }
  if tokensSS[2]="0" //-------------------- Balloon Popper --------------------
  {
    textDropColor("BALLOON POPPER",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="To get this, you just need to be an awful person to Mr. Saturn. Just remember that by getting this achievement, it's proof of your being an awful person."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("BALLOON POPPER",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Popped Mr. Saturn's balloon and got punished real bad for it!#I mean really, he wasn't even doing anything to you and you still did that."}
  }
  if tokensSS[3]="0" //-------------------- Magical Friendship --------------------
  {
    textDropColor("MAGICAL FRIENDSHIP",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Touch a magical pony!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("MAGICAL FRIENDSHIP",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="You touched Lyra and now understand the true meaning behind the magic of friendship!#You're a lot happier now."}
  }
  if tokensSS[4]="0" //-------------------- A Cookie For You --------------------
  {
    textDropColor("A COOKIE FOR YOU",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Yoshis need money too."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("A COOKIE FOR YOU",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Bought a cookie from the Yoshi!#Now he can feed his family!"}
  }
  if tokensSS[5]="0" //-------------------- Chicken Menace --------------------
  {
    textDropColor("CHICKEN MENACE",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Whoa whoa... How could you have not been tempted to attack those chickens? Have you not played the Zelda games?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("CHICKEN MENACE",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Attacked the chickens too much!#You're kind of a dick. They're just chickens! Besides, you knew that would happen, I know you've played Zelda games."}
  }
  if tokensSS[6]="0" //-------------------- Item Collector --------------------
  {
    textDropColor("ITEM COLLECTOR",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Did you get everything?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("ITEM COLLECTOR",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Got 100% of the collectibles in the game!#This is more to tell you that you've played this game for way too long."}
  }
}
else if tRecognitionPage=10 //============================== PAGE 10 ==============================
{
  if tokensSS[7]="0" //-------------------- Saved Game --------------------
  {
    textDropColor("SAVED GAME",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Perhaps not just the game..."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("SAVED GAME",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Trigger the true final chapter!#This is what we wanted."}
  }
  if tokensSS[8]="0" //-------------------- Pointless Rings --------------------
  {
    textDropColor("POINTLESS RINGS",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Why do they exist?#[Can be missed.]"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("POINTLESS RINGS",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText="Grabbed all the rings when falling back to the ground!#You love rings."}
  }
  if tokensSS[9]="0" //-------------------- Hardest Encounter --------------------
  {
    textDropColor("HARDEST ENCOUNTER",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Is it really?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("HARDEST ENCOUNTER",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText="Beat the hardest boss in the game!#What a rush!"}
  }
  if tokensSS[10]="0" //-------------------- Ornithology Major --------------------
  {
    textDropColor("ORNITHOLOGY MAJOR",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Become an avid bird watcher like Zephyr."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("ORNITHOLOGY MAJOR",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText="Seen 11111 birds!#You must love birds."}
  }
  if tokensSS[11]="0" //-------------------- Dishonest Pong --------------------
  {
    textDropColor("DISHONEST PONG",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Getting something stuck?"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("DISHONEST PONG",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText="Attempted to cheat on the Pong portion of Hexor!#But he caught you."}
  }
  if tokensSS[12]="0" //-------------------- Pure Skill --------------------
  {
    textDropColor("PURE SKILL",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Execute without assistance."}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("PURE SKILL",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText="Beat The Executive without the help of Assist Mode!#Congrats and seriously, how long did that take you?"}
  }
}
else if tRecognitionPage=11 //============================== PAGE 11 ==============================
{
  if tokensSS[13]="0" //-------------------- Stay Gold Ponyboy --------------------
  {
    textDropColor("STAY GOLD PONYBOY",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText="Go for the gold!"}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("STAY GOLD PONYBOY",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText="Through skill and a whole lot of determination,#got a Gold Medal on every boss in the gallery!"}
  }
  /*if tokensSS[2]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[3]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[4]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[5]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[6]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText=""}
  }*/
}





if tRecognitionPage=100 //============================== PAGE ????? ==============================
{
  if tokensSS[1]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_black,1)
    if mR_RecCurPos=1 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+21,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+33,1,1,0,c_white,1)
    if mR_RecCurPos=1 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[2]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_black,1)
    if mR_RecCurPos=2 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+45,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+57,1,1,0,c_white,1)
    if mR_RecCurPos=2 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[3]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_black,1)
    if mR_RecCurPos=3 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+69,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+81,1,1,0,c_white,1)
    if mR_RecCurPos=3 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[4]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_black,1)
    if mR_RecCurPos=4 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+93,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+105,1,1,0,c_white,1)
    if mR_RecCurPos=4 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[5]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_black,1)
    if mR_RecCurPos=5 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+117,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+129,1,1,0,c_white,1)
    if mR_RecCurPos=5 and subMenu=13 {menuInfoText=""}
  }
  if tokensSS[6]="0" //-------------------- ????? --------------------
  {
    textDropColor("",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,0.5)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_black,1)
    if mR_RecCurPos=6 and subMenu=13
    {
      if global.gameCompleted>=1 {menuInfoText=""}
      else {menuInfoText="?????"}
    }
  }
  else
  {
    textDropColor("",contentMenuX+48,contentMenuY+141,colorRecogTop,colorRecogBottom,colorRecogShadow,1)
    draw_sprite_ext(sAchievementMedalA,0,contentMenuX+26,contentMenuY+153,1,1,0,c_white,1)
    if mR_RecCurPos=6 and subMenu=13 {menuInfoText=""}
  }
}
