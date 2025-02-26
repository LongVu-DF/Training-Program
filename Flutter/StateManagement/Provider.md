# Provider
The provider package is an easy to use package which is basically a wrapper around the InheritedWidgets that makes it easier to use and manage. It provides a state management technique that is used for managing a piece of data around the app.

The basic classes available in the provider package are –
- **`ChangeNotifierProvider<T extends ChangeNotifier>`** It listens to a ChangeNotifier extended by the model class, exposes it to its children and descendants, and rebuilds depends whenever notifyListeners is called.
```
ChangeNotifierProvider(
  create: (context) => DataModel(),
  child: ...
)
```
- **`Consumer<T>`** It obtains the provider from its ancestors and passes the value obtained to the builder.
```
@override
 Widget build(BuildContext context) {
   return Consumer<DataModel>(
     builder: (context, data, child) => DataWidget(par1: par1, par2: par2),
     child: Text(data.first),
   );
 }
 ```
 - **`FutureProvider<T>`** This class listens for a Future and then passes its values to its children and descendants.
 ```
 Constructors
FutureProvider<T>(
    {Key key,
    @required Create<Future<T>> create,
    T initialData,
    ErrorBuilder<T> catchError,
    UpdateShouldNotify<T> updateShouldNotify,
    bool lazy,
    TransitionBuilder builder,
    Widget child}
)
This creates a Future from create and subscribes to it.

FutureProvider.value(
    {Key key, 
    @required Future<T> value, 
    T initialData, 
    ErrorBuilder<T> catchError, 
    UpdateShouldNotify<T> updateShouldNotify, 
    TransitionBuilder builder, 
    Widget child}
    )
This constructor notifies the changed values to the FutureProvider children.

Ex: FutureProvider<Model>(create: (context) =>
 Model(),)
 ```
 - **`InheritedProvider<T>`** The InheritedProvider provides a general implementation of the InheritedWidget.
 - **`MultiProvider`** A provider that is used to provide more than one class at the same time.
```
MultiProvider(
  providers: [
    Provider<Model1>(create: (context) => Model1()),
    StreamProvider<Model2>(create: (context) => Model2()),
    FutureProvider<Model3>(create: (context) => Model3()),
  ],
  child: someWidget,
)
```
- **`Provider<T>`** It is the basic provider.
- **`ProxyProvider<T, R>`** This provider depends on other providers for value. The value can be used by create or update.
```
Constructor
ProxyProvider(
    {Key key, 
    Create<R> create, 
    @required ProxyProviderBuilder<T, R> update, 
    UpdateShouldNotify<R> updateShouldNotify, 
    Dispose<R> dispose, bool lazy, 
    TransitionBuilder builder, 
    Widget child}
)
This initializes key for subclasses.
```
- **`StreamProvider<T>`** This class listens for a Stream and then passes its values to its children and descendants. This can be used as
```
Constructors
StreamProvider<T>(
    {Key key,
    @required Create<Stream<T>> create,
    T initialData,
    ErrorBuilder<T> catchError,
    UpdateShouldNotify<T> updateShouldNotify,
    bool lazy,
    TransitionBuilder builder,
    Widget child}
)
This creates a stream using create and subscribes to it.

StreamProvider.value(
    {Key key, 
    @required Stream<T> value, 
    T initialData, 
    ErrorBuilder<T> catchError, 
    UpdateShouldNotify<T> updateShouldNotify, 
    bool lazy, 
    TransitionBuilder builder, 
    Widget child}
)
This constructor notifies the changed values to the StreamProvider children.

Ex: StreamProvider<Model>(create: (context) =>
 Model(),)
 ```
 - **`ValueListenableProvider<T>`** This class receives changes in value by subscribing to a ValueListenable.
 ```
 ValueListenableProvider<T>.value(
    {Key key,
    @required ValueListenable<T> value,
    UpdateShouldNotify<T> updateShouldNotify,
    TransitionBuilder builder,
    Widget child}
)
This constructor shows the changed values to its children.
```