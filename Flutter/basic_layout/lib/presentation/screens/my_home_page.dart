import 'package:basic_layout/presentation/blocs/todo_bloc.dart';
import 'package:basic_layout/presentation/widgets/add_todo_item_view.dart';
import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/todo_item_view.dart';

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
                child: TabBar(
                  tabs: <Widget>[
                    DragTarget<String>(
                      onAcceptWithDetails: (data) {
                        final state = context.read<TodoBloc>().state;
                        if (state is TodoLoaded) {
                          final todos = state.todos;
                          int index = todos.indexWhere(
                            (todo) => todo.id == data.data,
                          );
                          if (index == -1) {
                            return;
                          }
                          bool isDone = todos[index].done;
                          String title = todos[index].title;
                          if (isDone) {
                            context.read<TodoBloc>().hasDoneTodo(
                              data.data,
                              false,
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Move to Todo'),
                                  content: Text('Moved "$title" to Todo!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Text("Todo");
                      },
                    ),
                    DragTarget<String>(
                      onAcceptWithDetails: (data) {
                        final state = context.read<TodoBloc>().state;
                        if (state is TodoLoaded) {
                          final todos = state.todos;
                          int index = todos.indexWhere(
                            (todo) => todo.id == data.data,
                          );
                          if (index == -1) {
                            return;
                          }
                          bool isDone = todos[index].done;
                          String title = todos[index].title;

                          if (!isDone) {
                            context.read<TodoBloc>().hasDoneTodo(
                              data.data,
                              true,
                            );
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Move to Done'),
                                  content: Text('You have completed "$title"!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Text("Done");
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(children: [TodoItemView(), TodoItemView()]),
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
  }
}
