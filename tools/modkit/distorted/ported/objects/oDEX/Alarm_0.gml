//fuck you

if global.newMapX=800
{
    atkPhase=1
    oPlayer1.image_yscale=0.5
    //copy scan info change here
    //none here
}
else if global.newMapX=801
{
    atkPhase=2
    //copy scan info change here
    atkProg=0
    cycleCounter=0
    for(i=0;i<5;i+=1) {atkTime[i]=0}
    for(i=0;i<3;i+=1) {exVal[i]=0}
    moveTime=0; moveProg=0; bossProgress=0
    tempDir=0
    //create crystal
    /*var Krissi;
    Krissi=instance_create(864,176,oLatchCrystal)
    Krissi.image_xscale=12; Krissi.image_yscale=5*/
    for(i=0;i<6;i+=1) {resType[i]=1}
    resType[0]=3
    jeremyText="This is a Claire phase, Jerry can't deal damage to him. He bounces around the room and does his slash attack every so often. When he bounces, he'll spawn some apples as well. Note that the bounces off the top aren't entirely based on physics."
    chaoText="There's not much to say. Just keep cool and roast him."
    devText="Executive is the only thing I haven't achilles'd in vanilla, and for good reason. Namely that every attempt at this guy takes a good five minutes or so, so my motivation drops faster than birdshit. It doesn't help that the hardest part to no-hit (avoidance) is towards the end. I'm sure the fangamers can sympathise."
}
else if global.newMapX=802
{
    atkPhase=3
    //copy scan info change here
    //direction=0
    _hspeed=0 //60fps change: the boss moves by _hspeed/_vspeed now
    //speed=0
    _vspeed=0 //60fps change: see above
    atkProg=0
    for(i=0;i<6;i+=1) {resType[i]=1}
    for(i=0;i<5;i+=1) {atkTime[i]=0}
    for(i=0;i<3;i+=1) {exVal[i]=0}
    moveTime=0; moveProg=0; bossProgress=0
    cycleCounter=0
    tempFlag=0
    global.hasShoes[0]=1 //no walking
    global.hasShoes[1]=1 //no jumping
    oPlayer1.image_xscale=1 //facing right
    //jeremyText="Ohhh man. Make sure to only press the button you're supposed to. You won't take damage or anything but you don't want to risk messing with the input recognition."
    jeremyText="Alright, so. Your parry and character switch cooldowns have been reduced to almost nothing. Your position has been locked and I can't be bothered to fix that, and you can't walk or jump anyway. Keep in mind that dashing is still useful, but also remember that guarding will kill your iframes. The boss seems to be exhausting himself by dancing so all you need to do is survive."
    //chaoText="No wonder Sephiroth didn't want to do a dance-off, if my boss did this I'd never want to dance again either."
    chaoText="Sephiroth is cheering you on guys, don't disappoint him!#####Oh and I guess Jeremy missed that your dash energy won't recharge."
    devText="If you think about it, this is really just Helmethead 2.2.3.2 with the directional inputs removed and using parry, dash and charcter switching instead."
}
else if global.newMapX=803
{
    atkPhase=4
    //copy scan info change here
    atkProg=0
    for(i=0;i<5;i+=1) {atkTime[i]=0}
    for(i=0;i<3;i+=1) {exVal[i]=0}
    moveTime=0; moveProg=0; bossProgress=0
    cycleCounter=0
    tempFlag=0
    lastParryChar=1 //Start with torus apples.
    for(i=0;i<6;i+=1) {resType[i]=1}
    jeremyText="Okay, in this phase he can only be damaged for a short while after a parry, and only by basic attacks (no specials). His attacks always come with the same timing but there are no visual tells, so I suggest using Jerry here.#Once his health gets lower he will start to curve his movement."
    chaoText="Uh oh, he has some code to mess with your coordinates. It'll only happen if you're near the borders of the arena, so you can avoid triggering it if you want to. But maybe you can take advantage of it...?"
    devText="If you are a true gamer you don't need me to tell you that you have infinite double jumps here."
}
else if global.newMapX=804
{
    atkPhase=5
    //copy scan info change here
    oPlayer1.waveOfAwesomeScale=4
    oPlayer1.image_yscale=0.5
    //MOVE TO RIGHT SPOT
    x=864
    y=80
    atkProg=0
    for(i=0;i<5;i+=1) {atkTime[i]=0}
    for(i=0;i<3;i+=1) {exVal[i]=0}
    for(i=0;i<6;i+=1) {resType[i]=3}
    moveTime=0; moveProg=0; bossProgress=0
    jeremyText="Oh hey, this kind of reminds me of a washing machine... kind of. Speaking of, I should go polish my mech."
    chaoText="This is getting boring so if you don't mind I'll go pratice my DT4 lines.#-Chao##P.S.: Looks like the infinite dash phase went unused.#P.P.S.: The line about DT4 was written way before the reveal."
    devText=":3  :3  :3##When in doubt, wiggle back and forth and pretend you're dodging."
}
