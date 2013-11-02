#import "ComparableColor.h"

#define MIN_EPSILON 0.0
#define MAX_EPSILON 1.0

@implementation ComparableColor

@synthesize red, green, blue;


+(ComparableColor *) colorWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b
{ 
  return [[ComparableColor alloc] initWithRed:r green:g blue:b];
}


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


-(BOOL) equalsToColor:(ComparableColor *)otherColor withEpsilon:(double)epsilon
{
  if (otherColor == nil)
  {
    @throw([NSException exceptionWithName:@"Nil color" reason:@"otherColor must be not nil" userInfo:nil]);
  }
  if (epsilon < MIN_EPSILON || epsilon > MAX_EPSILON )
  {
    @throw([NSException exceptionWithName:@"Incorrect epsilon" reason:@"epsilon must be from 0 to 1" userInfo:nil]);
  }
  
  // 0.0 - минимальная погрешность - точное соотвествие значений
  // 1.0 - максимальная погрешность - разница 254 и меньше
  
  double normalizedEpsilon = epsilon * 254.0;
  
  int deltaRed = abs(red - [otherColor red]);
  if (deltaRed > normalizedEpsilon)
    return NO;
  
  int deltaGreed = abs(green - [otherColor green]);
  if (deltaGreed > normalizedEpsilon)
    return NO;
  
  int deltaBlue = abs(blue - [otherColor blue]);
  if (deltaBlue > normalizedEpsilon)
    return NO;
  
  return YES;
}

@end
