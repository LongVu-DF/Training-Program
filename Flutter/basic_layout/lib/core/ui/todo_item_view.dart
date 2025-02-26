import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:basic_layout/data/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoItemView extends StatelessWidget {
  const TodoItemView({
    super.key,
    required this.todo,
    required this.deleteTodo,
    required this.updateTodo,
  });
  final List<ToDo> todo;
  final void Function(int) deleteTodo;
  final void Function(int) updateTodo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todo.length,
      itemBuilder: (BuildContext context, int index) {
        return LongPressDraggable<int>(
          data: index,
          feedback: dragItem(context, index),
          child: item(context, index, false),
          childWhenDragging: item(context, index, true),
        );
      },
    );
  }

  item(BuildContext context, int index, bool drag) {
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
                  todo[index].title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(todo[index].description),
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
                              deleteTodo(todo[index].id);
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [Icon(Icons.delete), Text('Delete')],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              updateTodo(todo[index].id);
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  todo[index].done
                                      ? Icons.move_up_rounded
                                      : Icons.move_down_rounded,
                                ),
                                Text(
                                  todo[index].done
                                      ? 'Move to Todo'
                                      : 'Move to Done',
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

  dragItem(BuildContext context, int index) {
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
                  todo[index].title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSecondaryContainer,
                    decoration: TextDecoration.none,
                  ),
                ),
                Text(
                  todo[index].description,
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
