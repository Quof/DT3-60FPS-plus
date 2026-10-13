//Altered Insanity's title screen codes (argument0: the code typed). They change the progress kept in the save shown
//(where its Altered Insanity data is: its own section, or ALPHA for a save made with the original).
var s,tProg,tFile;
if argument0="freedom" or argument0="9947"
{
  ini_open(global.paraString[0])
  s="AlteredInsanity"
  if !ini_key_exists(s,"cousinoer5Prog") {s="ALPHA"}
  tProg=ini_read_real(s,"cousinoer5Prog",0)
  if argument0="freedom" and tProg=777
  {
    tFile=file_text_open_write(working_directory+"\Mystery.txt")
    file_text_write_string(tFile,"You have done well to get this far. The barrier's power weakens. Go to where this journey started and face the final puzzle!")
    file_text_close(tFile)
    show_message("You have done well to get this far. The barrier's power weakens. Go to where this journey started and face the final puzzle!")
    ini_write_real(s,"cousinoer5Prog",1000)
    global.cousinoer5Progress=1000
  }
  else if argument0="9947" and tProg=1337
  {
    show_message("Excellent mathing! You've unlocked some extra arena challenges, go back to the challenge hub and prepare for more madness")
    ini_write_real(s,"cousinoer5Prog",1338)
    global.cousinoer5Progress=1338
  }
  ini_close()
}
