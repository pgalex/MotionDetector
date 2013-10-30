#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ComparableColor.h"

/**
 Wrapper of CVImageBufferRef.
 */
@interface ImageBufferWrapper : NSObject
{
  @private
  CVImageBufferRef imageBuffer;
}

+(ImageBufferWrapper *) wrapperOfSampleBufferWithLocking:(CVImageBufferRef)buffer;

-(id) init;

-(id) initWithSampleBufferWithLocking:(CVImageBufferRef)buffer;

/// Получить значение цвета пикселя изображения с коодинатами. Координаты должны быть в пределах размеров изображения
-(ComparableColor *) getColorOfPixelAtX:(int)pixelX y:(int)pixelY;

-(void) unlock;
-(size_t) imageHeight;
-(size_t) imageWidth;

@end
