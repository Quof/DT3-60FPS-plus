//Being hit in one of Altered Insanity's boss challenges adds 5 seconds to the time, as in the boss gallery (takeDamage;
//the boss gallery's own 5 seconds are added by the game).
if global.inBossChallenge and global.bBossGallery!=1 {global.levelTimeSecond+=5}
