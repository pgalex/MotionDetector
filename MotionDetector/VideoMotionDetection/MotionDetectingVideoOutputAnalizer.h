#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoMotionDetector.h"
#import "VideoMotionDetectorDelegate.h"

/**
 Motion detecting video output delegate
 */
@interface MotionDetectingVideoOutputAnalizer : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>
{
  @private
  /// frame of video output that are currently skiped. Using to detects motion not by every frame
  int skipedFramesCount;
  
  VideoMotionDetector * motionDetector;
  
  /// Is there motion in last processed frames
  BOOL motionOccuring;
}

/// Delegate of motion detector
@property (weak) id<VideoMotionDetectorDelegate> motionDetectingDelegate;

-(id) init;

@end
