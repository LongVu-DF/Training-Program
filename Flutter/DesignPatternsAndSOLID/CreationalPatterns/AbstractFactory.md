# Abstract Factory

### 1. Problem
Imagine that you’re creating a furniture shop simulator. Your code consists of classes that represent:

- A family of related products, say: `Chair` + `Sofa` + `CoffeeTable`.

- Several variants of this family. For example, products `Chair` + `Sofa` + `CoffeeTable` are available in these variants: `Modern`, `Victorian`, `ArtDeco`.
![](https://refactoring.guru/images/patterns/diagrams/abstract-factory/problem-en-2x.png)
You need a way to create individual furniture objects so that they match other objects of the same family. Customers get quite mad when they receive non-matching furniture.
![](https://refactoring.guru/images/patterns/content/abstract-factory/abstract-factory-comic-1-en-2x.png)
Also, you don’t want to change existing code when adding new products or families of products to the program. Furniture vendors update their catalogs very often, and you wouldn’t want to change the core code each time it happens.

### 2. Solution
The first thing the Abstract Factory pattern suggests is to explicitly declare interfaces for each distinct product of the product family (e.g., chair, sofa or coffee table). Then you can make all variants of products follow those interfaces. For example, all chair variants can implement the `Chair` interface; all coffee table variants can implement the `CoffeeTable` interface, and so on.
![](https://refactoring.guru/images/patterns/diagrams/abstract-factory/solution1-2x.png)
The next move is to declare the *Abstract Factory*—an interface with a list of creation methods for all products that are part of the product family (for example, `createChair`, `createSofa` and `createCoffeeTable`). These methods must return **abstract** product types represented by the interfaces we extracted previously: `Chair`, `Sofa`, `CoffeeTable` and so on.
![](https://refactoring.guru/images/patterns/diagrams/abstract-factory/solution2-2x.png)
Now, how about the product variants? For each variant of a product family, we create a separate factory class based on the `AbstractFactory` interface. A factory is a class that returns products of a particular kind. For example, the `ModernFurnitureFactory` can only create `ModernChair`, `ModernSofa` and `ModernCoffeeTable` objects.

The client code has to work with both factories and products via their respective abstract interfaces. This lets you change the type of a factory that you pass to the client code, as well as the product variant that the client code receives, without breaking the actual client code.
![](https://refactoring.guru/images/patterns/content/abstract-factory/abstract-factory-comic-2-en-2x.png)
Say the client wants a factory to produce a chair. The client doesn’t have to be aware of the factory’s class, nor does it matter what kind of chair it gets. Whether it’s a Modern model or a Victorian-style chair, the client must treat all chairs in the same manner, using the abstract `Chair` interface. With this approach, the only thing that the client knows about the chair is that it implements the `sitOn` method in some way. Also, whichever variant of the chair is returned, it’ll always match the type of sofa or coffee table produced by the same factory object.

There’s one more thing left to clarify: if the client is only exposed to the abstract interfaces, what creates the actual factory objects? Usually, the application creates a concrete factory object at the initialization stage. Just before that, the app must select the factory type depending on the configuration or the environment settings.

### 3. Structure
![](https://refactoring.guru/images/patterns/diagrams/abstract-factory/structure-2x.png)
- **Abstract Products:** declare interfaces for a set of distinct but related products which make up a product family.
- **Concrete Products:** are various implementations of abstract products, grouped by variants. Each abstract product (chair/sofa) must be implemented in all given variants (Victorian/Modern).
- The **Abstract Factory** interface declares a set of methods for creating each of the abstract products.
- **Concrete Factories** implement creation methods of the abstract factory. Each concrete factory corresponds to a specific variant of products and creates only those product variants.
- Although concrete factories instantiate concrete products, signatures of their creation methods must return corresponding abstract products. This way the client code that uses a factory doesn’t get coupled to the specific variant of the product it gets from a factory. The **Client** can work with any concrete factory/product variant, as long as it communicates with their objects via abstract interfaces.

### 4. Example
**Step 1: Create an Abstract Class Product(interface for other subclass)**

Create interface for product car and motorbike. 
```
// Abstract class for car
abstract class Car {
  void renderCar();
}

// Abstract class for motorbike
abstract class Motorbike {
  void renderMotorbike();
}
```

**Step 2: create Concrete Product**
```
// 🔹 gas vehical
class GasCar implements Car {
  @override
  void render() {
    print("Gas car created!");
  }
}

class GasMotorbike implements Motorbike {
  @override
  void render() {
    print("Gas Motorbike created!");
  }
}

// 🔹 Electric vehical
class ElectricCar implements Car{
  void render() {
    print("Electric car created!");
  }
}

class ElectricMotorbike implements Motorbike  {
  @override
  void render() {
    print("Electric Motorbike created!");
  }
}
```

**Step 3: Create Abstract Factory**

```
// Abstract Factory (declare set of method for creating each of the abstract product (car/motorbike) )
abstract class VehicalFactory {
  Car createCar();
  Motorbike createMotorbike();
}
```
This `VehicalFactory` contain `Factory Method` to create `car` `motorbike` object.

**Step 4: Create Concrete Factory**

```
// 🏭 Factory for gas Vehical
class GasVehicalFactory implements VehicalFactory {
  @override
  Car createCar() => GasCar();

  @override
  Motorbike createMotorbike() => GasMotorbike();
}

// 🏭 Factory for electric Vehical
class LightThemeFactory implements UIComponentFactory {
  @override
  Car createCar() => ElectricCar();

  @override
  Motorbike createMotorbike() => ElectricMotorbike();
}
```

**Run and Result**

```
void main() {
  // User use gas Vehical
  VehicalFactory factory = GasFactory();

  // Create vehical from Factory
  Car car = factory.createCar();
  Motorbike motorbike = factory.createMotorbike();

  // show type vehical
  car.render();  // gas car created!
  motorbike.render(); // gas motorbike created!
}
```