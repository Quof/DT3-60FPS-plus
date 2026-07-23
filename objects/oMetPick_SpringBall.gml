#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.3
if global.metSpringBall=1 {instance_destroy()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_MetItemGet,0,1,1)
showEmote(oIdentifier,0,-6,sEmHappy)

msgCreate(0,0,"","You found the [Spring Ball]. With this, you can now jump while in Morph Ball mode. It's worth noting that the item icon for this was in fact for Speed Booster. Your eyes were not lying to you. Remain calm, you are not going crazy.",6,3,oMessagePerson,0)
newMessage.fadingTime=360
awardAwesome(100000)

global.metSpringBall=1
instance_destroy()
