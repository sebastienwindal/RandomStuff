# Basic iOS patterns to make two objects "talk" to each other

* delegation
* KOV
* NSNotification
* callback handlers using selectors
* callback handlers using blocks

## delegation

```objC
@class BigCalculator1;

@protocol BigCalculatorDelegate <NSObject>

-(void) bigCalculator:(BigCalculator1 *)calculator didFinishOperationWithResult:(float)result;
-(void) bigCalculator:(BigCalculator1 *)calculator madeProgressOnCalculation:(float)percentProgress;

@end


@interface BigCalculator1 : NSObject

-(void) startBigCalculationWithNumber:(float)number1 and:(float)number2;

@property (nonatomic, weak) id<BigCalculatorDelegate> delegate;

@end
```