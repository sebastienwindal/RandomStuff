# Basic iOS patterns to make two objects "talk" to each other

* delegation
* KOV
* NSNotification
* callback handlers using selectors
* callback handlers using blocks

Scenario.

We have an object (BigCalculator) that performs in the background an operation. This operation takes time,
and it can be started by calling the startBigCalculationWithNumber:andNumber: operation.
We want to be notified of the progress of the calculation and when it finishes.

Many of those patterns are used in iOS to:
* have a UIView tells a UIViewController something happened (e.g. button click, UITableView row selection), etc...
* have a child view controller tell its parent one of its model object changed
* have a view controller be notified of changes in a model object (backend service, database change, device state change, etc...)


## delegation

Define a protocol (interface) that describes the methods the delegate object must or should implement.
The object that wants to get notified of a change registers itself as a delegate of a object via a property, 
typically called delegate.

```objC
@class BigCalculator1;

@protocol BigCalculatorDelegate <NSObject>

-(void) bigCalculator:(BigCalculator1 *)calculator didFinishOperationWithResult:(float)result;
-(void) bigCalculator:(BigCalculator1 *)calculator madeProgressOnCalculation:(float)percentProgress;

@end

@interface BigCalculator1 : NSObject

// start to do some work
-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

// the class delegate, this object that will be notified when BigCalculator feels like it.
@property (nonatomic, weak) id<BigCalculatorDelegate> delegate;

@end
```




Notes:
Lose coupling, BigCalculator does not know anything about the registered object, other that it implements the two methods defines in the BigCalculatorDelegate protocol.
Pros:
Simple, widely tested. The default pattern in iOS for this kind of stuff.
Cons:
BigCalculator can only notify one object at a time.