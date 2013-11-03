#import "TestImageBufferWrapper.h"

@implementation TestImageBufferWrapper

-(id) init
{
  if (self = [super init])
  {
    imageWidth = 0;
    imageHeight = 0;
  }
  
  return self;
}


-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY
{
  return [[ComparableColor alloc] init];
}


-(size_t) imageHeight
{
  return imageHeight;
}


-(size_t) imageWidth
{
  return imageWidth;
}

-(void) setImageHeight:(size_t)height
{
  imageHeight = height;
}


-(void) setImageWidth:(size_t)width
{
  imageWidth = width;
}

@end
