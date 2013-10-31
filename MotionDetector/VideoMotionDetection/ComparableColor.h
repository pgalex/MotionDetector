#import <Foundation/Foundation.h>

/**
 Color that can be compared to other color
 */
@interface ComparableColor : NSObject
{
  @private
  unsigned char red;
  unsigned char green;
  unsigned char blue;
}

+(ComparableColor *) colorWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b;

/**
 Init with default values
 */
-(id) init;


-(id) initWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b;

/**
 Compare with epsilon to other color
 \param otherColor must be not nil
 \param epsilon must be from 0.0 to 1.0
 */
-(BOOL) equalsToColor:(ComparableColor *)otherColor withEpsilon:(double)epsilon;

@property (assign) unsigned char red;
@property (assign) unsigned char green;
@property (assign) unsigned char blue;

@end
