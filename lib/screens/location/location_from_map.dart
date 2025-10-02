import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:market_place_app/tracking/find_lat_log.dart';
import 'package:market_place_app/utils/app_colors.dart';
import 'package:market_place_app/utils/app_styles.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}
class _PickLocationPageState extends State<PickLocationPage> {
  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  String currentAddress = "Loading address...";
  bool isAddressLoading = true;

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    selectedLatLng = LatLng(position.latitude, position.longitude);

    _updateAddress(selectedLatLng!);

    setState(() {});
  }

  Future<void> _updateAddress(LatLng latLng) async {
    final pickupLatLng = await getExactAddressFromLatLng(
        latLng.latitude,latLng.longitude);

    print('----Ad--------->>>>>$pickupLatLng');
  }

  void _confirmLocation() {
    if (selectedLatLng == null) return;
    Navigator.pop(context, {
      "lat": selectedLatLng!.latitude,
      "lng": selectedLatLng!.longitude,
      "address": currentAddress,
    });

    _updateAddress(selectedLatLng!);

    print('lat---------->>>>${selectedLatLng!.latitude}');

    _updateAddress(selectedLatLng!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: selectedLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: selectedLatLng!, zoom: 16),
            onMapCreated: (controller) => mapController = controller,
            onCameraMove: (position) {
              selectedLatLng = position.target;
              _updateAddress(position.target); // update address while moving
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Positioned(
            top: 10,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ]),
              child: Text(
                isAddressLoading ? "Loading..." : currentAddress,
                style: AppStyle.normal_14(AppColors.themeColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Icon(Icons.location_pin, size: 50, color: Colors.red),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.themeColor,
        onPressed: _confirmLocation,
        label: Text("Confirm Location",
            style: AppStyle.medium_16(AppColors.whiteColor)),
        icon: const Icon(Icons.check, color: AppColors.whiteColor),
      ),
    );
  }
}
