# ChangeNotifier
`ChangeNotifier` is optimized for small numbers (one or two) of listeners. It is O(N) for adding and removing listeners and O(N²) for dispatching notifications (where N is the number of listeners).

It provides change notification to it’s listeners. In other words, if something is a `ChangeNotifier`, you can subscribe to its changes. (It is a form of `Observable`, for those familiar with the term.)

We can extend our `Model Classes` with `ChangeNotifier` and call it’s method `notifyListeners()` whenever there is a change in the model. This call will tell the widgets that are listening to this model to rebuild.
```
class ModelClass extends ChangeNotifier {
....
void onChange() {
  notifyListeners();
}
....
}
```
Call the onChange method whenever something changes in the model which might affect the UI and notifyListeners() will send a notification to all the listening widgets.