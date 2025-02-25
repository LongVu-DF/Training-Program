/*
 * Create Abstract class Animal have:
 * method: canFly, aquatic, haveLeg
 * 
 * 
 * Create Class Dog implement Animal
 * properties: override canFly, aquatic, haveleg. Create new props haveFur, canBark.
 * 
 * Create Class Chihuahua extend Dog
 * properties: overried all
 */

abstract class Animal {
  // void welcome() {
  //   print("Welcome to animal show");
  // }

  void canFly();
  void aquatic();
  void haveLegs();
}

class Dog implements Animal {
  @override
  // void welcome() {
  //   print("Welcome to dog show");
  // }

  @override
  void canFly() {
    print("Dog can't fly");
  }

  @override
  void aquatic() {
    print("Dog are not aquatic animals");
  }

  @override
  void haveLegs() {
    print("Dog has 4 legs");
  }

  void haveFur() {
    print("Dog has fur");
  }

  void canBark() {
    print("Dog bark: woof woof");
  }
}

class Chihuahua extends Dog {
  void haveFur() {
    print("Chihuahua have sort fur");
  }

  void canBark() {
    print("Chihuahua bark: wauwau");
  }
}

void main() {
  var dog = Dog();
  dog.aquatic();
  dog.canBark();
  dog.canFly();

  var chh = Chihuahua();
  chh.haveFur();
  chh.canBark();
  chh.canFly();
}
