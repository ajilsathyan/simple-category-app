import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Location location = Location();
  TextEditingController addressCtlr = TextEditingController();


    double? latittude;
    double? longitude;


  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  Future<LocationData> getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  getAddressFromLatLan(double lat, double lon) async {
    final coordinates = Coordinates(lat, lon);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    setState(() {
      addressCtlr.text=first.addressLine;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getLocation().then((value) {
                  setState(() {
                    latittude=value.latitude!;
                    longitude=value.longitude!;
                  });
                  getAddressFromLatLan(value.latitude!, value.longitude!);
                });
              },
              icon: const Icon(Icons.location_history_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                controller: addressCtlr,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    hintText: "Address"),
                onChanged: getLocationManually,
              ),
            ),
           const SizedBox(height: 40,),
           if(latittude!=null)
           Text("Lattitude: $latittude"),
           if(longitude!=null)
           Text("longitude: $longitude"),

          ],
        ), 
      ),
    );
  }

  getLocationManually(String add) async {
    var addresses = await Geocoder.local.findAddressesFromQuery(add);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    setState(() {
      latittude=first.coordinates.latitude;
      longitude=first.coordinates.longitude;
    });
  }
}
