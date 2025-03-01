import 'package:basic_layout/core/blocs/todo_bloc.dart';
import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:basic_layout/core/view_model/todo_view_model.dart';
import 'package:basic_layout/data/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoItemView extends StatelessWidget {
  const TodoItemView(this.toDoViewModel, {super.key});
  final ToDoViewModel toDoViewModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        List<ToDo> list =
            context.currentTabbar == 0
                ? state.todo.where((todo) => todo.done == false).toList()
                : state.todo.where((todo) => todo.done == true).toList();
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            var todo = list[index];
            return LongPressDraggable<int>(
              data: index,
              feedback: dragItem(context, todo),
              child: item(context, todo, false),
              childWhenDragging: item(context, todo, true),
            );
          },
        );
      },
    );
  }

  item(BuildContext context, ToDo todo, bool drag) {
    return Container(
      decoration: BoxDecoration(
        color:
            drag
                ? context.colorScheme.errorContainer
                : context.colorScheme.secondaryContainer,
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
                  todo.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(todo.description),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        border: BorderDirectional(top: BorderSide()),
                        color: context.colorScheme.secondaryContainer,
                      ),
                      height: context.deviceHeight / 8,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              toDoViewModel.deleteTodo(todo.id);
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [Icon(Icons.delete), Text('Delete')],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              toDoViewModel.updateTodo(todo.id);
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  todo.done
                                      ? Icons.move_up_rounded
                                      : Icons.move_down_rounded,
                                ),
                                Text(
                                  todo.done ? 'Move to Todo' : 'Move to Done',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }

  dragItem(BuildContext context, ToDo todo) {
    return Container(
      width: context.deviceWidth * 0.95,
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(
              'Time',
              style: TextStyle(
                fontSize: 16,
                color: context.colorScheme.onSecondaryContainer,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSecondaryContainer,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  todo.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: context.colorScheme.onSecondaryContainer,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ),
        ],
      ),
    );
  }
}
