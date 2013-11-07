#import "ComparableColorTests.h"
#import "ComparableColor.h"

@implementation ComparableColorTests

-(void) testGettingInitializedValues
{
  ComparableColor * color = [ComparableColor colorWithRed:10 green:20 blue:30];
  STAssertEquals((unsigned char)10, [color red], nil);
  STAssertEquals((unsigned char)20, [color green], nil);
  STAssertEquals((unsigned char)30, [color blue], nil);
}


-(void) testExceptionEqualsToNilOtherColor
{
  ComparableColor * color = [ComparableColor colorWithRed:10 green:20 blue:30];
  
  @try
  {
    [color equalsToColor:nil withEpsilon:1.0];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testExeptionEqualsEpsilonLessThanBounds
{
  ComparableColor * color = [ComparableColor colorWithRed:10 green:20 blue:30];
  ComparableColor * otherColor = [ComparableColor colorWithRed:20 green:30 blue:40];
  @try
  {
    [color equalsToColor:otherColor withEpsilon:-0.1];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testExeptionEqualsEpsilonMoreThanBounds
{
  ComparableColor * color = [ComparableColor colorWithRed:10 green:20 blue:30];
  ComparableColor * otherColor = [ComparableColor colorWithRed:20 green:30 blue:40];
  @try
  {
    [color equalsToColor:otherColor withEpsilon:1.1];
    STFail(nil);
  }
  @catch (NSException *exception)
  {
    // ok
  }
}


-(void) testEqualsWithMaxEpsilon
{
  ComparableColor * color = [ComparableColor colorWithRed:0 green:0 blue:0];
  ComparableColor * equalsColor = [ComparableColor colorWithRed:254 green:255 blue:255];
  ComparableColor * notEqualsColor = [ComparableColor colorWithRed:255 green:255 blue:255];
  
  STAssertTrue([color equalsToColor:equalsColor withEpsilon:1.0], nil);
  STAssertFalse([color equalsToColor:notEqualsColor withEpsilon:1.0], nil);
}


-(void) testEqualsWithMinEpsilon
{
  ComparableColor * color = [ComparableColor colorWithRed:10 green:10 blue:10];
  ComparableColor * equalsColor = [ComparableColor colorWithRed:10 green:10 blue:10];
  ComparableColor * notEqualsColor = [ComparableColor colorWithRed:11 green:10 blue:10];
  
  STAssertTrue([color equalsToColor:equalsColor withEpsilon:0.0], nil);
  STAssertFalse([color equalsToColor:notEqualsColor withEpsilon:0.0], nil);
}

@end
