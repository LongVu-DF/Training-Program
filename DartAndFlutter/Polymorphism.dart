// Abstract class Vehicle used abstract class to have abstract method, and force supclass overide method
abstract class Vehicle {
  String name;

  Vehicle(this.name);

  // abstract method, need overide
  void move();

  // normal method
  void stop() {
    print('$name is stopping.');
  }
}

// Car extend Vehicle
class Car extends Vehicle {
  Car(String name) : super(name);

  @override
  void move() {
    print('$name is driving on the road.');
  }
}

// Bicycle extend Vehicle
class Bicycle extends Vehicle {
  Bicycle(String name) : super(name);

  @override
  void move() {
    print('$name is pedaling on the street.');
  }
}

// Truck extend Vehicle
class Truck extends Vehicle {
  Truck(String name) : super(name);

  @override
  void move() {
    print('$name is transporting goods.');
  }
}

void main() {
  // List contain many vehicles
  List<Vehicle> vehicles = [
    Car("Toyota"),
    Bicycle("Mountain Bike"),
    Truck("Big Truck"),
  ];

  // Call move() in each supclass
  for (var vehicle in vehicles) {
    vehicle
        .move(); // Polymorphism: call the correct move() method of each subclass
    vehicle.stop(); // common method, don't need overide to use
  }
// Output
// Toyota is driving on the road.
// Toyota is stopping.
// Mountain Bike is pedaling on the street.
// Mountain Bike is stopping.
// Big Truck is transporting goods.
// Big Truck is stopping.
}
