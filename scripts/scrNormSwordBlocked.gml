/*
normalized gallery change (added): 1 when an equipment item can't be put on right now: sword equipment (Magic Sword 1,
Sword of Bravery 2, Power Glove 3) in the boss gallery while its lever (oGalleryLever) is on. Used by the pause menu's
item menu (oPauseMenu); scrNormSwordsOff takes it off there.
argument0: equipment item (global.equipJerry / global.equipClaire value)
*/
if argument0>=1 and argument0<=3 and room=rBossGallery and global.galleryNormalized=1 {return 1}
return 0
