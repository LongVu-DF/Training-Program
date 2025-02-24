import 'package:basic_layout/core/utils/buildcontext_extension.dart';
import 'package:basic_layout/core/view_model/todo_view_model.dart';
import 'package:flutter/material.dart';

class AddTodoItemView extends StatelessWidget {
  AddTodoItemView({super.key, required this.viewModel});
  final ToDoViewModel viewModel;
  final TextEditingController title = TextEditingController();

  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colorScheme.tertiaryContainer,
        ),
        height: context.deviceHeight / 3,
        width: context.deviceWidth,
        child: Column(
          spacing: context.deviceHeight / 35,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Adding new to-do',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onTertiaryContainer,
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
                    viewModel.addTodo(
                      title: title.text,
                      time: '',
                      description: description.text,
                      done: false,
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

  static Future<void> show(BuildContext context, ToDoViewModel viewModel) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTodoItemView(viewModel: viewModel);
      },
    );
  }
}
