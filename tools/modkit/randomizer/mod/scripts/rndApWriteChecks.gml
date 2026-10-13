//Randomizer, Archipelago: checks.txt written whole: the game's seed line, then the id of every location checked
var f,i;
f=file_text_open_write(global.rndApPath+"checks.txt")
file_text_write_string(f,global.rndApSeedLine)
file_text_writeln(f)
for(i=0;i<global.rndLocN;i+=1)
{
  if rndIsGot(i) {file_text_write_string(f,string(rndApLocId(i))); file_text_writeln(f)}
}
file_text_close(f)
