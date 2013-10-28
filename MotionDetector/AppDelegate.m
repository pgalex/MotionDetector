//
//  AppDelegate.m
//  MotionDetector
//
//  Created by Александр Преображенцев on 13.10.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  videoMotionDetector = [[MotionDetectingVideoOutputAnalizer alloc] init];
  [videoMotionDetector setMotionDetectingDelegate:self];
  captureSession = [[AVCaptureSession alloc] init];
  BOOL initializingSuccess = [self initializeVideoCapturing];
  if (initializingSuccess)
  {
    [captureSession startRunning];
  }
  else
  {
    NSLog(@"Can not initialize video capturing");
  }
}


/**
 Инициализировать захват видео.
 @return удалось ли выполнить запуск.
 */
-(BOOL)initializeVideoCapturing
{
  if (![captureSession canSetSessionPreset:AVCaptureSessionPreset640x480])
  {
    return NO;
  }
  
  [captureSession setSessionPreset:AVCaptureSessionPreset640x480];
  
  NSArray * videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
  if ([videoDevices count] <= 0)
  {
    return NO;
  }
  
  AVCaptureDevice * cameraDevice = [videoDevices objectAtIndex:0];
  
  AVCaptureDeviceInput * cameraInput = [AVCaptureDeviceInput deviceInputWithDevice:cameraDevice error:NULL];
  if (![captureSession canAddInput:cameraInput])
  {
    return NO;
  }
  [captureSession addInput:cameraInput];
  
  AVCaptureVideoPreviewLayer * previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
  [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  [previewLayer setDelegate:self];
  [[_window contentView] setLayer:previewLayer];
  [[_window contentView] setWantsLayer:YES];
  
  dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
  if (!videoDataOutputQueue)
  {
    return NO;
  }
  AVCaptureVideoDataOutput * videoOutput = [[AVCaptureVideoDataOutput alloc] init];
  NSArray * aviablePixelFormates = [videoOutput availableVideoCVPixelFormatTypes];
  if (![aviablePixelFormates containsObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]])
  {
    return NO;
  }
  [videoOutput setVideoSettings:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey, nil]];
  
  [videoOutput setSampleBufferDelegate:videoMotionDetector queue:videoDataOutputQueue];
  dispatch_release(videoDataOutputQueue);
  
  [captureSession addOutput:videoOutput];
  
  return YES;
}


-(IBAction)startButtonPressed:(id)sender
{
}


-(void) videoMotionOccure
{
  [[self window] setTitle:@"Motion detected"];
}

-(void) videoMotionStopOccuring
{
  [[self window] setTitle:@"No motion detected"];
}


-(void)applicationWillTerminate:(NSNotification *)notification
{
  if ([captureSession isRunning])
  {
    [captureSession stopRunning];
  }
}


-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
  return YES;
}

@end
