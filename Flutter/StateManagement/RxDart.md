# RxDart
RxDart is a powerful library that extends the capabilities of `Dart Streams` and `StreamControllers`, adding functionality from the reactive extensions specification. It is particularly useful in Flutter applications for building highly responsive and scalable user interfaces.

### Key concepts
### 1. Observable<T> class
Observable allow us to send a notification to Widgets which is observing it and then deal with the flux of data. Observable class in RxDart extends from Stream, which implies in some great things:
- All methods defined on the Stream class exist on Observable as well.
- All Observable can be passed to any API that expects a Dart Stream as an input (including for example StreamBuilder Widget).

### 2. PublishSubject<T> class
This one is pretty simple. This Subject allows sending data, error and done events to the listener. Here it will work with Sinks, which we were talking about before. See the example above:
```
PublishSubject<int> subject = new PublishSubject<int>();

/*this listener below will print every integer added to the subject: 1, 2, 3, ...*/
subject.stream.listen(print);
subject.add(1);
subject.add(2);

/*but this listener below will print only the integer added after his initialization: 3, .../*
subject.stream.listen(print);
subject.add(3);
```

### 3. BehaviorSubject<T> class
This one is similar to the PublishSubject. It also allows sending data, error and done events to the listener, but the latest item that has been added to the subject will be sent to any new listeners of the subject. But don’t you worry, after that, any new events will be appropriately sent to the listeners. See the example above:
```
BehaviorSubject<int> subject = new BehaviorSubject<int>();
subject.stream.listen(print); // prints 1,2,3 
subject.add(1);
subject.add(2);
subject.add(3);

subject.stream.listen(print); // prints 3
```

### 4. ReplaySubject<T> class
The ReplaySubject allow us the same: sending data, error and done events to the listener. But with a crucial difference here. As items are added to the subject, the ReplaySubject will store them and when the stream is listened to, those recorded items will be emitted to the listener. See the example above:
```
ReplaySubject<int> subject = new ReplaySubject<int>();

subject.add(1);
subject.add(2);
subject.add(3);

subject.stream.listen(print); // prints 1, 2, 3
```