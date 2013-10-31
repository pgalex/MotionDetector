#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ComparableColor.h"

/**
 Wrapper of CVImageBufferRef.
 */
@interface ImageBufferWrapper : NSObject
{
  @private
  CVImageBufferRef imageBuffer;
}

/**
 Create wrapper of buffer with its locking. Need to call unlock after end of working with wrapper
 */
+(ImageBufferWrapper *) wrapperOfSampleBufferWithLocking:(CVImageBufferRef)buffer;

/**
 Not supported initializer
 */
-(id) init;

/**
 Init buffer with its locking. Need to call unlock after end of working with wrapper
 */
-(id) initWithSampleBufferWithLocking:(CVImageBufferRef)buffer;

/**
 Get color of pixel with coordinates
 \param x must be from 0 to image width
 \param y must be from 0 to image height
 \return color of pixel. Not nil
 */
-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY;

-(void) unlock;
-(size_t) imageHeight;
-(size_t) imageWidth;

@end
