#import "CVImageBufferWrapper.h"
#import "ComparableColor.h"

/*BGRA*/
#define SUPPORTING_PIXEL_FORMAT 1111970369

@implementation CVImageBufferWrapper


+(CVImageBufferWrapper *) wrapperOfSampleBufferWithLocking:(CVImageBufferRef)buffer
{
  return [[CVImageBufferWrapper alloc] initWithSampleBufferWithLocking:buffer];
}


-(id) initWithSampleBufferWithLocking:(CVImageBufferRef)buffer
{
  if (self = [super init])
  {
    imageBuffer = buffer;
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    if (CVPixelBufferGetPixelFormatType(imageBuffer) != SUPPORTING_PIXEL_FORMAT)
    {
      @throw([NSException exceptionWithName:@"Incorrect pixel format" reason:@"Use kCVPixelFormatType_32BGRA output format" userInfo:nil]);
    }
  }
  
  return self;
}


-(id) init
{
  @throw([NSException exceptionWithName:@"Not suppurting initializer" reason:@"Use other initializers instead init:" userInfo:nil]);
}


-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY;
{
  if (pixelX < 0 || pixelX > [self imageWidth])
  {
    @throw([NSException exceptionWithName:@"Incorrect pixel x" reason:@"Value must be from 0 to image width" userInfo:nil]);
  }
  if (pixelY < 0 || pixelY > [self imageHeight])
  {
    @throw([NSException exceptionWithName:@"Incorrect pixel y" reason:@"Value must be from 0 to image height" userInfo:nil]);
  }
  
  size_t imageWidth = [self imageWidth];
  int bytesPerPixel = floor(CVPixelBufferGetBytesPerRow(imageBuffer) / imageWidth);
  unsigned char * pixelBuffer = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
  
  unsigned char blue = pixelBuffer[(pixelY * imageWidth + pixelX) * bytesPerPixel]; // BGRA coding
  unsigned char green = pixelBuffer[(pixelY * imageWidth + pixelX) * bytesPerPixel + 1];
  unsigned char red = pixelBuffer[(pixelY * imageWidth + pixelX) * bytesPerPixel + 2];
  
  return [ComparableColor colorWithRed:red green:green blue:blue];
}


-(size_t) imageWidth
{
  return CVPixelBufferGetWidth(imageBuffer);
}


-(size_t) imageHeight
{
  return CVPixelBufferGetHeight(imageBuffer);
}


-(void) unlock
{
  CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
}

@end
