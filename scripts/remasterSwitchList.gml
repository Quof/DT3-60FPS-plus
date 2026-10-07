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
global.dsInfo[i]="Makes the dark backgrounds in the Final Nightmare and Shadow Form fights lighter.#Off: as dark as the original."; i+=1
global.dsVar[i]="fixMMGravPlatforms"; global.dsKey[i]="402"; global.dsName[i]="Fix Gravity Platform Bug"
global.dsInfo[i]="Platforms moved with Mega Man's Gravity Well stop at the ends of their tracks, and every Gravity Well that reaches a platform's end explodes.#Off: platforms can be pushed past their tracks, as in the original."; i+=1
global.dsVar[i]="fixMMRecharge"; global.dsKey[i]="403"; global.dsName[i]="Fix Mega Man Boost Skill"
global.dsInfo[i]="The Boost skill (Skill Tree) speeds up X Buster and X Special recovery like it says it does.#Off: the skill doesn't change the recovery speed, as in the original."; i+=1
global.dsVar[i]="fixSeraDash"; global.dsKey[i]="404"; global.dsName[i]="Fix Sera's Upward Dash"
global.dsInfo[i]="Sera's upward dashes travel as far as her other dashes.#Off: they stop as soon as they start, as in the original."; i+=1
global.dsVar[i]="sigmaAvoidance"; global.dsKey[i]="405"; global.dsName[i]="Sigma Avoidance Attack"
global.dsInfo[i]="At half health, Sigma uses his avoidance attack: spikes slide out of the walls and waves of walls cross the room.#Off: he doesn't use it, as in the original."; i+=1
global.dsVar[i]="atkInputBuffer"; global.dsKey[i]="406"; global.dsName[i]="Attack Input Buffer"
global.dsInfo[i]="An attack pressed during another attack comes out as soon as that one ends.#Off: presses during an attack are ignored, as in the original."; i+=1
//niche dash change (added): shows the original dash options in Options > Control instead of Left/Right Dashing
global.dsVar[i]="nicheDashSettings"; global.dsKey[i]="407"; global.dsName[i]="Niche Dash Settings"
global.dsInfo[i]="Show the D-Pad Dash, Right is Forward and DT4 Dashing options in Options > Control, in place of Left/Right Dashing.#Off: only Left/Right Dashing is shown."; i+=1
//socd change (added): SOCD handling, last input priority (scrSOCD)
global.dsVar[i]="socdLastInput"; global.dsKey[i]="408"; global.dsName[i]="SOCD: Last Input Priority"
global.dsInfo[i]="Left and right (or up and down) held at once: only the one pressed last counts, and the other takes over when it's let go. Pressed together, right (or up) wins.#Off: both count at once, as in the original."; i+=1
global.dsCount=i
//niche dash change (added): dsDefault - each one's default (loadOptions, oGame). On, except the ones named here
for(i=0;i<global.dsCount;i+=1)
{
  global.dsDefault[i]=1
  if global.dsVar[i]="nicheDashSettings" {global.dsDefault[i]=0}
}
