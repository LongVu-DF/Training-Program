# Dependency Injection

### What is Dependency?
 In the realm of programming, a dependency is an object or a class that another class needs to function correctly. For instance, if we have a `class` that fetches data from a website, this class may depend on a service or a repository to access the data. These services or repositories are the dependencies of our class. In the context of Flutter, dependencies could be Flutter packages, third-party dependencies, or even classes we create within our own Flutter projects.

### The Concept of Injection
![](https://strapi.dhiwise.com/uploads/dependency_injection_in_flutter_boosting_app_performance_0_cdf02d6016.jpg?w=1920&q=75)
Dependency injection is a programming technique that makes our code more maintainable by decoupling the dependencies of a class. The primary goal of dependency injection is to provide a class with its dependencies, rather than having the class create these dependencies itself. This way, we can manage dependencies in a more maintainable way, making our code easier to test and modify.

In Flutter, we implement dependency injection by passing instances of dependencies into the class that needs them. This could be done through the constructor (constructor injection), a method (method injection), or directly into a field (field injection).
### Different Types of Dependency Injection in Flutter
**1. Constructor Injection.**  
Constructor injection is one of the most common forms of dependency injection. In this approach, we pass the dependencies of a class through its constructor. This is a straightforward and effective way to provide a class with its dependencies, and it's often the preferred method for implementing dependency injection in Flutter.
```
class AuthRepository {
  final ApiService apiService; // Dependency

  AuthRepository(this.apiService); // Inject throw constructor

  void login(String email, String password) {
    apiService.authenticate(email, password);
  }
}

void main() {
  final apiService = ApiService();
  final authRepository = AuthRepository(apiService); // Inject here
}
```

**2. Method Injection**  
Method injection is another form of dependency injection where we pass the dependencies of a class through a method. This can be useful when a class needs to use different implementations of a dependency at different times, or when a dependency is not needed immediately when the class is created.
```
class AuthRepository {
  late ApiService apiService;

  void setApiService(ApiService service) {
    this.apiService = service; // Inject throw method
  }

  void login(String email, String password) {
    apiService.authenticate(email, password);
  }
}

void main() {
  final authRepository = AuthRepository();
  authRepository.setApiService(ApiService()); // Inject here
}
```
**3. Field Injection**  
Field injection is a less common form of dependency injection where we inject a dependency directly into a field of a class. This can be useful in certain scenarios, but it's generally less preferred than constructor or method injection because it can make our code harder to understand and test.
```
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<ApiService>(ApiService());
}

class AuthRepository {
  final ApiService apiService = getIt<ApiService>(); // Inject to field

  void login(String email, String password) {
    apiService.authenticate(email, password);
  }
}

void main() {
  setupLocator();
  final authRepository = AuthRepository();
}
```