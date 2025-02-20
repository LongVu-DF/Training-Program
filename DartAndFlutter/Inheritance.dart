// example how to use superclass's private in subcláss

class Parent {
  String _secret = "This is private";
  String get privateValue => _secret; // getter
  void showSecret() {
    print(_secret);
  }
}

class Child extends Parent {
  void display() {
    // print(_secret);  // Error: '_secret' is private and cannot be accessed
    // But we can use the method of superclass to access private value
    // super.showSecret();
    // or use superclass's getter and setter
    print(privateValue);
    print("Trying to access private data");
  }
}

void main() {
  var child = Child();
  child.display(); // Output: Trying to access private data
}
