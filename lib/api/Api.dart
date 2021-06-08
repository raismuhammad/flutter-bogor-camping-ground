import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:bogor_camping_ground/api/response/Camp.dart';

class Api {

  static Future<List<Camp>> fetchCampList() async {
      final response = await http.get(Uri.parse('https://camp-bogor.herokuapp.com/camp'));
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //print(data);
        List<Camp> camps = [];
        for(Map<String, dynamic> i in data) {
          camps.add(Camp.fromJson(i));
        }
        return camps;
      } else {
        throw Exception('failed to load camp list data');
      }
  }
  
  static Future<Camp> fetchCamp(int id) async {
    final response =
        await http.get(Uri.parse('https://camp-bogor.herokuapp.com/camp/$id'));
    if (response.statusCode == 200) {
      return Camp.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load camp data');
    }
  }
}
