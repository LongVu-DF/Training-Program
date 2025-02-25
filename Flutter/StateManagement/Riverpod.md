# Riverpod
The Riverpod documentation defines a Provider as an object that encapsulates a piece of state and allows listening to that state.

With Riverpod, providers are the core of everything:

- They completely replace design patterns such as `singletons`, `service locators`, `dependency injection`, and `InheritedWidgets`.
- They allow you to store some state and easily access it in multiple locations.
- They allow you to optimize performance by filtering widget rebuilds or caching expensive state computations.
- They make your code more testable, since each provider can be overridden to behave differently during a test.

### Creating and Reading a Provider
```
// provider that returns a string value
final helloWorldProvider = Provider<String>((ref) {
  return 'Hello world';
});
```
This is made of three things:

- **The declaration**: `final helloWorldProvider` is the global variable that we will use to read the state of the provider
- **The provider**: `Provider<String>` tells us what kind of provider we're using (more on this below), and the type of the state it holds.
- **A function** that creates the state. This gives us a `ref` parameter that we can use to read other providers, perform some custom dispose logic, and more.

#### Once we have a provider, how do we use it inside a widget?
All Flutter widgets have a `BuildContext` object that we can use to access things **inside the widget tree** (such as `Theme.of(context)`).

But Riverpod providers live `outside the widget tree` and to read them we need an additional ref object. Here are three different ways of obtaining it.

### 1. Using a ConsumerWidget
The simplest way is to use a `ConsumerWidget`:
```
final helloWorldProvider = Provider<String>((_) => 'Hello world');

// 1. widget class now extends [ConsumerWidget]
class HelloWorldWidget extends ConsumerWidget {
  @override
  // 2. build method has an extra [WidgetRef] argument
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. use ref.watch() to get the value of the provider
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(helloWorld);
  }
}
```
By subclassing `ConsumerWidget` instead of `StatelessWidget`, our widget's `build` method gets an extra ref object (of type `WidgetRef`) that we can use to watch our provider.

Using `ConsumerWidget` is the most common option and the one you should choose most of the time.

### 2. Using a Consumer
As an alternative, we can wrap our `Text` widget with a `Consumer`:
```
final helloWorldProvider = Provider<String>((_) => 'Hello world');

class HelloWorldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Add a Consumer
    return Consumer(
      // 2. specify the builder and obtain a WidgetRef
      builder: (_, WidgetRef ref, __) {
        // 3. use ref.watch() to get the value of the provider
        final helloWorld = ref.watch(helloWorldProvider);
        return Text(helloWorld);
      },
    );
  }
}
```
In this case, the "ref" object is one of the `Consumer`'s builder arguments, and we can use it to watch the value of the provider.

This works, but it's more verbose than the previous solution.

So when should we use a `Consumer` over a `ConsumerWidget`?
Here is one example:
```
final helloWorldProvider = Provider<String>((_) => 'Hello world');

class HelloWorldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // 1. Add a Consumer
      body: Consumer(
        // 2. specify the builder and obtain a WidgetRef
        builder: (_, WidgetRef ref, __) {
          // 3. use ref.watch() to get the value of the provider
          final helloWorld = ref.watch(helloWorldProvider);
          return Text(helloWorld);
        },
      ),
    );
  }
}
```
In this case, we're wrapping only the `Text` with a `Consumer` widget, but not the parent `Scaffold`:
```
Scaffold
├─ AppBar
└─ Consumer
    └─ Text
```
As a result, only the `Text` will rebuild if the provider value changes (more on this below).

This may seem like a small detail, but if you have a big widget class with a complex layout, you can use `Consumer` to rebuild only the widgets that depend on the provider.

### 3. Using ConsumerStatefullWidget & ConsumerState
`ConsumerWidget` is a good replacement for `StatelessWidget` and gives us a convenient way of accessing providers with minimal code.

But what if we have a `StatefulWidget` instead?

Here's the same hello world example:
```
final helloWorldProvider = Provider<String>((_) => 'Hello world');

// 1. extend [ConsumerStatefulWidget]
class HelloWorldWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<HelloWorldWidget> createState() => _HelloWorldWidgetState();
}

// 2. extend [ConsumerState]
class _HelloWorldWidgetState extends ConsumerState<HelloWorldWidget> {
  @override
  void initState() {
    super.initState();
    // 3. if needed, we can read the provider inside initState
    final helloWorld = ref.read(helloWorldProvider);
    print(helloWorld); // "Hello world"
  }

  @override
  Widget build(BuildContext context) {
    // 4. use ref.watch() to get the value of the provider
    final helloWorld = ref.watch(helloWorldProvider);
    return Text(helloWorld);
  }
}
```
By subclassing from `ConsumerStatefulWidget` and `ConsumerState`, we can call `ref.watch()` in the `build` method just like we have done before.

>When we subclass from `ConsumerState`, we can access the `ref` object inside all the widget lifecycle methods. This is because `ConsumerState` declares `WidgetRef` as a property, much like the Flutter State class declares `BuildContext` as a property that can be accessed directly inside all the widget lifecycle methods.

>If you use the hooks_riverpod package, you can also use `HookConsumerWidget` and `StatefulHookConsumerWidget`. The official documentation covers these widgets in more detail.

### What is a WidgetRef
As we have seen, we can watch a provider's value by using a `ref` object of type `WidgetRef`. This is available as an argument when we use `Consumer` or `ConsumerWidget`, and as a property when we subclass from `ConsumerState`.

The Riverpod documentation defines `WidgetRef` as an object that allows widgets to interact with providers.

Note that there are some similarities between `BuildContext` and `WidgetRef`:

- `BuildContext` lets us access ancestor widgets in the widget tree (such as `Theme.of(context)` and `MediaQuery.of(context)`)
- `WidgetRef` lets us access any provider inside our app

In other words, `WidgetRef` lets us access any provider in our codebase (as long as we import the corresponding file). This is by design because all Riverpod providers are global.

### Eight different kinds of providers
So far, we have learned how to create a simple `Provider` and watch it inside a widget using a `ref` object.

But Riverpod offers eight different kinds of providers, all suited for separate use cases:

- `Provider`
- `StateProvider` (legacy)
- `StateNotifierProvider` (legacy)
- `FutureProvider`
- `StreamProvider`
- `ChangeNotifierProvider` (legacy)
- `NotifierProvider` (new in Riverpod 2.0)
- `AsyncNotifierProvider` (new in Riverpod 2.0)