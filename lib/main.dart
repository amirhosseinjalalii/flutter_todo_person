import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors_theme.dart';
import 'package:todo_app/constants/fake_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'T O D O'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String insertPerson = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SolidColors.primary,
        title: Text(widget.title),
      ),
      body: Container(
        color: SolidColors.secondary,
        height: double.infinity,
        width: double.infinity,
        child: persons.isNotEmpty
            ? ListView.builder(
                itemCount: persons.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: SolidColors.primary,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              persons[index].person,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print(index);
                                setState(() {
                                  persons.removeAt(index);
                                });
                              },
                              child: const Icon(CupertinoIcons.delete,
                                  color: Colors.white60),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                "There is empty !",
                style: TextStyle(fontSize: 25, color: Colors.white60),
              )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SolidColors.primary,
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                  color: SolidColors.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: size.height / 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: SolidColors.secondary2,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, left: 16),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            insertPerson = value;
                          });
                        },
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 18),
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Add person",
                          labelStyle: TextStyle(color: Colors.white60),
                          border: OutlineInputBorder(),
                          hintText: "Add person",
                          hintStyle: TextStyle(color: Colors.white60),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: SolidColors.secondary2,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: SolidColors.secondary2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 32),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (insertPerson.isNotEmpty) {
                              persons.add(PersonModel(person: insertPerson));
                              insertPerson = "";
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: SolidColors.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          width: size.width,
                          height: 50,
                          child: const Center(
                            child: Text(
                              "Add person",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: 'Add person',
        child: const Icon(Icons.add),
      ),
    );
  }
}
