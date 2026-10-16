//Randomizer: one of the story's ability pickups (location type 19: rndgen.py's STORY_SPOTS) where the story's own was
//(oStoryObject, there till the story's past it, so gone in the endgame world). The roomStart hook makes it, setting
//objectNum (its number) and its look and mask (the story's own pickup's sprite: the place the room logic has, as
//placed; it doesn't fall). A frame on it shows its location's item (alarm 0), and gives it when touched
makeActive()
image_speed=0
alarm[0]=1
