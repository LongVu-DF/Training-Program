# GetX State Management.

GetX is a fast, stable, and light state management library in flutter that simplifies the process of managing and updating the state of your application. It is an alternative to other state management libraries in flutter like MobX, BLoC, Redux, Provider, etc. GetX is also a powerful micro framework and using this, we can manage states, complicated routing, and can perform dependency injection. It handles state of the app without boilerplate code.

### 1. Principles of GetX
- **Performance**: As compared to other state management libraries, GetX is best because it consumes minimum resources. It do not uses `Streams` or `ChangeNotifier` and provides better performance.
- **Productivity**: GetX’s syntax is easy so it is productive. It saves a lot of time for the developers and increases the speed of the app because it does not use extra resources. It uses only those resources which are currently needed and after its work is done, the resources will free automatically.
- **Organization**: GetX code is organized as `View`, `Logic`, `navigation`, and `dependency injection`. So we don’t need any more `context` to navigate to other screen. We can navigate to screen without using the `context` so we are not dependent on widget tree.

### 2. Categories
- **State Management**: There are twotypes of state management:
    - **Simple State Manager**: It uses `GetBuilder`.
    - **Reactive State Manager**: It uses `GetX` and `Obx`.
- **Route Management**: If we want to make `Widgets` like `Snackbar`, `Bottomsheets`, `dialogs`, etc. Then we can use GetX for it because GetX can build these widgets without using context.
- **Dependency Management**: If we want to fetch data from other Class then with the help of GetX, we can do this in just a single line of code. Eg: `Get.put()`.

### 3. Why use GetX.
- When we develop a flutter project without using GetX, after Flutter updates, various dependencies raise errors in the project. Many times it requires dedicated debugging to resolve the depracated issues, but with GetX, the only thing we need to do after the flutter update is updating the Get dependency.
- We all know that Flutter is fast, but there are things that need to be avoided like when navigating to another screen, we use `Navigator.of(context).push(context, builder(…..))` and doing this so many times is not a good approach for a developer. Instead of writing this, we can simply write `Get.to(HomePage())` to navigate to HomePage.
- When we want to update any Widget, we often use StatefulWidget for that. Instead of creating StatefulWidgets, we can do the same task using Stateless Widget also using GetX. Adding “`.obs`” to the variable which has to be updated, and placing the Widget inside Obx then we can update the screen when a variable changes the value without refresh the whole page.
- When we navigate between screens, create widgets like a snack bar, bottom sheets, etc. then we don’t need to use context anymore. So due to GetX, performance increases.