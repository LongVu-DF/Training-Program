import 'package:basic_layout/core/ui/add_todo_item_view.dart';
import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:flutter/material.dart';

import '../ui/todo_item_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onCall});
  final String title;
  final Function(bool) onCall;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: context.colorScheme.surface,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: context.colorScheme.primary,
              iconTheme: IconThemeData(color: context.colorScheme.onPrimary),
              title: Text(
                widget.title,
                style: TextStyle(color: context.colorScheme.onError),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    widget.onCall(status);
                    status = !status;
                  },
                  icon: Icon(status ? Icons.dark_mode : Icons.light_mode),
                ),
              ],
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: context.appBarHeight,
                    color: context.colorScheme.secondary,
                  ),
                  Text('data'),
                  Text('data'),
                ],
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PreferredSize(
                    preferredSize: Size.fromHeight(24),
                    child: TabBar(tabs: <Widget>[Text('Todo'), Text('Done')]),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TodoItemView(),
                        Center(child: Text('View Done')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AddTodoItemView.show(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
