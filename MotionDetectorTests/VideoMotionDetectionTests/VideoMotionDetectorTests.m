#import "VideoMotionDetectorTests.h"
#import "VideoMotionDetector.h"
#import "TestImageBufferWrapper.h"

@implementation VideoMotionDetectorTests

-(void) testInitWithCorrectValues
{
  VideoMotionDetector * motionDetector = [[VideoMotionDetector alloc] init];
  STAssertFalse([motionDetector motionDetected], nil);
}


-(void) testExceptionWhenProcessedNilImage
{
  VideoMotionDetector * motionDetector = [[VideoMotionDetector alloc] init];
  
  @try
  {
    [motionDetector processImage:nil];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testExceptionWhenProcessingToSmallImageWidth
{
  VideoMotionDetector * motionDetector = [[VideoMotionDetector alloc] init];
  TestImageBufferWrapper * testImage = [[TestImageBufferWrapper alloc] initWithImageWidth:([VideoMotionDetector minimumImageWidth] - 1) imageHeight:([VideoMotionDetector minimumImageHeight] + 1)];
  @try
  {
    [motionDetector processImage:testImage];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testExceptionWhenProcessingToSmallImageHeight
{
  VideoMotionDetector * motionDetector = [[VideoMotionDetector alloc] init];
  TestImageBufferWrapper * testImage = [[TestImageBufferWrapper alloc] initWithImageWidth:([VideoMotionDetector minimumImageWidth] + 1) imageHeight:([VideoMotionDetector minimumImageHeight] - 1)];
  @try
  {
    [motionDetector processImage:testImage];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testExceptionSettingTooSmallPrecision
{
  VideoMotionDetector * motionDetector = [[VideoMotionDetector alloc] init];
   @try
  {
    [motionDetector setMotionDetectingPrecision:-0.1];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testExceptionSettingTooBigPrecision
{
  VideoMotionDetector * motionDetector = [[VideoMotionDetector alloc] init];
  @try
  {
    [motionDetector setMotionDetectingPrecision:1.1];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


// todo тесты на обнаружение движения

@end
