#import <Foundation/Foundation.h>

/**
 Цвет с возможностью сравенения с другим цветом.
 */
@interface ComparableColor : NSObject
{
  @private
  unsigned char red;
  unsigned char green;
  unsigned char blue;
}

/// Создать со значениями красного, зеленого и синего канолов
+(ComparableColor *) colorWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b;

-(id) init;

/// Инициализировать значениями красного, зеленого и синего канолов
-(id) initWithRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b;

/// Сравнить эвивалентны ли цвета, с заданного погрешностью. Цвет для сравенения должен быть не nil. Погрешноть должна быть от 0.0 до 1.0
-(BOOL) equalsToColor:(ComparableColor *)otherColor withEpsilon:(double)epsilon;

@property (assign) unsigned char red;
@property (assign) unsigned char green;
@property (assign) unsigned char blue;

@end
