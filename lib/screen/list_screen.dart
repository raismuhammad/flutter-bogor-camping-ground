import 'package:flutter/material.dart';
import 'package:bogor_camping_ground/api/Api.dart';
import 'package:bogor_camping_ground/api/response/Camp.dart';

class CampListScreen extends StatefulWidget {
  @override
  _CampListScreenState createState() => _CampListScreenState();
}

class _CampListScreenState extends State<CampListScreen> {
  late Future<List<Camp>> futureCampList;

  @override
  void initState() {
    super.initState();
    futureCampList = Api.fetchCampList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bogor Camping Ground',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.blueGrey[50],
      body: FutureBuilder<List<Camp>>(
        future: futureCampList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            if (data != null) {
              return CampListWidget(data);
            }
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // default show loading widget
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class CampListWidget extends StatelessWidget {
  List<Camp> camps = [];

  CampListWidget(List<Camp> list) {
    this.camps = list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: camps.length,
        itemBuilder: (context, index) {
          final data = camps[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail/${camps[index].campId}');
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.name,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(data.address),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
