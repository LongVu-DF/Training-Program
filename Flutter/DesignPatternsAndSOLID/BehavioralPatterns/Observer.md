# Observer
**Observer** is a behavioral design pattern that lets you define a subscription mechanism to notify multiple objects about any events that happen to the object they’re observing.
### 1. Problem
Imagine that you have two types of objects: a `Customer` and a `Store`. The customer is very interested in a particular brand of product (say, it’s a new model of the iPhone) which should become available in the store very soon.

The customer could visit the store every day and check product availability. But while the product is still en route, most of these trips would be pointless.
![alt text](https://refactoring.guru/images/patterns/content/observer/observer-comic-1-en-2x.png)
On the other hand, the store could send tons of emails (which might be considered spam) to all customers each time a new product becomes available. This would save some customers from endless trips to the store. At the same time, it’d upset other customers who aren’t interested in new products.

It looks like we’ve got a conflict. Either the customer wastes time checking product availability or the store wastes resources notifying the wrong customers.

### 2. Solution
The object that has some interesting state is often called *subject*, but since it’s also going to notify other objects about the changes to its state, we’ll call it *publisher*. All other objects that want to track changes to the publisher’s state are called *subscribers*.

The Observer pattern suggests that you add a subscription mechanism to the publisher class so individual objects can subscribe to or unsubscribe from a stream of events coming from that publisher. Fear not! Everything isn’t as complicated as it sounds. In reality, this mechanism consists of an array field for storing a list of references to subscriber objects and several public methods which allow adding subscribers to and removing them from that list.
![alt text](https://refactoring.guru/images/patterns/diagrams/observer/solution1-en-2x.png)
Now, whenever an important event happens to the publisher, it goes over its subscribers and calls the specific notification method on their objects.

Real apps might have dozens of different subscriber classes that are interested in tracking events of the same publisher class. You wouldn’t want to couple the publisher to all of those classes. Besides, you might not even know about some of them beforehand if your publisher class is supposed to be used by other people.

That’s why it’s crucial that all subscribers implement the same interface and that the publisher communicates with them only via that interface. This interface should declare the notification method along with a set of parameters that the publisher can use to pass some contextual data along with the notification.
![](https://refactoring.guru/images/patterns/diagrams/observer/solution2-en-2x.png)
If your app has several different types of publishers and you want to make your subscribers compatible with all of them, you can go even further and make all publishers follow the same interface. This interface would only need to describe a few subscription methods. The interface would allow subscribers to observe publishers’ states without coupling to their concrete classes.

### 3. Structure 
![](https://refactoring.guru/images/patterns/diagrams/observer/structure-2x.png)
- The **Publisher** issues events of interest to other objects. These events occur when the publisher changes its state or executes some behaviors. Publishers contain a subscription infrastructure that lets new subscribers join and current subscribers leave the list.
- When a new event happens, the publisher goes over the subscription list and calls the notification method declared in the subscriber interface on each subscriber object.
- The **Subscriber** interface declares the notification interface. In most cases, it consists of a single update method. The method may have several parameters that let the publisher pass some event details along with the update.
- **Concrete Subscribers** perform some actions in response to notifications issued by the publisher. All of these classes must implement the same interface so the publisher isn’t coupled to concrete classes.
- Usually, subscribers need some contextual information to handle the update correctly. For this reason, publishers often pass some context data as arguments of the notification method. The publisher can pass itself as an argument, letting subscriber fetch any required data directly.
- The **Client** creates publisher and subscriber objects separately and then registers subscribers for publisher updates.

### 4. Example
We want to build a simple counter app where multiple widgets listen to and react to counter value changes without direct dependencies.

**4.1 Define the Observer Interface**
The `Observer` interface has an `update()` method that will be called when the `Subject` (Counter) changes.
```
abstract class Observer {
  void update(int value);
}
```
**4.2 Create the Subject(Observable) class**
The **Counter** class acts as the subject and maintains a list of observers. It notifies them when the counter value changes.
```
class Counter {
  int _count = 0;
  final List<Observer> _observers = [];

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void _notifyObservers() {
    for (var observer in _observers) {
      observer.update(_count);
    }
  }

  void increment() {
    _count++;
    _notifyObservers();
  }

  int get count => _count;
}
```
**4.3 Implement Observers (Widgets That Listen for Changes)**
Each observer implements the update() method to react when the counter value changes.
```
import 'package:flutter/material.dart';

// Observer Widget 1
class CounterText extends StatelessWidget implements Observer {
  final Counter counter;
  final ValueNotifier<int> _valueNotifier = ValueNotifier<int>(0);

  CounterText({required this.counter}) {
    counter.addObserver(this);
  }

  @override
  void update(int value) {
    _valueNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _valueNotifier,
      builder: (context, value, child) {
        return Text("Counter: $value", style: TextStyle(fontSize: 20));
      },
    );
  }
}

// Observer Widget 2
class CounterSquare extends StatelessWidget implements Observer {
  final Counter counter;
  final ValueNotifier<int> _valueNotifier = ValueNotifier<int>(0);

  CounterSquare({required this.counter}) {
    counter.addObserver(this);
  }

  @override
  void update(int value) {
    _valueNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _valueNotifier,
      builder: (context, value, child) {
        return Text("Square: ${value * value}", style: TextStyle(fontSize: 20));
      },
    );
  }
}
```
**4.4 Use Observer Widget**
We create an interface where clicking a button updates the counter, and both widgets (`CounterText` & `CounterSquare`) update automatically.
```
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Counter counter = Counter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Observer Pattern in Flutter")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: CounterText(counter: counter)),
            SizedBox(height: 20),
            Center(child: CounterSquare(counter: counter)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => counter.increment(),
              child: Text("Increment Counter"),
            ),
          ],
        ),
      ),
    );
  }
}
```