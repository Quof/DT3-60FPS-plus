event_inherited()
animSpd=0
image_speed=animSpd

//Enemy base statistics
eName="Lakitu"
eLevel=5
maxLife=150
if true and (room=rLavaCaveA or room=rLavaCaveB) {maxLife=15000}     //spsp
life=maxLife
pointWorth=10
atkPower=4
resType[2]=5
resType[3]=4
resType[4]=5
resType[5]=1
baseItemChance=75
affiliation=1
dieEffect=0
runAcc=3
bThrown=0

throwTime=60
throwDelay=70

deathAnim=0
dthVelY=-4

jeremyText="One of the most annoying enemies in the Mario universe... at least until the Big N started nerfing the guy. You know the drill with these. They throw Spiny Beetles and in some cases, not Spiny Beetles. If you can reach him, it'll make things easier for a little while."
chaoText="Eww, I don't like these. They mistreat the Spinys and that's wrong. What did the Spinys ever do to them?!"
devText="These were actually coded in DT2, but were never used. It would've still worked within the fundamental designs the levels followed, but they wouldn't have much of an impact since Claire was very mobile. All levels were designed so that you could chain every enemy from start to finish, which the Lakitu didn't break, but he simply had no real purpose in the game, even as a buffer to the next enemy to chain."
