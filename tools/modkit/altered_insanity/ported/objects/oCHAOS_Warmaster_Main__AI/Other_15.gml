///SWAPPING FORM
if instance_exists(oWMC_IceHoverA)
{
  with oWMC_IceHoverA
  {
    bOrbit=0
    moveProg=2
    moveTime=fireDelay-5
  }
}

if superChangeAtk=0 //If Warmaster was about to attack, set back attack timer
{
  if waitTime>=waitDelay-20 {waitTime=waitDelay-20}
}

bGravity=1; hoverMode=0
currHspd=0; currVspd=0

var tEffect;
tEffect=instance_create(x,y-(27*image_yscale),oEffect)
tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
shiftTime=0; shiftDamage=0
if ATTACK_FORM=1
{
  sprite_index=sWarmasterA_Idle
  jeremyText="The Warmaster is able to employ a wide range of close range sword attacks. Which is trouble for you because he's practically immune to most of your projectiles. He's got a standard sword attack that also launches a fairly close range wave. A dash, jump, and dive attack. Jerry, you cover a lot of space with your sword, but Claire, you have good range. Keep that in mind. He can cling to the walls too and when you see that, he's got quite a nasty energy attack from the ceiling that he can summon."
  chaoText="I figured there was a lot more he could do. When I first saw the Warmaster, I was wondering if he'd be able to employ those Mega Man ZX abilities like this."
  
  if global.inBossChallenge
  {
      jeremyText="I've always wanted to fight this guy, you guys made it look too fun. Step back and let me show you how it's done! My Mech's AR vision shows that this form is weak to my flamethrower. Makes sense, it's as close to melee as I get!"
      chaoText="Go brother, you got this! Avoiding attacks is only half the battle here, learn what situations are undodgeable and try to avoid those. For example, don't let green corner you into his full screen tornado. Also don't forget about your Vertical Shield Technique you conveniently have only in this Virtual Insanity realm! Press Up and B to deploy shields above and below you."
      devText="Jeremy isn't as agile as you're used to, you'll have to find new ways to dodge, and keep the pressure on with attacks to get your combo damage up."
  }
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[1]=2; resType[2]=1; resType[3]=1; resType[4]=2; resType[5]=1
  if DIFFICULTY>=2 {resType[1]=1}
  if DIFFICULTY>=3 {resType[4]=1}
  if shiftType=0 {shiftDmgMax=42; shiftMaxTime=750}
  else {shiftDmgMax=30; shiftMaxTime=660}
  
  if global.inBossChallenge
  {
    resType[2] = 3 //force fire to always do damage  
  }
}
else if ATTACK_FORM=2
{
  sprite_index=sWarmasterB_Idle
  jeremyText="Oh wow, so he CAN do a lot more. Okay, something worth noting is that all of his fire attacks are counted as Explosive damage. The biggest threat with this form that I can see is his charge attack. It's super fast and leave a bunch of fire pillars along his path. I doubt you'll be able to reliably use i-frames to avoid damage, so keep their spacing in mind. That and I think it would be best if you didn't dash when unnecessary."
  chaoText="Uh oh, things suddenly got a lot worse for you guys. It looks like he can do the same type of thing you two can do. He'll periodically swap forms to match the situation. I'm sure he's got a limitation on when he can swap... at least I hope so. Would suck if he started combining attacks from the different forms..."
  if global.inBossChallenge
  {
    jeremyText="Lasers are the primary weakness here, just fire and forget, more time for me to dodge!"
    chaoText="Keep calm and weave around his fire balls, be careful of his fire pillars! Remember to use your shields if things get too hot"
    devText="I kept pondering what to do Warmaster wise in this content. Kept thinking of who to pair him with, but came up empty, it'd just be 'kill the other guy then fight warmaster as usual', and Warmaster stands in a league of his own threat wise. So I decided to completely flip the script here, I hope you enjoy this :)"
  }
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=2; resType[3]=1; resType[4]=1; resType[5]=2
  if DIFFICULTY>=2 {resType[0]=1}
  if DIFFICULTY>=3 {resType[1]=1; resType[5]=1}
  if shiftType=0 {shiftDmgMax=81; shiftMaxTime=750}
  else {shiftDmgMax=60; shiftMaxTime=660}
  
  if global.inBossChallenge
  {
    resType[1] = 3 //force laser to always do damage  
    resType[2] = 1 //force fire to do no damage
  }
}
else if ATTACK_FORM=3
{
  bGoombaStomp=1; goombaStompTime=15
  numOfAtks=0
  sprite_index=sWarmasterC_Idle
  jeremyText="In this form, he can hover and he'll do it very often. I'd recommend Claire stay active for this one since she's got a bit more maneuverability and she has the Morph Ball for tight bullet storms. He can spam projectiles in this form quite a bit and he's rather scary with those projectile patterns as well. Just a thought I had. Learn his attacks and his openings. If he starts going crazy with attacks, keep calm and wait for moments to counter."
  chaoText="If you haven't noticed yet, he telegraphs EVERY attack before he performs them, though he does get faster the more you damage him. There's something else I've noticed. He has a sort of 'super attack' per form, but each of those can only be used after he charges up enough. It looks like all he has to do to charge is use his wide variety of standard attacks."
  
  if global.inBossChallenge
  {
    jeremyText="My vulcan cannon will deal the most damage to this guy, it'll be tough to hit him once he starts flying though."
    chaoText="This one's troublesome, relentless projectiles flying everywhere, you'll definitely need to know when to shield and when you can move out of the way, shields are a precious resource here!"
    devText="When I tested out playing against this form, I knew for sure I needed to give Jeremy a tool to mitigate bullets from above, and I noticed Up + Shield button did nothing, so I used that to give Jeremy the Vertical Shield. You can even surround yourself in a box with 1 set of each shield, won't stop Warmaster from dashing in and invading your personal space though!"
  }
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=1; resType[1]=1; resType[2]=1; resType[5]=2
  if DIFFICULTY>=2 {resType[5]=1}
  if DIFFICULTY>=3 {resType[4]=1}
  if shiftType=0 {shiftDmgMax=132; shiftMaxTime=750}
  else {shiftDmgMax=90; shiftMaxTime=660}
}
else if ATTACK_FORM=4
{
  sprite_index=sWarmasterD_Idle
  jeremyText="I'd recommend staying away from this form mainly due to his ability to call up tornados around him. He's immune to melee damage in this form anyway. While he doesn't spam projectiles too bad in this form, the projectiles he does have are large. He has a lot of field control in this form, though I don't feel it's as significant as his main one, luckily for you."
  chaoText="He's fast in this form and tends to use his own body as his weapon along with his wind attacks and blade strikes. That seeking wind orb that he summons isn't so bad until he starts covering the field in tornados. If he's close to the middle of the field, you have to dash to dodge those. Keep that in mind when managing your dash energy."
  
  if global.inBossChallenge
  {
    jeremyText="I'm glad this guy only has 4 forms, as I have 4 weapons. Missiles will wreck this guy, but they're slow."
    chaoText="This guy's all about area denial. You can't do anything about his infamous Wind Orb attack, so you'll have to dodge that among everything else. If you're too close to him when he's going to do the tall tornado attack, if you line yourself up with him vertically with him, there's a dead zone you can manage to fit into. The tackle is very threatening, you'll have to do some creative dodging and have a backup plan if he's gonna jump up and around."
    devText="I had to test and make sure of the Pro Strat of getting directly above / below him on his big tornado attack. I noticed there was a dead zone there and lo and behold, it's just big enough for even a mech to stand unharmed in. The eye of the storm, Useful trick!"
  }
  for(i=0;i<6;i+=1)
  {
    resType[i]=3
  }
  resType[0]=1; resType[1]=1; resType[2]=2; resType[4]=2
  if DIFFICULTY>=2 {resType[3]=1}
  if DIFFICULTY>=3 {resType[2]=1; resType[4]=1}
  if shiftType=0 {shiftDmgMax=75; shiftMaxTime=750}
  else {shiftDmgMax=54; shiftMaxTime=660}
  
}
if hasArmor = 1
{
    armor=3
    spawnArmorEffect()
}
