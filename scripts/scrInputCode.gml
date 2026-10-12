/*
input text change (added): the input a [token] in a text stands for, or -1 if it isn't one. Texts name inputs with tokens
like [Jump] or [Action A]; when drawn they show the key it's set to ([J]) or, with the gamepad in use, its button's icon
(scrInputText, scrDrawInput). Codes 1-16 are scrController's; the rest:
  101-104 [Left Key] [Right Key] [Up Key] [Down Key]: the keyboard letter for that direction (the arrow keys are [Left] etc.)
  201-204 [Left Keys] [Right Keys] [Up Keys] [Down Keys]: both ("[Left] or [A]"); one icon on a gamepad
  117 [Arrow Keys]: the left stick on a gamepad; 118 [WASD]: the d-pad
argument0: the text between the brackets
*/
var n;
n=argument0
if n="Left" {return 1}
if n="Right" {return 2}
if n="Up" {return 3}
if n="Down" {return 4}
if n="Jump" {return 5}
if n="Action A" or n="Action Button A" {return 6}
if n="Action B" or n="Action Button B" {return 7}
if n="Action C" or n="Action Button C" or n="Button C" {return 8}
if n="Character Swap" {return 9}
if n="Ability Swap" {return 10}
if n="Skip" {return 11}
if n="Pause" {return 12}
if n="Dash Left" or n="Dash Back" {return 13}
if n="Dash Right" or n="Dash Forward" {return 14}
if n="Confirm" or n="Confirm/Jump" {return 15}
if n="Cancel" {return 16}
if n="Left Key" {return 101}
if n="Right Key" {return 102}
if n="Up Key" {return 103}
if n="Down Key" {return 104}
if n="Left Keys" {return 201}
if n="Right Keys" {return 202}
if n="Up Keys" {return 203}
if n="Down Keys" {return 204}
if n="Arrow Keys" {return 117}
if n="WASD" {return 118}
return -1
