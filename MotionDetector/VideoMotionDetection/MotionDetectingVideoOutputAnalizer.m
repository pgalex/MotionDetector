#import "MotionDetectingVideoOutputAnalizer.h"

static const int SKIPED_FRAMES_COUNT = 15;

@implementation MotionDetectingVideoOutputAnalizer

@synthesize motionDetectingDelegate;

-(id)init
{
  if (self = [super init])
  {
    skipedFramesCount = 0;
    motionDetectingDelegate = nil;
    motionOccuring = NO;
    motionDetector = [[VideoMotionDetector alloc] init];
  }
  
  return self;
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
  if (skipedFramesCount < SKIPED_FRAMES_COUNT)
  {
    skipedFramesCount++;
    return;
  }
  skipedFramesCount = 0;
  [motionDetector processSampleBuffer:sampleBuffer];
  
  
  BOOL existsChangesInMotionOccuring = [motionDetector motionDetected] != motionOccuring;
  if (existsChangesInMotionOccuring)
  {
    motionOccuring = [motionDetector motionDetected];
    [self sendMotionOccuringStatusToDelegate];
  }
}


-(void) sendMotionOccuringStatusToDelegate
{
  if (motionDetectingDelegate != nil)
  {
    if (motionOccuring)
    {
      [motionDetectingDelegate videoMotionOccure];
    }
    else
    {
      [motionDetectingDelegate videoMotionStopOccuring];
    }
  }
}

@end
