import 'package:awesome_places_app/helpers/location_helper.dart';
import 'package:awesome_places_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class LocationInput extends StatefulWidget {
    final Function onSelectPlace;
    LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
   void _showPreview(double lat, double lng){
     final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
         latitude: lat, longitude: lng);
     setState(() {
       _previewImageUrl = staticMapImageUrl as String?;
     });

   }
  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    _showPreview(locData.latitude!, locData.longitude!);
    widget.onSelectPlace(locData.latitude,locData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? const Text(
                  'No location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(_previewImageUrl!,
                  fit: BoxFit.cover, width: double.infinity),
        ),
        Row(
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
