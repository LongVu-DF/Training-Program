# InheritedWidget 
InheritedWidget is a specialized type of widget in Flutter that allows you to efficiently propagate data down the widget tree. It enables descendant widgets to subscribe to changes and rebuild when necessary. InheritedWidget is particularly useful for scenarios where you need to share state or configuration data across multiple widgets without explicitly passing it down the tree.

### 1. Why Use InheritedWidget?
- **Centralized State Management**: It provides a centralized way to manage and propagate state within the widget tree.
- **Efficient Updates**: Widgets that depend on InheritedWidget are automatically rebuilt when the data changes, ensuring efficient updates.
- **Foundation for Other Libraries**: Many state management libraries are built on top of InheritedWidget, making it essential to understand its workings.

### 2. Creating an InheritedWidget
To create an InheritedWidget, you need to extend the InheritedWidget class and override the updateShouldNotify method. Here’s a basic example:
```
class MyInheritedWidget extends InheritedWidget {
  final int counter;
  
  MyInheritedWidget({
    Key? key,
    required this.counter,
    required Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }
  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
```
### 3. Using inheritedWidget in application.
To use the InheritedWidget, you need to wrap the widget tree with it and access the data in descendant widgets. Here’s an example demonstrating how to use MyInheritedWidget:
```
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('InheritedWidget Example')),
        body: MyInheritedWidget(
          counter: _counter,
          child: CounterDisplay(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inheritedWidget = MyInheritedWidget.of(context);
    return Center(
      child: Text('Counter: ${inheritedWidget?.counter}'),
    );
  }
}
```

### 4. Limitations of InheritedWidget
While InheritedWidget is powerful, it has some limitations:

- `Manual Updates`: You need to manually update the state and ensure the widget tree rebuilds appropriately.
- `Boilerplate Code`: Implementing InheritedWidget involves boilerplate code, which can be cumbersome for larger applications.