//
//  MotionDetectingVideoOutputDelegate.m
//  CameraTest
//
//  Created by Александр Преображенцев on 05.10.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import "MotionDetectingVideoOutputAnalizer.h"

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
  if (skipedFramesCount < 15)
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
