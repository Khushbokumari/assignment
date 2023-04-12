
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'emp.dart';


typedef SwapiResults = List<Map<String, dynamic>>;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _SwapiDemoState createState() => _SwapiDemoState();
}

class _SwapiDemoState extends State<Home> {
  @override
  void initState() {
    getPeopleData();
    super.initState();
  }

  List<PeopleModel>? jsonResults = [];

  Future getPeopleData() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https('swapi.dev', 'api/people'),
      );
      Map<String, dynamic> decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      setState(() {
        List data = decodedResponse['results'] as List;
        for (var element in data) {
          jsonResults!.add(PeopleModel.fromJson(element));
        }
      });
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Swapi API Demo',
        ),
      ),
      body: Column(
        children: [
          if (jsonResults == null)
            const Center(
                child: Text(
              'EMPTY',
              style: TextStyle(color: Colors.black),
            ))
          else
            Expanded(
              child: ListView.builder(
                itemCount: jsonResults!.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                itemBuilder: (context, index) {
                  var data = jsonResults![index];
                  return Text(
                    data.name!,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
