import 'package:doted/list_tab.dart';
import 'package:doted/map_tab.dart';
import 'package:doted/model/story.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Story> stories = [
    Story(-28.263507236638343, -52.39932947157066, "Harosin", "Sollicitudin aliquam ipsum aptent id dictumst ligula curae libero senectus aliquet, cubilia scelerisque laoreet aliquet tempor quis fermentum ullamcorper interdum erat, massa placerat cubilia torquent arcu praesent tempor erat aptent.", 0, 0),
    Story(-28.260889627977562, -52.400177049595555, "Dagar", "Viverra sodales vitae congue iaculis interdum class primis hac proin bibendum, diam erat ut aenean viverra gravida venenatis elit pulvinar conubia, primis est dui feugiat curae hac mauris egestas sodales. ", 0, 0),
    Story(-28.261456624477784, -52.39208750743389, "Arve", "Habitant bibendum vel habitasse cursus quis sollicitudin dapibus tristique, congue suspendisse ut aptent ut tincidunt nam libero luctus, lorem ullamcorper quam ultricies congue curae pharetra. consectetur lacus faucibus sodales, imperdiet. ", 0, 0),
    Story(-28.26597358890354, -52.402505206969835, "Husaol", "Pharetra pretium donec commodo torquent vestibulum class turpis, purus sed gravida dolor dictumst auctor adipiscing, mattis eros venenatis nostra augue rutrum. euismod malesuada etiam tellus cras fames, convallis donec sociosqu. ", 0, 0),
    Story(-28.2705761904961, -52.39146318305821, "Tagalan", "Felis senectus habitasse facilisis torquent quis consectetur class, bibendum quam libero arcu pharetra proin iaculis nisl, praesent sed adipiscing nec nam iaculis. potenti imperdiet pellentesque facilisis nisl, quisque cursus purus. ", 0, 0),

    Story(-28.242828, -52.381907, "Hiesaipen", "Mauris accumsan hendrerit consequat pharetra torquent elementum curabitur, etiam sed adipiscing cras vel tellus, a donec augue eu eget himenaeos. ", 0, 0),
    Story(-28.241999, -52.438139, "Zokgaelu", "Nullam rutrum dictum mauris fermentum cursus quis fusce, litora augue pulvinar sem primis egestas, risus erat vestibulum curabitur lorem libero. ", 0, 0),
    Story(-28.181835, -52.328675, "Curuas", "Tempor accumsan libero consequat phasellus tellus nullam mi, nibh placerat sagittis magna himenaeos tempus, rutrum proin lacus imperdiet ad nisl.", 0, 0),
    Story(-28.124979, -52.296718, "Buigrak", "Vulputate elementum sem bibendum ad pretium pellentesque metus, nostra quisque in dolor lectus mollis, ante donec sapien netus laoreet congue. ", 0, 0),
    Story(-28.107857, -52.145972, "Lomoa", "Dolor quisque tellus purus sagittis potenti ipsum nunc, porttitor magna sit aliquam erat lacinia, a phasellus curabitur diam tempus primis. ", 0, 0)
  ];

  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Position? _currentPosition;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) {
      setState(() {
        _currentPosition = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('We need help'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.map_outlined),
              ),
              Tab(
                icon: Icon(Icons.list),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
                child: MapTab(
                    key: UniqueKey(),
                    stories: widget.stories,
                    position: _currentPosition)
            ),
            Center(
              child: ListTab(
                  stories: widget.stories,
                  position: _currentPosition),
            )
          ],
        ),
      ),
    );
  }

}
