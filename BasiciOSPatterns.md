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

Note that BigCalculator does not know anything about the registered object other that it implements the two methods defines in the BigCalculatorDelegate protocol.

Delegation is the most used pattern in iOS. It fits well and should be your default pattern for any in "child notifies parent" scenarios especially:
* View -> ViewController
* ViewController -> parent ViewController

It does not work so well when an object needs to notify multiple objects (e.g. we just got disconnected from the network and 5 different subsystems must adjust to that) or when the object that needs to be notified is your parent but many in many generation ago (e.g. you need to tell your great-great-great grand parent view controller you changed something and each one of the view controller in the chain would have to implement delegation to pass the information all the way down).
