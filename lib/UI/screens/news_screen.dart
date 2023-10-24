import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.go("/");
          },
          child: Text(
            "News Page",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ),
      ),
    );
  }
}
