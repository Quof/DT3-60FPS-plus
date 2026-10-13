//Variables Altered Insanity gave every enemy (in the original's oDamagableBase create event), which its bosses look at.
//What turns them on (armor, more resistances, defense) is Altered Beast's equipment: with the Altered Beast mod on, its
//version of this event sets them, and they're left as it set them.
if !variable_local_exists("increaseResists") {increaseResists=0}
if !variable_local_exists("armor") {armor=0}
if !variable_local_exists("hasArmor") {hasArmor=0}
if !variable_local_exists("weakened") {weakened=0}
if !variable_local_exists("defense") {defense=0}
if !variable_local_exists("birdKill") {birdKill=1}
