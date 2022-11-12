import 'package:awesome_places_app/providers/awesome_places.dart';
import 'package:awesome_places_app/screens/add_places_screen.dart';
import 'package:awesome_places_app/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (_)=>AwesomePlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(ctx)=>AddPlaceScreen(),        },

    ) ,);}
}

