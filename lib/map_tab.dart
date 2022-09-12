import 'dart:async';
import 'package:doted/model/story.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTab extends StatelessWidget {
  MapTab({Key? key, this.stories, this.position}) : super(key: key){
    _initialPosition = CameraPosition(
      target: LatLng(
          position?.latitude ?? 0,//-28.264329,
          position?.longitude ?? 0),
      zoom: 14.4746,
    );

    buildMarkers();
  }

  final List<Story>? stories;
  final Position? position;

  List<Marker> _customMarkers = [];

  final Completer<GoogleMapController> _controller = Completer();

  late final CameraPosition _initialPosition;

  void buildMarkers() {
    stories?.forEach((story) {
      _customMarkers.add(Marker(
        markerId: MarkerId("${story.latitude}|${story.longitude}"),
        position: LatLng(story.latitude, story.longitude),
        infoWindow: InfoWindow(
          title: story.title,
          snippet: "${story.snippet.substring(0, 40)}..."
        )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _customMarkers.toSet(),
      ),
    );
  }
}