//Randomizer: John, in Central City - North where the run starts (the roomStart hook makes him). For a seed that has the
//player stuck, talking to him turns the game's debug mode on, once its prompt says to (Turn Debug Mode On / Cancel,
//a window as his Turret Defense Game menu's), or off again: its right-click menu (Activate Mouse Movement: holding the
//left mouse button, the player goes where Chao is) and its keys (R invincibility). As the game's own oNPC_John otherwise
makeActive()
setCollisionBounds(-9,-42,9,-1)
talker="John"
boxSize=2
stringToShow=""
image_speed=0.2
//the prompt: open (the game paused while it is: Collision_oPlayer1, Step), and the option on the cursor (0 Turn Debug
//Mode On, 1 Cancel)
rjOpen=0
rjCur=0
