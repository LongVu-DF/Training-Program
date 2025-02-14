# Dart Basic Document


## 1. Variable
```
var name = 'Voyager I';
var year = 1977;
var antennaDiameter = 3.7;
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
var image = {
  'tags': ['saturn'],
  'url': '//path/to/saturn.jpg'
};
```
-  `var` keyword, which allows Dart to infer the type based on the initial value.
- Dart also have default values (int, string, float, ...), `final` and `const` keywords, and static types.  
[Read more](https://dart.dev/language/variables)

## 2. Control flow statements

Dart supports the usual control flow statements:
```
if (year >= 2001) {
  print('21st century');
} else if (year >= 1901) {
  print('20th century');
}

for (final object in flybyObjects) {
  print(object);
}

for (int month = 1; month <= 12; month++) {
  print(month);
}

while (year < 2016) {
  year += 1;
}
```
- Read more about [loops](https://dart.dev/language/loops), including `break` and `continue` 
- Read more about [Branches](https://dart.dev/language/branches), including `switch` and `case`

### Handling errors
#### Exceptions
We can throw, catch  or handle exceptions (exceptions are errors indicating that something unexpected happened).  
If the exception isn't caugth, the [isolate](https://dart.dev/language/concurrency#isolates) that raised the exception
is suspended, and typically the isolate and it program are terminated.
Dart provides Exception and Error types, as well as numerous predefined subtypes. You can, of course, define your own exceptions (**_by extend from Exception(), remember throw() error_**). However, Dart programs can throw any non-null object—not just Exception and Error objects—as an exception.
#### Throw
```
throw FormatException('Expected at least 1 section');
throw 'Out of llamas!';
```
or `throw` exceptions in sorthand statements (=>)
```
void distanceTo(Point other) => throw UnimplementedError();
```

#### Try & Catch
`Catching` an exception gives a chance to handle it and stops the exception from propagating (break app ....)  
To handle more than one type of exception, can specify multiple `catch` clauses. Can use either `on` or `catch` or both.
Use `on` when need to specify the exception type. Use `catch` when exception handler needs the exception object.
```
try {
  breedMoreLlamas();
} on OutOfLlamasException {
  // A specific exception
  buyMoreLlamas();
} on Exception catch (e) {
  // Anything else that is an exception
  print('Unknown exception: $e');
} catch (e) {
  // No specified type, handles all
  print('Something really unknown: $e');
}
```

Can specific one or two parameters to `catch()` (like catch(a,b)).
 The first is the exception that was thrown, and the second is the stack trace (a [StackTrace](https://api.dart.dev/dart-core/StackTrace-class.html) object).
```
try {
  // ···
} on Exception catch (e) {
  print('Exception details:\n $e');
} catch (e, s) {
  print('Exception details:\n $e');
  print('Stack trace:\n $s');
}
```
To partially handle an exception, while allowing it to propagate, use the `rethrow` keyword.
Rethrow keep the original error and do not lose the stack trace.
```
void misbehave() {
  try {
    dynamic foo = true;
    print(foo++); // Runtime error -> exception came from this
  } catch (e) {
    print('misbehave() partially handled ${e.runtimeType}.');
    // partially handle an exception (can use to create logs error).
    rethrow; // Allow callers to see the exception.
  }
}

void main() {
  try {
    misbehave();
  } catch (e) {
    print('main() finished handling ${e.runtimeType}.');
  }
}
```
To ensure that some code runs whether or not an exception is thrown, use a finally clause.
If no `catch` clause matches the exception is propagated after the `finally` clauses runs:
```
try {
  breedMoreLlamas();
} catch (e) {
  print('Error: $e'); // Handle the exception first. If dont have catch, finally still running.
} finally {
  cleanLlamaStalls(); // Then clean up.
}
```
During development (debug mode), use an assert statement— assert(condition, optionalMessage); —to disrupt normal execution if a boolean condition is false.
```
void main() {
  int age = 16;
  assert(age >= 18, 'Age need to be equal or more than 18!'); // if condition in assert true, print optionalMessage then interupt program.
  print('Age valid');
}
```

## 3. Functions
### Named parameters
Named parameters are optional unless they're explicity marked as `required`.  
When defining a function, use {param1, param2, ...} to specify named parameters.
 If you don't provide a default value or mark a named parameters as `required`,
 their types must be nullable as their default value will be `null`.
 ```
 /// Sets the [bold] and [hidden] flags ...
void enableFlags({bool? bold, bool? hidden}) {...}
```
When calling a functin, you can specify named arguments using `param1: value, param2 ...`. Exp:

```
enableFlags(bold: true, hidden: false); // can switch 2 param posistion.
```
To define a default value for a named parameters besides `null`, use `=` to specify a default value.
The specified value must be a compile-time constant. Exp:
```
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}

// bold will be true; hidden will be false.
```
Use `required` to requiring calllers to provide a value for the parameters.
```
const Scrollbar({super.key, required Widget child}); // A parameter marked as required can still be nullable if put `?` behind `Widget` (or any kind Variable...)
```
### Optional positional parameters
Wrapping a set of function parameters in [ ] marks them as optional positional parameters. 
If don't provide a default value, their types must be nullable as their default value will be null. 
Or use `=` to specific a default value.
```
String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}
```
### Functions as first-class objects
You can pass a function as a parameter to another function or Variable.
```
void printElement(int element) {
  print(element);
}

var list = [1, 2, 3];

// Pass printElement(function) as a parameter.
list.forEach(printElement);



// Pass loudify(function) as a variable inside anonymous function
var loudify = (msg) => '!!! ${msg.toUpperCase()} !!!';
assert(loudify('hello') == '!!! HELLO !!!');
```
### Generators
When need to lazily produce a sequence of values, consider using a generator function.Dart has built-in support for two kinds of generator functions:
 - **Synchronous** generator: Returns an [Iterable](https://api.dart.dev/dart-core/Iterable-class.html) object.
 - **Asynchronous** generator: Returns a [Stream](https://api.dart.dev/dart-async/Stream-class.html) object.

To implement a **synchronous** generator function, mark the function body as `sync*`, and use `yield` statements to deliver values:
 ```
 Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
```

To implement an **asynchronous** generator function, mark the function body as `async*`, and use `yield` statements to deliver values:
```
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```
If generator is recursive, you can improve its performance by using `yield*`:
```
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```

## 4. Classes (blueprint) & Object (instance of class)
### Object
Object is an instance of a class.
Object can contain properties and methods.
Everything in Dart is an Object.


### Class variables and methods
Use the `static` keyword to implement class-wide variables and methods.
#### Static variabes
Static variables (class variables) are useful for class-wide state and constants:
```
class Counter {
  static int count = 0; // this static variable belong to class, not each object

  Counter() {
    count++; // increse each time create new object(instance)
  }
}

void main() {
  print(Counter.count); // ✅ Output: 0

  var a = Counter(); 
  print(Counter.count); // ✅ Output: 1

  var b = Counter();
  print(Counter.count); // ✅ Output: 2

  var c = Counter();
  print(Counter.count); // ✅ Output: 3
}
```
- `static` variables aren't initialized until they're used.
- `static` variables belong to `class` not `object`

#### Static methods
`Static` methods (class methods) don't operate on an instance (object), and thus don't have access to `this`. They do, however, have access to static variables. As the following example shows, you invoke static methods directly on a class.
```
class MathUtils {
  static double square(double num) {
    return num * num;
  }
}

void main() {
  print(MathUtils.square(4)); // ✅ Output: 16.0
}
---------------------------------------------------------
class Test {
  int x = 10;

  static void show() {
    print(this.x); // ❌ Error: Static method can't use `this`
  }
}
```

More example about static variable and static method
```
class Counter {
  static int count = 0;// this static variable belong to class, not each object
   int v;
  
 static Counter shared = Counter(1000);
 // Create a new object when program compiled
 // so when we create "c" at main, program have 2 object that why 'count' = 2,
 // Can use static variable inside instance method, but can't use instance variable inside a static method
  int sum(){
     print("call sum: $count");
    return count+v;
  }
  // if add 'static' before int sum, can't use variable 'v' (an instance variable)
  Counter(this.v){
    print("call constructor: $count");
    count++;
  }
}
void main() {
  var c = Counter(3);
  print("value: ${c.v} sum: ${Counter.shared.sum()} count:  ${Counter.count}"); 
  // Output:
  // call constructor: 0
  // call constructor: 1
  // call sum: 2
  // value: 3 sum: 1002 count:  2
}
```
## Enums
Dart also allows enum declara tions to declare classes with fields, methods, and const constructors which are limited to a fixed number of known constant instances.
To declare ab enhanced enum, follow a syntax similar to normal `classes`, but with a few extra requirements:
- Instance variables must be `final`, including those added by `mixins`.
- All generative constructors must be constant.
- Factory constructors can only return one of the fixed, known enum instances.
- No other class can be extended as `Enum` is automatically extended.
- There cannot be overrides for `index`, `hashCode`, the equality operator `==`.
- A member named `values` cannot be declared in an enum, as it would conflict with the automatically generated static `values` getter.
- All instances of the enum must be declared in the beginning of the declaration, and there must be at least one instance declared.
Instance methods in an enhanced enum can use `this` to reference the current enum value.
```
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonFootprint - other.carbonFootprint;
}
```

## Extension (different with extends)
- `Extension` helps to extend an existing class without creating `subclass` (`extend` will create a new subclass from a superclass).
- Cannot override existing `methods`, only new `methods` can be added.
- Cannot access `private` properties of the original class.
- A `class` can have multiple `extensions`
```
extension Stringx on String {
  String uppercaseFirst(){
    return this.replaceFirst(this[0],this[0].toUpperCase());
  }
}
/// Stringx is new extension of String class (base class of dart)   
/// includes new method uppercaseFirst() but not change any existing method inside String.
void main(){
  print("long".uppercaseFirst());
}
```

## Async
Dart have the `async` and `await` keywords support asynchronous programming, letting we write `asynchronous` code that looks similar to `synchronous` code.

### Handling Futures
When need the results of a completed `Future`, you have 2 options:
- Use `async` and `await`. Read more in [asynchronous programming tutorial](https://dart.dev/libraries/async/async-await).
- Use the `Future` API, as described in the [`dart:async` documentation](https://dart.dev/libraries/dart-async#future).

Code that used `async` and `await` is `asynchronous`, but it looks a lot like `synchronous` code. For example, here's some code that uses `await` to wait for the result of an `asynchronous` function:
To use `await`, code must be in an `async` function - a fucntion marked as `async`
```
Future<void> checkVersion() async {
  var version = await lookUpVersion();
  // Do something with version
}
```
Use `try`, `catch` and `finally` to handle errors and cleanup in code that uses `await`:
```
try {
  version = await lookUpVersion();
} catch (e) {
  // React to inability to look up the version
}
```
You can use `await` multiple times in an `async` function.
```
var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);
```
Or use Future's `then()` method to execute three `asynchronous` function in a row, waiting for each one to complate before execute the next one.
```
void runUsingFuture() {
  // ...
  findEntryPoint()
      .then((entryPoint) {
        return runExecutable(entryPoint, args);
      })
      .then(flushThenExit);
}
```

If functions return some value, make its return type `Future<Type>`
```
Future<String> lookUpVersion() async => '1.0.0';
```
An example about using `async`, `await`, `future`, and `then`
```
//String createOrderMessage() {
//   var order = fetchUserOrder();
//   return 'Your order is: $order';
// }

// Future<String> fetchUserOrder() =>
// // Imagine that this function is more complex and slow.
// Future.delayed(const Duration(seconds: 2), () => 'Large Latte');

// void main() {
//   print(createOrderMessage());
//   // Output: Your order is: Instance of '_Future<String>'
// }
/* Code above print wrong because the createOrderMessage() dont wait for the fetchUserOrder() return value
 Can change the createOrderMessage() to asynchronous, and use then() in main (if don't use then() can change main with async await)
*/


Future<String> createOrderMessage()async{
  // Use Future<String> to get string value returned.
  // Use async and await keyword for asynchronous.
  var order = await fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> fetchUserOrder() =>
// Imagine that this function is more complex and slow.
Future.delayed(const Duration(seconds: 2), () => 'Large Latte');

void main() {
  createOrderMessage().then((v){
    print(v); // Output: Your order is: Large Latte
  });
}
```

The `then().catchError()` pattern is the `asynchronous` version of `try`-`catch`.

```
httpClient
    .read(url)
    .then((String result) {

      // when httpClient (future) complate and the promised string value is available
      print(result);
    })
    .catchError((e) {
      // run when Future throw an exceptions or errors
      // Handle or ignore the error.
    });
```
Be sure to invoke `catchError()` on the result of `then()`- not on the result of the original `Future`(httpClient). Otherwise, the `catchError()` can handle errors only from the original Future's computation, but not from the handle registered by `then()`.

### Waiting for multiple futures
Sometimes algorithm needs to invoke many `asynchronous` functions and wait for them all to complete before continuing. Use the `Future.wait()` static method to manage multiple Futures an wait for them to complete:
```
Future<void> deleteLotsOfFiles() async =>  ...
Future<void> copyLotsOfFiles() async =>  ...
Future<void> checksumLotsOfOtherFiles() async =>  ...

await Future.wait([
  deleteLotsOfFiles(),
  copyLotsOfFiles(),
  checksumLotsOfOtherFiles(),
]);
print('Done with all the long steps!');
```

`Future.wait()` returns a future which completes once all the provided futures have completed. It completes either with their results, or with an error if any of the provide futures fail.
### Handling errors for multiple futures
You can also wait for parallel operations on an `iterable` or `record` of futures.
These extensions return a future with the resulting values of all provided futures. Unlike `Future.wait`, they also let you handle errors.
If any future in the collection completes with an error, wait completes with a `ParalleWaitError`. This allows the caller to handle individual errors and dispose successful results if nescessary.

When _don't_ need the result values from each individual future, use `wait` on an _iterable_ of futures:
``` 
void main() async {
  Future<void> delete() async =>  ...
  Future<void> copy() async =>  ...
  Future<void> errorResult() async =>  ...
  
  try {
    // Wait for each future in a list, returns a list of futures:
    var results = await [delete(), copy(), errorResult()].wait;

    } on ParallelWaitError<List<bool?>, List<AsyncError?>> catch (e) {

    print(e.values[0]);    // Prints successful future
    print(e.values[1]);    // Prints successful future
    print(e.values[2]);    // Prints null when the result is an error

    print(e.errors[0]);    // Prints null when the result is successful
    print(e.errors[1]);    // Prints null when the result is successful
    print(e.errors[2]);    // Prints error
  }

}
```

When _do_ need the individual result values from each future, use `wait` on a _record_ of futures. This provides the additional benefit that the futures can be of different types:
```
void main() async {
  Future<int> delete() async =>  ...
  Future<String> copy() async =>  ...
  Future<bool> errorResult() async =>  ...

  try {    
    // Wait for each future in a record, returns a record of futures:
    (int, String, bool) result = await (delete(), copy(), errorResult()).wait;
  
  } on ParallelWaitError<(int?, String?, bool?),
      (AsyncError?, AsyncError?, AsyncError?)> catch (e) {
    // ...
    }

  // Do something with the results:
  var deleteInt  = result.$1;
  var copyString = result.$2;
  var errorBool  = result.$3;
}
```
### Handling Streams
When need to get values from a `Stream`, have 2 options:
- Use `async` and an `asynchronous` for loop (`await for`).
- Use the `Stream` API, as described in the [`dart:async` documentation](https://dart.dev/libraries/dart-async#stream).

An `asynchronous` for loop has the following form:
```
await for (varOrType identifier in expression) {
  // Executes each time the stream emits a value.
}
```
The value of `expression` must have type `Stream`. Execution prodcess as follows:  
  1. Wait until the stream emits a value.
  2. Execute the body for the `for loop`, with the variable set to that emitted value.
  3. Repeat 1 and 2 until the `Stream` is closed.

To stop lisstening to stream, can use `break` or `return` statement, which breaks out of the `for loop` and unsubcribers from the stream.
Consider the following function. It uses Stream's `listen()` method to subcribe to a list of files, passing in a function literal that searches each file or directory.
```
void main(List<String> arguments) {
  // ...
  FileSystemEntity.isDirectory(searchPath).then((isDir) {
    if (isDir) {
      final startingDir = Directory(searchPath);
      startingDir.list().listen((entity) {
        if (entity is File) {
          searchFile(entity, searchTerms);
        }
      });
    } else {
      searchFile(File(searchPath), searchTerms);
    }
  });
}
```
The equivalent code with `await` expressions, including an asynchronous for loop (`await for`), looks more like synchronous code:
```
void main(List<String> arguments) async {
  // ...
  if (await FileSystemEntity.isDirectory(searchPath)) {
    final startingDir = Directory(searchPath);
    await for (final entity in startingDir.list()) {
      if (entity is File) {
        searchFile(entity, searchTerms);
      }
    }
  } else {
    searchFile(File(searchPath), searchTerms);
  }
}
```
Before using `await for`, make sure that it makes the code clearer and that you really do want to wait for all of the stream's results. For example, you usually should **not** use `await for` for DOM event listeners, because the DOM sends endless streams of events. If you use `await for` to register two DOM event listenners in a row, then the second kind of event is never handled.
#### Listening for stream data
To get each values as it arrives, either use `await for` or subscribe to the stream using the `listen()` method:
```
// Add an event handler to a button.
submitButton.onClick.listen((e) {
  // When the button is clicked, it runs this code.
  submitData();
});
```
In this example, the `onClick` property is a `Stream` object provided by the submit button.
If you care about only one event, you can get it using a property such as `first`, `last`, or `single`. To test the event before handling it, use a method such as `firstWhere()`, `lastWhere()`, or `singleWhere()`.
If you care about subset of events, you can use methods such as `skip()`, `skipwhere()`, `take()`, `takeWhile()`, and `where()`.
#### Transforming stream data
Often, you need to change the format of a stream's data before you can use it. Use the `transform()` method to prduce a stream with a different type of data:
```
var lines = inputStream
    .transform(utf8.decoder)
    .transform(const LineSplitter());
```
This example uses two `transformers`. First it uses `utf8.decode` to transform the stream of `intergers` into a stream of `strings`. Then it uses a `LineSplitter` to transform the stream of `strings` into a stream of separate lines. These transformers are from the [`dart:convert`](https://dart.dev/libraries/dart-convert) library.

#### Handling errors and completion
How you specify error and completion handling code depends on whether you use an asynchronous for loop (`await for`) or the Stream API.
If you use an asynchronous for loop, then use try-catch to handle errors. Code that executes after the stream is closed goes after the asynchronous for loop.
```
Future<void> readFileAwaitFor() async {
  var config = File('config.txt');
  Stream<List<int>> inputStream = config.openRead();

  var lines = inputStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());
  try {
    await for (final line in lines) {
      print('Got ${line.length} characters from stream');
    }
    print('file is now closed');
  } catch (e) {
    print(e);
  }
}
```
If you use the Stream API, then handle errors by registering an `onError` listener. Run code after the stream is closed by rigistering an `onDone` listener.
```
var config = File('config.txt');
Stream<List<int>> inputStream = config.openRead();

inputStream
    .transform(utf8.decoder)
    .transform(const LineSplitter())
    .listen(
      (String line) {
        print('Got ${line.length} characters from stream');
      },
      onDone: () {
        print('file is now closed');
      },
      onError: (e) {
        print(e);
      },
    );
```
