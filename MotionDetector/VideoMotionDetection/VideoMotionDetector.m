#import "VideoMotionDetector.h"
#import "ComparableColor.h"

#define SECTOR_WIDTH 16
#define SECTOR_HEIGHT 16
#define DEFAULT_PRECISION 0.6
#define MIN_PRECISION 0.0
#define MAX_PRECISION 1.0

@implementation VideoMotionDetector

-(id) init
{
  if (self = [super init])
  {
    sectorsAverageColors = nil;
    motionDetected = NO;
    motionDetectingPrecision = DEFAULT_PRECISION;
  }
  
  return self;
}


-(BOOL) motionDetected
{
  return motionDetected;
}


-(void) setMotionDetectingPrecision:(double)precision
{
  if (precision < MIN_PRECISION || precision > MAX_PRECISION)
  {
    @throw ([NSException exceptionWithName:@"Incorrect precision" reason:@"Value must be from 0.0 to 1.0" userInfo:nil]);
  }
  
  motionDetectingPrecision = precision;
}


-(void) processImage:(id<ImageBufferWrapper>)imageWrapper;
{
  // todo правильная обработка изображений любого масштаба
  if (imageWrapper == nil)
  {
    @throw ([NSException exceptionWithName:@"Incorrect image" reason:@"Image wrapper must be not nil" userInfo:nil]);
  }
  if ([imageWrapper imageWidth] < [VideoMotionDetector minimumImageWidth] || [imageWrapper imageHeight] < [VideoMotionDetector minimumImageHeight])
  {
    @throw ([NSException exceptionWithName:@"Incorrect image" reason:@"Image size must be more than minimumImageWidth and minimumImageHeight" userInfo:nil]);
  }
  
  int sectorsByWidthCount = floor([imageWrapper imageWidth] / SECTOR_WIDTH);
  int sectorsByHeightCount = floor([imageWrapper imageHeight] / SECTOR_HEIGHT);
  // учесть крайние сектора
  
  NSMutableArray * newSectorsAverageColors = [[NSMutableArray alloc] initWithCapacity:(sectorsByWidthCount * sectorsByHeightCount)];
  for (int sectorHeightIndex = 0; sectorHeightIndex < sectorsByHeightCount; sectorHeightIndex++)
  {
    for (int sectorWidthIndex = 0; sectorWidthIndex < sectorsByWidthCount; sectorWidthIndex++)
    {
      ComparableColor * averageColor = [self computeAverageColorOfSectorWithWidthIndex:sectorWidthIndex heightIndex:sectorHeightIndex image:imageWrapper];
      if (averageColor != nil )
      {
        [newSectorsAverageColors insertObject:averageColor atIndex:(sectorWidthIndex + sectorHeightIndex * sectorsByWidthCount)];
      }
    }
  }
  
  motionDetected = [self findMotionInSectorsData:newSectorsAverageColors comparingWith:sectorsAverageColors];
  sectorsAverageColors = newSectorsAverageColors;
}


-(BOOL) findMotionInSectorsData:(NSArray *)sectorsData comparingWith:(NSArray*)otherSectorsData
{
  if(sectorsData == nil || otherSectorsData == nil)
  {
    return NO;
  }
  if([sectorsData count] != [otherSectorsData count])
  {
    return NO;
  }
  
  BOOL existsMotionInAnySector = NO;
  for (int i = 0; i < [sectorsData count]; i++)
  {
    ComparableColor * firstColor = [sectorsData objectAtIndex:i];
    ComparableColor * secondColor = [otherSectorsData objectAtIndex:i];
    if (![firstColor equalsToColor:secondColor withEpsilon:(1.0 - motionDetectingPrecision)])
    {
      existsMotionInAnySector = YES;
      break;
    }
  }
  
  return existsMotionInAnySector;
}


-(ComparableColor *) computeAverageColorOfSectorWithWidthIndex:(int)sectorWidthIndex heightIndex:(int)sectorHeightIndex image:(id<ImageBufferWrapper>)imageWrapper
{
  int startX = sectorWidthIndex * SECTOR_WIDTH;
  int endX = (sectorWidthIndex + 1) * SECTOR_WIDTH;
  int startY = sectorHeightIndex * SECTOR_HEIGHT;
  int endY = (sectorHeightIndex + 1) * SECTOR_HEIGHT;
  
  int sumRed = 0;
  int sumGreen = 0;
  int sumBlue = 0;
  int processedPixelsCount = 0;
  
  for (int x = startX; x < endX; x += 4)
  {
    for (int y = startY; y < endY ; y += 4)
    {
      ComparableColor * pixelColor = [imageWrapper getColorOfPixelAtX:x y:y];
      sumRed += [pixelColor red];
      sumGreen += [pixelColor green];
      sumBlue += [pixelColor blue];
      processedPixelsCount++;
    }
  }
  
  if (processedPixelsCount > 0 )
  {
    return [ComparableColor colorWithRed:(sumRed / processedPixelsCount) green:(sumGreen / processedPixelsCount) blue:(sumBlue / processedPixelsCount)];
  }
  else
  {
    return nil;
  }
}


+(int) minimumImageWidth
{
  return SECTOR_WIDTH;
}


+(int) minimumImageHeight
{
  return SECTOR_HEIGHT;
}

@end
