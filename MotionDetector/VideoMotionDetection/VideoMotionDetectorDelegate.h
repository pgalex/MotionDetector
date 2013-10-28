//
//  VideoMotionDetectorDelegate.h
//  CameraTest
//
//  Created by Александр Преображенцев on 06.10.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VideoMotionDetectorDelegate <NSObject>

-(void) videoMotionOccure;
-(void) videoMotionStopOccuring;

@end
