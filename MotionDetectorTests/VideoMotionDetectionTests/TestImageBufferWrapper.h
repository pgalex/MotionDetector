#import <Foundation/Foundation.h>
#import "ImageBufferWrapper.h"


/**
 Realization of ImageBufferWrapper for testing
 */
@interface TestImageBufferWrapper: NSObject<ImageBufferWrapper>
{
@private
  size_t imageWidth;
  size_t imageHeight;
}

-(id) init;

-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY;
-(size_t) imageHeight;
-(size_t) imageWidth;

-(void) setImageHeight:(size_t)height;
-(void) setImageWidth:(size_t)width;

@end
