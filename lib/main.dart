import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("friends");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Box<String> friendsBox;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friendsBox = Hive.box<String>("friends");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: friendsBox.listenable(),
              builder: (context, Box<String> friends, _){
                return ListView.separated(
                    itemBuilder: (context, index){
                      final key = friends.keys.toList()[index];
                      final value = friends.get(key);

                      return ListTile(
                        title: Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                        subtitle: Text(key, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      );
                    },
                    separatorBuilder:(_, index) => Divider(),
                    itemCount: friends.keys.toList().length
                );
              },
            )
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                FlatButton(
                  child: Text("Add New"),
                  color: Colors.greenAccent,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (_){
                          return Dialog(
                            child: Container(
                                padding : EdgeInsets.all(32),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _idController,
                                      ) ,

                                      SizedBox(height:16),

                                      TextField(
                                        controller: _nameController,
                                      ),


                                      SizedBox(height:16),
                                      FlatButton(
                                        child : Text("submit"),

                                        onPressed: (){
                                          final key = _idController.text;
                                          final value = _nameController.text;

                                          friendsBox.put(key, value);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ]
                                )
                            ),
                          );
                        }
                    );
                  },
                ),

                FlatButton(
                  child: Text("Update"),
                  color: Colors.greenAccent,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (_){
                          return Dialog(
                            child: Container(
                                padding : EdgeInsets.all(32),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _idController,
                                      ) ,

                                      SizedBox(height:16),

                                      TextField(
                                        controller: _nameController,
                                      ),


                                      SizedBox(height:16),
                                      FlatButton(
                                        child : Text("submit"),

                                        onPressed: (){
                                          final key = _idController.text;
                                          final value = _nameController.text;

                                          friendsBox.put(key, value);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ]
                                )
                            ),
                          );
                        }
                    );
                  },
                ),

                FlatButton(
                  child: Text("Delete"),
                  color: Colors.greenAccent,
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (_){
                          return Dialog(
                            child: Container(
                                padding : EdgeInsets.all(32),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: _idController,
                                      ) ,


                                      SizedBox(height:16),
                                      FlatButton(
                                        child : Text("submit"),

                                        onPressed: (){
                                          final key = _idController.text;

                                          friendsBox.delete(key);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ]
                                )
                            ),
                          );
                        }
                    );
                  },
                ),
              ],
            ),
          )
        ],
      )

    );
  }
}
