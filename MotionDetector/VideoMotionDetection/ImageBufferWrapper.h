#import <Foundation/Foundation.h>
#import "ComparableColor.h"

/**
 Wrapper of buffer that contains image
 */
@protocol ImageBufferWrapper <NSObject>

@required
-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY;
-(size_t) imageHeight;
-(size_t) imageWidth;

@end
