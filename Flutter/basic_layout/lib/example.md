```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  /*
   This is StatelessWidget but still have `build` method.
   But it only build when app start or re-build when hot restart, .. or when parent class change (call to change).
   And because this don't have `state`, so it will build a new instance Widget (not re-build UI)
   Because StatelessWidget is an Abstract class, so we need to override `Widget build()` to create new Widget (same with Statefull).
   */
  @override
  Widget build(BuildContext context) {
    /*
      `Build()` is a method of StatelessWidget and StatefullWidget, call when build/re-build an UI.
      `BuildContext context` is a parameter, helps Flutter find parent and child widget in the tree structure.

    */
    return MaterialApp(
      /*
        `Material Design` is a design system build and supported by Google designer and developers. 
        Material.io includes in-depth UX guidance and UI component implementations for Android, Flutter, and Web.
        And Flutter support for `Material Design` with `material.dart`. `MaterialApp()` is one component in that library.

        `MaterialApp()` is an application build upon a `WidgetsApp` by adding `Material Design`. And it wraps a number of widgets
        that are commonly required for `Material Design` applications(home, build ...).
      */
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ).copyWith(surface: Colors.grey[850]!),
        /* This is new way to use `ColorScheme` to match with `Material 3 Design spec`
        read more at (https://docs.flutter.dev/release/breaking-changes/material-3-migration)
        */
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  /*
  `key` is a types used to identify widget and allows Flutter know when a widget change.
  super.key (here is null key) will automatically gets key and give for parent (StatefullWidget).
  
  Another way: const MyHomePage({required this.title, Key? key}) : super(key: key);
  but in this way we can chose what key to give. 
  It have 3 types key:
  -GlobalKey: allows developers to access the data of one widget inside another in application.
  -ValueKey: stores the alphanumeric value of the widget.
  -ObjectKey: stores complex objects in which multiple object have the same values, such as date of birth or name.
  It usually would be a custom class.
  -UniqueKey: stores every widget state as unique. It is easy to identify them when we need to recall them.
*/

  /*
  This widget is the home page of your application. It is stateful, meaning
  that it has a State object (defined below) that contains fields that affect
  how it looks.
  */

  /*
  This class is the configuration for the state. It holds the values (in this
  case the title) provided by the parent (in this case the App widget) and
  used by the build method of the State. Fields in a Widget subclass are
  always marked "final".
  */
  final String title;
  /*
    To create `state` need to override createState().
    State<MyHomePage>: Class State with MyHomePage - the widget want to create state.
    createState(): is a `method` return an instance of State<>.
    _MyHomePageState(): is a constructor, called when Flutter create new instance of _MyHomePageState.
  */
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      /*
      This call to setState tells the Flutter framework that something has
      changed in this State, which causes it to rerun the build method below
      so that the display can reflect the updated values. If we changed
      _counter without calling setState(), then the build method would not be
      called again, and so nothing would appear to happen.
      */
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
    This method is rerun every time setState is called, for instance as done
    by the _incrementCounter method above.
    
    The Flutter framework has been optimized to make rerunning build methods
    fast, so that you can just rebuild anything that needs updating rather
    than having to individually change instances of widgets.
    */
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            _counter % 2 == 0
                ? Theme.of(context).colorScheme.inversePrimary
                : Colors.amber,
        /*
          Theme.of(context) will take the nearest widget `ThemeData` throgh Buildcontext.
          Then access to colorScheme to take theme color.
        */
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
```