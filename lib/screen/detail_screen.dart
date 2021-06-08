import 'package:flutter/material.dart';
import 'package:bogor_camping_ground/api/Api.dart';
import 'package:bogor_camping_ground/api/response/Camp.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  late int campId;

  DetailScreen({required this.campId});

  @override
  _DetailScreenState createState() => _DetailScreenState(campId: campId);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState({required this.campId});

  late Future<Camp> camp;
  late int campId;

  @override
  void initState() {
    super.initState();
    camp = Api.fetchCamp(campId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: FutureBuilder<Camp>(
          future: camp,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final camp = snapshot.data;
              if (camp != null) {
                return CampDetail(
                  dataCamp: camp,
                );
              }
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

// ignore: must_be_immutable
class CampDetail extends StatelessWidget {
  CampDetail({required this.dataCamp});

  late Camp dataCamp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(padding: EdgeInsets.fromLTRB(0, 0, 0, 20), children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://media-cdn.tripadvisor.com/media/photo-s/06/25/81/45/natura-eco-camp.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 280,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  dataCamp.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alamat',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(dataCamp.address),
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lokasi',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/googleMap');
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: MapScreen(),
                        ),
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(dataCamp.description),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    child: Text('Booking Now / Open Whatsapp'),
                    style: ElevatedButton.styleFrom(minimumSize: Size(350, 50)),
                    onPressed: () {},
                  ))
            ],
          ),
        ]),
        new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text('Description'),
              centerTitle: true,
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16))),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ))
      ],
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({ Key? key }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-6.5993271, 106.7953904),
    zoom: 11.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
