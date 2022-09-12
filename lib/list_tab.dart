import 'package:doted/item_list.dart';
import 'package:doted/model/story.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ListTab extends StatelessWidget {
  const ListTab({Key? key, required this.stories, this.position}) : super(key: key);

  final List<Story> stories;
  final Position? position;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) => buildListItem(stories.elementAt(index)),
        separatorBuilder: (BuildContext context, int index) => const Divider(height: 1),
        itemCount: stories.length);
  }

  Widget buildListItem(Story story) {
    if (position != null){
      double distance = Geolocator.distanceBetween(
          story.latitude,
          story.longitude,
          position!.latitude,
          position!.longitude).toInt() / 1000;
      story.distance = "${distance.toStringAsFixed(2)} km";
    }

    return ItemList(story: story);
  }

}
