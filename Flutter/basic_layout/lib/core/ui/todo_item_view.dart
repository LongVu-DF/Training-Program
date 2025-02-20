import 'package:basic_layout/core/ui/utils/buildcontext_extension.dart';
import 'package:basic_layout/core/view_model/todo_view_model.dart';
import 'package:flutter/material.dart';

class TodoItemView extends StatefulWidget {
  const TodoItemView({super.key});

  @override
  State<TodoItemView> createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {
  ToDoViewModel toDoViewModel = ToDoViewModel();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: toDoViewModel.todo.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              Flexible(fit: FlexFit.tight, flex: 1, child: Text('Time')),
              Flexible(
                flex: 6,
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toDoViewModel.todo[index].title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(toDoViewModel.todo[index].description),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: IconButton(
                  onPressed: () {
                    // showModalBottomSheet<void>(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return Container(
                    //       height: 200,
                    //       color: context.colorScheme.secondaryContainer,
                    //     );
                    //   },
                    // );
                    toDoViewModel.addToDo(
                      title: 'Test title',
                      description: 'Test description',
                      time: 'Test time',
                      done: false,
                    );
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
