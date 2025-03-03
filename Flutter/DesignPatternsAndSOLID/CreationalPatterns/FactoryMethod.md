# Factory Method

**Factory Method** is a creational design pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.
![](https://refactoring.guru/images/patterns/content/factory-method/factory-method-en-2x.png)

### 1. Problem
Imagine that you’re creating a logistics management application. The first version of your app can only handle transportation by trucks, so the bulk of your code lives inside the `Truck` class.

After a while, your app becomes pretty popular. Each day you receive dozens of requests from sea transportation companies to incorporate sea logistics into the app.
![](https://refactoring.guru/images/patterns/diagrams/factory-method/problem1-en-2x.png)

Great news, right? But how about the code? At present, most of your code is coupled to the `Truck` class. Adding `Ships` into the app would require making changes to the entire codebase. Moreover, if later you decide to add another type of transportation to the app, you will probably need to make all of these changes again.

As a result, you will end up with pretty nasty code, riddled with conditionals that switch the app’s behavior depending on the class of transportation objects.

### 2. Solution
The Factory Method pattern suggests that you replace direct object construction calls (using the `new` operator) with calls to a special factory method. Don’t worry: the objects are still created via the `new` operator, but it’s being called from within the factory method. Objects returned by a factory method are often referred to as products.

![](https://refactoring.guru/images/patterns/diagrams/factory-method/solution1-2x.png)

At first glance, this change may look pointless: we just moved the constructor call from one part of the program to another. However, consider this: now you can override the factory method in a subclass and change the class of products being created by the method.

There’s a slight limitation though: subclasses may return different types of products only if these products have a common base class or interface. Also, the factory method in the base class should have its return type declared as this interface.

![](https://refactoring.guru/images/patterns/diagrams/factory-method/solution2-en-2x.png)

For example, both `Truck` and `Ship` classes should implement the `Transport` interface, which declares a method called `deliver`. Each class implements this method differently: trucks deliver cargo by land, ships deliver cargo by sea. The factory method in the `RoadLogistics` class returns truck objects, whereas the factory method in the `SeaLogistics` class returns ships.

![](https://refactoring.guru/images/patterns/diagrams/factory-method/solution3-en-2x.png)

The code that uses the factory method (often called the client code) doesn’t see a difference between the actual products returned by various subclasses. The client treats all the products as abstract `Transport`. The client knows that all transport objects are supposed to have the `deliver` method, but exactly how it works isn’t important to the client.

### 3. Structure
![](https://refactoring.guru/images/patterns/diagrams/factory-method/structure-2x.png)

- **Product:** declares the `interface`, which is common to all objects that can be produced by the creator and its subclasses.

- **Concrete Product:** are different implementations of the product `interface`.
- The **Creator** class declares the factory method that returns new product objects. It’s important that the return type of this method matches the product interface.
You can declare the factory method as abstract to force all subclasses to implement their own versions of the method. As an alternative, the base factory method can return some default product type.
- **Concrete Creators** override the base factory method so it returns a different type of product.
Note that the factory method doesn’t have to create new instances all the time. It can also return existing objects from a cache, an object pool, or another source.

### 4. Example

**Step 1: Define the `interface` for all other Products** :
```
abstract class ICar {
  void CreateVehicle();
}
```
**Step 2: Create Base Class .**   
Create Base Class have one `Factory Method` and normal method.
```
abstract class Transportor {
  ICar createCar(); // Factory Method

  String createVehicle() {
    ICar car = createCar();
    return "Transportor: The '${car.createVehicle()}' has been created";
  }
}

```
**Step 3: Create `ConcreteProduct`.**

Now, create a `ConcreteProduct` for each type of `Product` (by implement Icar)
```
class Toyota implements ICar {
  @override
  String createVehicle() {
    return "Toyota Camry";
  }
}
```
**Step 4: implement `ToyotaTransportor`.**

Implement `ToyotaTransportor` by extends `Transportor` Base Class:
```
class ToyotaTransportor extends Transportor {
  @override
  ICar createCar() {
    return Toyota();
  }
}
```
**Run and Result:**
```
void main() {
  Transportor transportor = ToyotaTransportor();
  print(transportor.createVehicle());///Transportor: The 'Toyota Camry' has been created
}

```