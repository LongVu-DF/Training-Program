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
