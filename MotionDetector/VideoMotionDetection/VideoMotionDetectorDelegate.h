#import <Foundation/Foundation.h>

@protocol VideoMotionDetectorDelegate <NSObject>

-(void) videoMotionStartOccuring;
-(void) videoMotionStopOccuring;

@end
