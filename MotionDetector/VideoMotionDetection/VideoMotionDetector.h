//
//  VideoMotionDetector.h
//  CameraTest
//
//  Created by Александр Преображенцев on 25.08.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ImageBufferWrapper.h"

/**
 Определитель движения по кадрам видоеряда
 */
@interface VideoMotionDetector : NSObject
{
  @private
  NSArray * sectorsAverageColors;
  BOOL motionDetected;
  double motionDetectingPrecision;
}

/// изициализировать значениями по умолчанию
-(id) init;

/// обнаружено ли движение в по результатам обработки кадров видео
-(BOOL) motionDetected;

/// обработать кадр видое для определения движения через CMSampleBufferRef. Размер изображения должен быть не меньше minimumImageWidth, minimumImageHeight
-(void) processSampleBuffer:(CMSampleBufferRef)sampleBuffer;

/// обработать кадр видое для определения движения через ImageBufferWrapper. imageWrapper должен быть не nil. Размер¬ не меньше minimumImageWidth, minimumImageHeight
-(void) processImage:(ImageBufferWrapper *)imageWrapper;

/// Установить точность обнаружения движения. Значение должно быть от 0.0 до 1.0
-(void) setMotionDetectingPrecision:(double)precision;

+(int) minimumImageWidth;
+(int) minimumImageHeight;

@end
