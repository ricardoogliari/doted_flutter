import 'package:doted/model/story.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
      leading: const Icon(Icons.account_circle_outlined),
      trailing: Text(story.distance),
      title: Text(story.title),
      subtitle: Text(story.snippet),
    ),
  );
}
