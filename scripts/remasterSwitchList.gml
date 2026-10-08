/*
The remaster's dipswitches: changes that can be turned on/off in Options > Gameplay > Customize Remastered Changes.
Each one is a true/false global (global.<name>, checked where the change is made). They're saved in DT3Options.dts
(loadOptions/saveOptions) and are on by default unless dsDefault (at the end) says otherwise.
Called by loadOptions, saveOptions and oGame's Create.

To add one: add a line below (keep each key unique), then check global.<name> where the change is made.
The list grows on its own; names have to fit the list's width (about as long as "Brighten Certain Backgrounds").
  dsVar  - name of the global variable
  dsKey  - its key in DT3Options.dts
  dsName - name shown in the list
  dsInfo - text shown in MENU INFO (# starts a new line)
*/
var i; i=0
global.dsVar[i]="fixDarkBackgrounds"; global.dsKey[i]="401"; global.dsName[i]="Brighten Certain Backgrounds"
global.dsInfo[i]="The pitch-black background of two boss fights will be brightened. #Off: They remain pitch-black."; i+=1
global.dsVar[i]="fixMMGravPlatforms"; global.dsKey[i]="402"; global.dsName[i]="Fix Gravity Platform Bug"
global.dsInfo[i]="Certain platforms using a gravity mechanic could break under certain conditions, this fixes them.#Off: They can be broken again as in the original."; i+=1
global.dsVar[i]="fixMMRecharge"; global.dsKey[i]="403"; global.dsName[i]="Fix Mega Man Boost Skill"
global.dsInfo[i]="The Boost Skill in the skill tree will function properly instead of not workin..#Off: The skill will be non-functional as in the original."; i+=1
global.dsVar[i]="fixSeraDash"; global.dsKey[i]="404"; global.dsName[i]="Fix A Boss's Upward Dash"
global.dsInfo[i]="A certain boss will dash upward properly. #Off: Their dash will remain unable to move upwards."; i+=1
global.dsVar[i]="sigmaAvoidance"; global.dsKey[i]="405"; global.dsName[i]="Cut Avoidance Attack"
global.dsInfo[i]="At half health, a certain boss uses an avoidance attack originally removed from the game. #Off: He doesn't use the move as in the."; i+=1
global.dsVar[i]="atkInputBuffer"; global.dsKey[i]="406"; global.dsName[i]="Attack Input Buffer"
global.dsInfo[i]="An attack pressed during another attack comes out as soon as that one ends.#Off: presses during an attack are ignored, as in the original."; i+=1
//niche dash change (added): shows the original dash options in Options > Control instead of Left/Right Dashing
global.dsVar[i]="nicheDashSettings"; global.dsKey[i]="407"; global.dsName[i]="Niche Dash Settings"
global.dsInfo[i]="Shows more nuanced dash settings, including the ability to dash with the dpad.#Off: Only Left/Right Dashing is shown in the controls menu."; i+=1
//socd change (added): SOCD handling, last input priority (scrSOCD)
global.dsVar[i]="socdLastInput"; global.dsKey[i]="408"; global.dsName[i]="SOCD Handling"
global.dsInfo[i]="What it says on the tin. Can no longer hold left and right at the same time. #Off: Now you can."; i+=1
global.dsCount=i
//niche dash change (added): dsDefault - each one's default (loadOptions, oGame). On, except the ones named here
for(i=0;i<global.dsCount;i+=1)
{
  global.dsDefault[i]=1
  if global.dsVar[i]="nicheDashSettings" {global.dsDefault[i]=0}
}
