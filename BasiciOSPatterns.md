# Basic iOS patterns to make two objects "talk" to each other


iOS natural pattern is MVC (Model View Controller). With this pattern the application is split between model objects (handling persistent storage, application state, backend service, etc...), views (what the user sees and touches) and view controllers (the objects that ties everything together). 
In addition of the application being split in the three standard MVC components, it is also good practice to split each parts of the application in multiple pieces, once again to achieve reusability, maintainability and easier team work. Typical example for us is to have a menu system that is not completly tied to the workspace content area so you can easily reuse the workspace and switch menu when moving from Math2 to Math3 because Math3 has a completly different menu system compared to Math2...

So a key architectural issue in any iOS app worth mentioning is how can you make all those pieces talk to each other, and do so in a reasonably decoupled way, have pieces not be dependant of eachother as possible. We will descrive patterns that are widely used in any kind of iOS application.

* Delegation
* Key Value Observing
* NSNotification
* Callback handlers using selectors
* Sallback handlers using blocks

Standard issues 

* views to view controller notification. For instance a UIView needs to notify a UIViewController that something happened (button click, UITableView row selection), etc...
* Child view controller to parent view controller notifications. For instance a UITableViewController presents a list of things, when a row is selected, an edit view for that row is presented to the user, the edit view controller needs to notify the parent tableviewcontroller whenever the edited entry is changed.
* View controller(s) need to be notified by model object changes, for instance communication with backend network service, DB, etc....

Scenario we will use to demonstrate different patterns:

We have an object (BigCalculator) that performs a complex and lengthy operation in the background.
The operation is started by calling the startBigCalculationWithNumber:andNumber: operation.
We want to be notified of the progress of the calculation when it changes and when it completes.


## delegation

Define a protocol (interface) that describes the methods the delegate object must implement.
The object that wants to get notified of a change registers itself as a delegate of a object via a property, 
typically called *delegate*.

```objC
//  BigCalculator1.h

@class BigCalculator1;

@protocol BigCalculatorDelegate <NSObject>

@required
-(void) bigCalculator:(BigCalculator1 *)calculator didFinishOperationWithResult:(float)result;

@optional
-(void) bigCalculator:(BigCalculator1 *)calculator madeProgressOnCalculation:(float)percentProgress;

@end


@interface BigCalculator1 : NSObject

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2;

@property (nonatomic, weak) id<BigCalculatorDelegate> delegate;

@end
```

```objC
// BigCalculator1.m

@implementation BigCalculator1
{
    float _number1;
    float _number2;
}

-(void) startBigCalculationWithNumber:(float)number1 andNumber:(float)number2
{
    _number1 = number1;
    _number2 = number2;
    [self performSelectorInBackground:@selector(doBackgroundWork:) withObject:nil];
}

-(void) doBackgroundWork
{
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self didFinishOperationWithResult:0.25];
    }
    
    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self didFinishOperationWithResult:0.5];
    }

    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self didFinishOperationWithResult:0.75];
    }

    [NSThread sleepForTimeInterval:1.0]; // sleep for one second
    if ([self.delegate respondsToSelector:@selector(bigCalculator:madeProgressOnCalculation:)]) {
        [self.delegate bigCalculator:self didFinishOperationWithResult:1.0];
    }
    // we are done publish the result of our calculation...
    [self.delegate bigCalculator:self didFinishOperationWithResult:(_number1 + _number2)];
}

@end
```



Note that BigCalculator does not know anything about the registered object other that it implements the two methods defined in the BigCalculatorDelegate protocol.

Delegation is the most used pattern in iOS. It fits well and should be your default pattern for any in "child notifies parent" scenarios especially:
* View -> ViewController
* ViewController -> parent ViewController

It does not work so well:
* when an object needs to notify multiple objects e.g. our backend object just lose network connectivity and many different subsystems must adjust their UI as a result by becoming read-only
* When the object that needs to be notified is your parent but many, many generation down e.g. you need to tell your great-great-great grand parent view controller you changed something. In this case, each one of the view controller in the chain would have to implement delegation to pass the information all the way down).
