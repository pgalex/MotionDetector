#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ImageBufferWrapper.h"

/**
 Detector of motion in frames of video
 */
@interface VideoMotionDetector : NSObject
{
  @private
  NSArray * sectorsAverageColors;
  BOOL motionDetected;
  double motionDetectingPrecision;
}

/**
 Init with default values
 */
-(id) init;

/**
 Is there any motion detected in last processed frame
 */
-(BOOL) motionDetected;

/**
 Process frame (with ImageBufferWrapper) of video for detecting motion.
 \param imageWrapper must be not nil. Image size must be more that minimumImageWidth and minimumImageHeight
 */
-(void) processImage:(id<ImageBufferWrapper>)imageWrapper;

/**
 Set motion detecting precision. 
 \param precision must be from 0.0(only big changes will be detected) to 1.0(minimal changes will be detected)
 */
-(void) setMotionDetectingPrecision:(double)precision;

+(int) minimumImageWidth;
+(int) minimumImageHeight;

@end
