image_speed=0.5
displayBack=make_color_rgb(187,187,188)
displayBorder=make_color_rgb(255,0,255)

haveKey=0
if global.tempAction[1]=0 {global.tempAction[1]=1500}

vaultMaze[0]=string_char_at(global.gameVaultProg,1)
vaultMaze[1]=string_char_at(global.gameVaultProg,2)
vaultMaze[2]=string_char_at(global.gameVaultProg,3)
vaultMaze[3]=string_char_at(global.gameVaultProg,4)
