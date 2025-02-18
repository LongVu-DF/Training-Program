import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.onCall});
  final String title;
  final Function(bool) onCall;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool status = false;
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: scheme.surface,
          appBar: AppBar(
            backgroundColor: scheme.primary,
            title: Text(
              widget.title,
              style: TextStyle(color: scheme.onPrimary),
            ),
            leading: IconButton(
              onPressed: () {
                widget.onCall(status);
                status = !status;
              },
              icon: Icon(status ? Icons.dark_mode : Icons.light_mode),
              color: scheme.onPrimary,
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                constraints.maxWidth < 600 ? SizedBox(height: 150) : SizedBox(),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: scheme.onSurface, fontSize: 36),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 350,
                  child: TextField(
                    controller: emailControler,
                    decoration: InputDecoration(
                      label: Text('Email'),
                      labelStyle: TextStyle(color: scheme.onSecondaryContainer),
                      floatingLabelStyle: TextStyle(
                        color: scheme.onPrimaryContainer,
                      ),
                      filled: true,
                      fillColor: scheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: passwordControler,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text('Password'),
                      labelStyle: TextStyle(color: scheme.onSurface),
                      floatingLabelStyle: TextStyle(
                        color: scheme.onPrimaryContainer,
                      ),
                      filled: true,
                      fillColor: scheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: Text(
                //     'You have pushed the button this many times:',
                //     style: TextStyle(color: scheme.onSurface),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        // ShowDialog is an Future, it will waiting for the dialog box (AlertDialog, SimpleDialog ...) closed with Navigator.pop(),
                        // when close a dialog, can return a `value` for Future. Can use async, await to wait returned `value`
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: scheme.secondaryContainer,
                            title: Text(
                              'You have entered:',
                              style: TextStyle(
                                color: scheme.onSecondaryContainer,
                              ),
                            ),
                            content: SizedBox(
                              height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Email: ${emailControler.text}',
                                    style: TextStyle(
                                      color: scheme.onSecondaryContainer,
                                    ),
                                  ),
                                  Text(
                                    'Password: ${passwordControler.text}',
                                    style: TextStyle(
                                      color: scheme.onSecondaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: scheme.onSecondaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: scheme.primaryContainer,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: scheme.onPrimaryContainer),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
