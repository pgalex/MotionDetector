#import "ComparableColor.h"

@implementation ComparableColor

@synthesize red, green, blue;


+(ComparableColor *) colorWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b
{ 
  return [[ComparableColor alloc] initWithRed:r green:g blue:b];
}


/**
 Init with default values
 */
-(id) init
{
  return [self initWithRed:0 green:0 blue:0];
}


-(id) initWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b
{
  if (self = [super init])
  {
    red = r;
    green = g;
    blue = b;
  }
  
  return self;
}


/**
 Compare with epsilon to other color
 \param otherColor must be not nil
 \param epsilon must be from 0.0 to 1.0
 */
-(BOOL) equalsToColor:(ComparableColor *)otherColor withEpsilon:(double)epsilon
{
  if (otherColor == nil)
  {
    @throw([NSException exceptionWithName:@"Nil color" reason:@"otherColor must be not nil" userInfo:nil]);
  }
  if (epsilon < 0.0 || epsilon > 1.0 )
  {
    @throw([NSException exceptionWithName:@"Incorrect epsilon" reason:@"epsilon must be from 0 to 1" userInfo:nil]);
  }
  
  // 0.0 - минимальная погрешность - точное соотвествие значений
  // 1.0 - максимальная погрешность - разница 254 и меньше
  
  int deltaRed = abs(red - [otherColor red]);
  if (deltaRed > epsilon * 254.0)
    return NO;
  
  int deltaGreed = abs(green - [otherColor green]);
  if (deltaGreed > epsilon * 254.0)
    return NO;
  
  int deltaBlue = abs(blue - [otherColor blue]);
  if (deltaBlue > epsilon * 254.0)
    return NO;
  
  return YES;
}

@end
