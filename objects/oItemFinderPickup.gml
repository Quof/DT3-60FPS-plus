#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.3
if global.itemFinder=1 {instance_destroy()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_HeartPiece,0,1,1)
showEmote(oIdentifier,0,-6,sEmHappy)

msgCreate(0,0,"","You found the [Item Finder]. With this, Chao can now alert you to hidden items. When entering a map, Chao will display a treasure icon above her if an item is in that map.",6,3,oMessagePerson,0)
newMessage.fadingTime=360
awardAwesome(100000)

global.itemFinder=1
instance_destroy()
