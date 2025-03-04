import 'package:basic_layout/domain/entities/todo.dart';
import 'package:basic_layout/presentation/blocs/todo_bloc.dart';
import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoItemView extends StatelessWidget {
  AddTodoItemView(this.mainContext, {super.key});
  final BuildContext mainContext;
  final TextEditingController title = TextEditingController();

  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainContext.colorScheme.tertiaryContainer,
        ),
        height: mainContext.deviceHeight / 3,
        width: mainContext.deviceWidth,
        child: Column(
          spacing: mainContext.deviceHeight / 35,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Adding new to-do',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: mainContext.colorScheme.onTertiaryContainer,
              ),
            ),
            TextField(
              controller: title,
              decoration: InputDecoration(
                labelText: 'Enter title',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: description,
              decoration: InputDecoration(
                labelText: 'Enter description',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    mainContext.read<TodoBloc>().addTodo(
                      Todo(
                        title: title.text,
                        time: '',
                        description: description.text,
                        done: false,
                        id:
                            (mainContext.read<TodoBloc>().state as TodoLoaded)
                                .todos
                                .last
                                .id +
                            1,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show(BuildContext mainContext) {
    return showDialog(
      context: mainContext,
      builder: (BuildContext context) {
        return AddTodoItemView(mainContext);
      },
    );
  }
}
