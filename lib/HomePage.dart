import 'package:djangonoteapp/models/Note.dart';
import 'package:flutter/material.dart';
import 'package:djangonoteapp/utils/loadData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: ElevatedButton(
              style: const ButtonStyle(
                  iconColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
               
              },
              child: const Icon(Icons.add)),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'Django Note App',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
              child: StreamBuilder(
            stream: LoadData().notes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index]['title']),
                      subtitle: Text(snapshot.data![index]['content']),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ))),
    );
  }
}
