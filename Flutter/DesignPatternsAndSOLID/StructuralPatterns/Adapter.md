# Adapter

`Adapter` is a structural design pattern that allows objects with incompatible interfaces to collaborate.

### 1. Problem
Imagine that you’re creating a stock market monitoring app. The app downloads the stock data from multiple sources in XML format and then displays nice-looking charts and diagrams for the user.

At some point, you decide to improve the app by integrating a smart 3rd-party analytics library. But there’s a catch: the analytics library only works with data in JSON format.
![](https://refactoring.guru/images/patterns/diagrams/adapter/problem-en-2x.png)
You could change the library to work with XML. However, this might break some existing code that relies on the library. And worse, you might not have access to the library’s source code in the first place, making this approach impossible.

### 2. Solution
You can create an *adapter*. This is a special object that converts the interface of one object so that another object can understand it.

An adapter wraps one of the objects to hide the complexity of conversion happening behind the scenes. The wrapped object isn’t even aware of the adapter. For example, you can wrap an object that operates in meters and kilometers with an adapter that converts all of the data to imperial units such as feet and miles.

Adapters can not only convert data into various formats but can also help objects with different interfaces collaborate. Here’s how it works:

- The adapter gets an interface, compatible with one of the existing objects.
- Using this interface, the existing object can safely call the adapter’s methods.
- Upon receiving a call, the adapter passes the request to the second object, but in a format and order that the second object expects.

Sometimes it’s even possible to create a two-way adapter that can convert the calls in both directions.
![](https://refactoring.guru/images/patterns/diagrams/adapter/solution-en-2x.png)
Let’s get back to our stock market app. To solve the dilemma of incompatible formats, you can create XML-to-JSON adapters for every class of the analytics library that your code works with directly. Then you adjust your code to communicate with the library only via these adapters. When an adapter receives a call, it translates the incoming XML data into a JSON structure and passes the call to the appropriate methods of a wrapped analytics object.

### 3. Structure
**Object adapter**

This implementation uses the object composition principle: the adapter implements the interface of one object and wraps the other one. It can be implemented in all popular programming languages.
![](https://refactoring.guru/images/patterns/diagrams/adapter/structure-object-adapter-2x.png)

- The **Client** is a class that contains the existing business logic of the program.
- The **Client Interface** describes a protocol that other classes must follow to be able to collaborate with the client code.
- The **Service** is some useful class (usually 3rd-party or legacy). The client can’t use this class directly because it has an incompatible interface.
- The **Adapter** is a class that’s able to work with both the client and the service: it implements the client interface, while wrapping the service object. The adapter receives calls from the client via the client interface and translates them into calls to the wrapped service object in a format it can understand.
- The client code doesn’t get coupled to the concrete adapter class as long as it works with the adapter via the client interface. Thanks to this, you can introduce new types of adapters into the program without breaking the existing client code. This can be useful when the interface of the service class gets changed or replaced: you can just create a new adapter class without changing the client code.

**Class adapter**

This implementation uses inheritance: the adapter inherits interfaces from both objects at the same time. Note that this approach can only be implemented in programming languages that support multiple inheritance, such as C++.
![](https://refactoring.guru/images/patterns/diagrams/adapter/structure-class-adapter-2x.png)
- The **Class Adapter** doesn’t need to wrap any objects because it inherits behaviors from both the client and the service. The adaptation happens within the overridden methods. The resulting adapter can be used in place of an existing client class.

### 4. Example
Let's say you're developing an app that displays **images from an API**.

- The **old API** returns image URLs using `LegacyImageProvider`, but Flutter's image system expects `ImageProvider`, such as `NetworkImage`.
- We'll use the Adapter Pattern to convert `LegacyImageProvider` into `NetworkImage`

**1. Old Interface (Legacy code)**
Assume the old API returns image data as a string URL.
```
class LegacyImageProvider {
  String getImageUrl() {
    return "https://example.com/old-image.jpg";
  }
}
```
**2. New Interface that we need**
Flutter uses `ImageProvider`, so we need to convert the URL into `NetworkImage`
```
import 'package:flutter/material.dart';

class ModernImageProvider {
  ImageProvider<Object> getImage();
}
```

**3. Creating the Adapter**
We create an `ImageAdapter` class that **implements** `ModernImageProvider` and uses `LegacyImageProvider` to retrieve data.
```
import 'package:flutter/material.dart';

// Adapter to convert LegacyImageProvider to ModernImageProvider
class ImageAdapter implements ModernImageProvider {
  final LegacyImageProvider legacyProvider;

  ImageAdapter(this.legacyProvider);

  @override
  ImageProvider<Object> getImage() {
    // Convert the URL from legacyProvider into NetworkImage
    return NetworkImage(legacyProvider.getImageUrl());
  }
}
```
**4. Using the Adapter**
```
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Adapter Pattern Example")),
        body: Center(
          child: ImageWidget(),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final ModernImageProvider adapter =
      ImageAdapter(LegacyImageProvider()); // Adapter for conversion

  @override
  Widget build(BuildContext context) {
    return Image(image: adapter.getImage()); // Using converted NetworkImage
  }
}
```