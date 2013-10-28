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

-(id) init;

-(id) initWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b;

-(BOOL) equalsToColor:(ComparableColor *)otherColor withEpsilon:(double)epsilon;

@property (assign) unsigned char red;
@property (assign) unsigned char green;
@property (assign) unsigned char blue;

@end
