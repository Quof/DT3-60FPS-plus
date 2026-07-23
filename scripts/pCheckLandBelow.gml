if isCollisionBottom(1)
  return 1
if canLandOnPlatforms()
  if isCollisionPlatform()=0 and isCollisionPlatformBottom(1) and kDown=0
    return 1
return 0
