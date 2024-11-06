import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/constans/colors.dart';
import 'package:todo_app/data/entity/todo.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todo_app/ui/views/detay_sayfasi.dart';
import 'package:todo_app/ui/views/kayit_sayfasi.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().todos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo App"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: CupertinoSearchTextField(
                  placeholder: "Ara",
                  onChanged: (value) {
                    context.read<AnasayfaCubit>().ara(value);
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
              BlocBuilder<AnasayfaCubit, List<Todo>>(
                builder: (context, todoList) {
                  if (todoList.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        var todos = todoList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetaySayfasi(todo: todos),
                                ),
                              ).then(
                                (value) {
                                  context.read<AnasayfaCubit>().todos();
                                },
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            tileColor: const Color.fromARGB(255, 255, 255, 255),
                            title: Text(
                              todos.text!,
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                iconSize: 18,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Todo Silinsin mi?"),
                                    action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        context
                                            .read<AnasayfaCubit>()
                                            .sil(todos.id)
                                            .then(
                                          (value) {
                                            context
                                                .read<AnasayfaCubit>()
                                                .todos();
                                          },
                                        );
                                      },
                                    ),
                                  ));
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KayitSayfasi(),
              )).then(
            (value) {
              context.read<AnasayfaCubit>().todos();
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}