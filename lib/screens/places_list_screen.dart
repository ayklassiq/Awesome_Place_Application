import 'package:awesome_places_app/providers/awesome_places.dart';
import 'package:awesome_places_app/screens/add_places_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Palaces'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<AwesomePlaces>(context, listen:false).fetchAndSetPlaces(),
          builder: (ctx, snapshot)=>snapshot.connectionState==ConnectionState.waiting?const Center(child:CircularProgressIndicator(),) : Consumer<AwesomePlaces>(
            child: const Center(
              child: Text('Got no Place yet'),
            ),
            builder: (ctx, awesomePlaces, ch)=> awesomePlaces.items.isEmpty ? ch! :
           ListView.builder(
             itemCount: awesomePlaces.items.length,
              itemBuilder: (ctx, i) =>
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        awesomePlaces.items[i].image,
                      ),
                    ),
                    title: Text(awesomePlaces.items[i].title),
                    subtitle: Text(awesomePlaces.items[i].location!.address??''),
                    onTap:(){
                    //
                    },
    ),
                  ),),
        ),);



}}