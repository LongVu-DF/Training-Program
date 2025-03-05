import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/presentation/blocs/todo_bloc.dart';
import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoItemView extends StatelessWidget {
  const TodoItemView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoaded) {
          List<Todo> list =
              context.currentTabbar == 0
                  ? state.todos.where((todo) => todo.done == false).toList()
                  : state.todos.where((todo) => todo.done == true).toList();
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              var todo = list[index];
              return LongPressDraggable<String>(
                data: todo.id,
                feedback: dragItem(context, todo),
                child: item(context, todo, false),
                childWhenDragging: item(context, todo, true),
              );
            },
          );
        } else if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Không có dữ liệu"));
        }
      },
    );
  }

  item(BuildContext newContext, Todo todo, bool drag) {
    return BlocProvider.value(
      value: newContext.read<TodoBloc>(),
      child: Container(
        decoration: BoxDecoration(
          color:
              drag
                  ? newContext.colorScheme.errorContainer
                  : newContext.colorScheme.secondaryContainer,
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
                    context: newContext,
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
                                newContext.read<TodoBloc>().deleteTodo(todo.id);
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [Icon(Icons.delete), Text('Delete')],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                newContext.read<TodoBloc>().hasDoneTodo(
                                  todo.id,
                                  !todo.done,
                                );
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
      ),
    );
  }

  dragItem(BuildContext context, Todo todo) {
    return BlocProvider.value(
      value: context.read<TodoBloc>(),
      child: Container(
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
      ),
    );
  }
}
