#import "TestImageBufferWrapper.h"
#import "ComparableColor.h"

@implementation TestImageBufferWrapper

-(id) init
{
  @throw([NSException exceptionWithName:@"Not supporting initializer" reason:@"" userInfo:nil]);
}


-(id) initWithImageWidth:(size_t)width imageHeight:(size_t)height
{
  if (self = [super init])
  {
    imageWidth = width;
    imageHeight = height;
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

@end
