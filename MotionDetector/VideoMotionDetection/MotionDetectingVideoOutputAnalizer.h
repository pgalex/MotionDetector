//
//  MotionDetectingVideoOutputDelegate.h
//  CameraTest
//
//  Created by Александр Преображенцев on 05.10.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoMotionDetector.h"
#import "VideoMotionDetectorDelegate.h"
/**
 Делегат обработки кадров видео с определением движения по кадрам видеоряда
 */
@interface MotionDetectingVideoOutputAnalizer : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>
{
  @private
  int skipedFramesCount;
  VideoMotionDetector * motionDetector;
  BOOL motionOccuring;
}

@property (weak) id<VideoMotionDetectorDelegate> motionDetectingDelegate;

-(id) init;

@end
