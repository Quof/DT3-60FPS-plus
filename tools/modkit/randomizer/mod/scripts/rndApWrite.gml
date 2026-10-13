//Randomizer, Archipelago: one of the game's files for the client written whole (argument0: its name, argument1: its line
//after the game's seed line): goal.txt, death_out.txt
var f;
f=file_text_open_write(global.rndApPath+argument0)
file_text_write_string(f,global.rndApSeedLine)
file_text_writeln(f)
file_text_write_string(f,argument1)
file_text_writeln(f)
file_text_close(f)
