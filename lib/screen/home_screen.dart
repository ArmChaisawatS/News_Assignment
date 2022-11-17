import 'package:flutter/material.dart';
import 'package:news_assignment/models/news_model.dart';
import 'package:news_assignment/screen/components/news_comp.dart';
import 'package:news_assignment/services/remote_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          setState(
            () {
              isLoaded = true;
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.purple,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.purple],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return NewsCard(
                title: posts![index].title,
                id: posts![index].id.toString(),
                body: posts![index].body.toString(),
              );
            },
          ),
        ),
      ),
    );
  }
}
