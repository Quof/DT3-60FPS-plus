if yDir > -6
    //yDir -=1
    yDir -=1*gDeltaTime //60fps change: a tick's pull spread over its frames (as the step's fall)

if yDir < -6
    yDir = -6

gravEffect=true
