draw_self()

if cannonProg=0 and bCannonInUse=1
{
  draw_set_alpha(1)
  draw_set_font(fnt_GOoptions)
  draw_set_halign(fa_center)
  //textDropShadow(string("FIRE THE CANNON: [") +string(global.ctrlJump) +string("]#Get out: [") +string(global.ctrlActA) +string("]"),view_xview[0]+240,view_yview[0]+176,c_white,c_black,4)
  //textDropShadow(string("FIRE THE CANNON: [") +string(global.ctrlConfirm) +string("]#Get out: [") +string(global.ctrlCancel) +string("]"),view_xview[0]+240,view_yview[0]+176,c_white,c_black,4) //controls change: it fires with Confirm, Cancel gets out
  global.inputAlign=fa_center //input text change (added): centered (scrDrawInput)
  textDropShadow("FIRE THE CANNON: [Confirm]#Get out: [Cancel]",view_xview[0]+240,view_yview[0]+176,c_white,c_black,4) //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
}
