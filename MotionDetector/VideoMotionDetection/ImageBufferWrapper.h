//
//  SampleBufferWrapper.h
//  CameraTest
//
//  Created by Александр Преображенцев on 12.10.13.
//  Copyright (c) 2013 Александр Преображенцев. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ComparableColor.h"

/**
 Обертка для упрощения взаимодействия с CVImageBufferRef
 */
@interface ImageBufferWrapper : NSObject
{
  @private
  CVImageBufferRef imageBuffer;
}

/// Создать обертку буфер с блокировкой. По окончанию работы требуется вызвать unlock
+(ImageBufferWrapper *) wrapperOfSampleBufferWithLocking:(CVImageBufferRef)buffer;

/// Не используется
-(id) init;

/// Инициализировать по буферу изображения с блокировкой. По окончанию работы требуется вызвать unlock
-(id) initWithSampleBufferWithLocking:(CVImageBufferRef)buffer;

/// Получить значение цвета пикселя изображения с коодинатами. Координаты должны быть в пределах размеров изображения
-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY;

-(void) unlock;
-(size_t) imageHeight;
-(size_t) imageWidth;

@end
