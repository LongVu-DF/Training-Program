import 'package:basic_layout/core/blocs/todo_bloc.dart';
import 'package:basic_layout/core/ui/add_todo_item_view.dart';
import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:basic_layout/core/view_model/todo_view_model.dart';
import 'package:basic_layout/data/repository/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/todo_item_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onCall});
  final String title;
  final Function(bool) onCall;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final repository = TodoRepositoryImpl();
  late final todoBloc = TodoBloc(repository);
  late final toDoViewModel = ToDoViewModel(todoBloc);
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: todoBloc,
      child: LayoutBuilder(
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
                      child: TabBar(
                        tabs: <Widget>[
                          DragTarget<int>(
                            onAcceptWithDetails: (data) {
                              if (toDoViewModel.todo[data.data].done) {
                                int id = toDoViewModel.todo[data.data].id;
                                String title =
                                    toDoViewModel.todo[data.data].title;
                                toDoViewModel.updateTodo(id);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Move to Todo'),
                                      content: Text(
                                        'You need to complete $title',
                                      ),
                                    );
                                  },
                                );
                              }

                              // print(data.data);
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Text("Todo");
                            },
                          ),
                          DragTarget<int>(
                            onAcceptWithDetails: (data) {
                              if (!toDoViewModel.todo[data.data].done) {
                                int id = toDoViewModel.todo[data.data].id;
                                String title =
                                    toDoViewModel.todo[data.data].title;
                                toDoViewModel.updateTodo(id);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Move to Done'),
                                      content: Text(
                                        'You have completed $title',
                                      ),
                                    );
                                  },
                                );
                              }

                              // print(data.data);
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Text("Done");
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListenableBuilder(
                        listenable: toDoViewModel,
                        builder: (BuildContext context, Widget? child) {
                          return TabBarView(
                            children: [
                              TodoItemView(toDoViewModel),
                              TodoItemView(toDoViewModel),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AddTodoItemView.show(context, toDoViewModel);
                },
                child: Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
