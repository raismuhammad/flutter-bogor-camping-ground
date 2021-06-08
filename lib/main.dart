import 'package:flutter/material.dart';
import 'package:bogor_camping_ground/screen/detail_screen.dart';
import 'package:bogor_camping_ground/screen/list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => CampListScreen());
        }

        final nameUrl = settings.name;
        if (nameUrl!=null) {
          var uri = Uri.parse(nameUrl);
          
          if (uri.pathSegments.length == 2) {
            
            if (uri.pathSegments.first == 'detail') {
              var id = uri.pathSegments[1];
              return MaterialPageRoute(builder: (context) => DetailScreen(campId: int.parse(id)));
            }
          }
        }
      },
      title: 'Fetch Camp Data',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}