# Understanding the Four Pillars of OOP
## 1. Encapsulation (Đóng gói)
Encapsulation is the bunding of data and methods that operate on the data within a single unit, known as a `class`. It hides the internal state of an object from the outside world, only exposing the necessary functionalities through well-defined interfaces.

By default, members in a class are `public` (can access from every where), but can mark them as `private` using an underscore ( _ )

Encapsulation have 3 type: `member variable encapsulation`, `function encapsulation`, `class encapsulation`.

### # Member Variable Encapsulation
This type involves protecting the internal sate of an `object` by making its variables `private` and providing controlled access through public `methods`.
```
class Person {
  String _name; // Private variable, can only accessed or modified through 2 methods: get(Getter) and set(Setter)

  Person(this._name);

  // Getter(only read) for _name
  String get name => _name;

  // Setter(only write) for _name
  set name(String name) {
    if (name.isNotEmpty) {
      _name = name;
    }
  }
}

void main() {
  var person = Person('John');
  print(person.name); // Output: John
  person.name = 'Doe';
  print(person.name); // Output: Doe
}
```

### # Function Encapsulation
This type involves making some `methods` private to control how the `object`'s data is manipulated internally. Only the necessary `methods` are exposed publicly, keeping the internal implementation hidden.
```
class Calculator {
  // Public method
  int add(int a, int b) {
    return _performAddition(a, b);
  }

  // Private helper method can only access through add(public method)
  int _performAddition(int a, int b) {
    return a + b;
  }
}

void main() {
  var calc = Calculator();
  print(calc.add(2, 3)); // Output: 5
}
```

### # Class Encapsulation
This type involves bunding related `variables` and `methods` into a single `class`. This promotes modularity and reuseablility, making code more organized and easier to manage.

```
class Car {
  String _model;
  int _year;

  Car(this._model, this._year);

  // Public method to display car info
  void displayInfo() {
    print('Model: $_model, Year: $_year');
  }
}

void main() {
  var myCar = Car('Tesla', 2021);
  myCar.displayInfo(); // Output: Model: Tesla, Year: 2021
}
```
The Car class encapsulates the `_model` and `_year` `variables` along with the `displayInfo` `method`.

## 2. Abstruction (Trừu tượng)
Abstraction refers to hiding the complex implementation details of a class and showing only the essential features.

Key concepts of Abstraction:  
`Abstract class`: A `class` cannot be instantiated and is meant to be extended by other classes.  
`Abstract method`: `Methods` declared in an abstract class without body, leaving the implementation to the `subclasses`.  
`Interfaces`: Any class can serve as an `interface` in Dart, enabling `abstraction` by requiring other classes to `implement` specific method.

### # Abstract Classes
Abstract classes are classes that cannot be instantiated (or cannot create object with abstract class). They serve as blueprints for other classes, providing a common interface for subclasses while leaving the actual implementation details to them. Use `abstract` key word to define an abstract class.
```
abstract class Animal {
  void sound();  // Abstract method with no implementation

  void eat() {
    print("Animal is eating");
  }
}

// cannot creacte object with abstract class like: cat = Animal() 

class Dog extends Animal {
  @override
  void sound() {
    print("Dog barks");
  }
}

class Cat extends Animal {
  @override
  void sound() {
    print("Cat meows");
  }
}

void main() {
  var dog = Dog();
  dog.sound();  // Output: Dog barks
  dog.eat();    // Output: Animal is eating

  var cat = Cat();
  cat.sound();  // Output: Cat meows
}
``` 
- The `Animal` class is `abstract` and defines an `abstract method` - `sound()`, but it also contains a concrete `method` `eat()`. The `Dog` and `Cat` classes inherit from `Animal` and provide their own implementation for the `sound()` `method`.
- The abstract class provodes a framework for the child classes, ensuring they implement the necessary methods while sharing common functionality like `eat()`.

### # Abstract Methods
An `abstract method` is a method that is declared in an abstract class but has no body. Subclasses are required to provide an implementation for these methods. Abstract methods are used when you want to ensure that certain functionality is implemented in all subclasses but the specific implementation may vary
```
abstract class Shape {
  void calculateArea();  // Abstract method
}

class Circle extends Shape {
  double radius;

  Circle(this.radius);

  @override
  void calculateArea() {
    print("Area of Circle: ${3.14 * radius * radius}");
  }
}

class Rectangle extends Shape {
  double length, width;

  Rectangle(this.length, this.width);

  @override
  void calculateArea() {
    print("Area of Rectangle: ${length * width}");
  }
}

void main() {
  var circle = Circle(5);
  circle.calculateArea();  // Output: Area of Circle: 78.5

  var rectangle = Rectangle(4, 5);
  rectangle.calculateArea();  // Output: Area of Rectangle: 20
}
```
### # Interfaces and Abstraction
Any class can act as an `Interface`, and other classes can implement it. Unlike `abstract` classes, classes that implement an interface must provide concrete implementations for all of the `methods` declared in the interface.
```
class Printer {
  void printDocument();  // Abstract method by default
 /// void testMethod(){
 ///    print("Test)
 /// }
 /// interface can have method with body like this, but when  
 /// other classes implement need tho overide this to.  
 /// Can not use again like abstract class
}

class LaserPrinter implements Printer {
  @override
  void printDocument() {
    print("Laser Printer printing document...");
  }
}

class InkjetPrinter implements Printer {
  @override
  void printDocument() {
    print("Inkjet Printer printing document...");
  }
}

void main() {
  Printer laserPrinter = LaserPrinter();
  laserPrinter.printDocument();  // Output: Laser Printer printing document...

  Printer inkjetPrinter = InkjetPrinter();
  inkjetPrinter.printDocument();  // Output: Inkjet Printer printing document...
}
```
Here, `Printer` acts as an `interface`, and both `LaserPrinter` and `InkjetPrinter` implement the `printDocument()` method. This ensures that both printer types can be used interchangeably under the `Printer` interface while providing different implementations for the same method.

### 3. Polymorphism (Đa Hình)
Polymorphism refers to the ability of different classes to respond to the same method call in their own way. In Dart, this is achieved through method overriding and interface implementation, where a subclass can provide its specific implementation for a method defined in the supperclass.