//
//  AppDelegate.h
//  MotionDetector
//
//  Created by Александр Преображенцев on 13.10.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import "MotionDetectingVideoOutputAnalizer.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, VideoMotionDetectorDelegate>
{
@private
  AVCaptureSession * captureSession;
  MotionDetectingVideoOutputAnalizer * videoMotionDetector;
}

@property (assign) IBOutlet NSWindow *window;

@end
