
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  final url = Uri.https(
    'swapi.dev',
    'api/people'
  );
  
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = convert.jsonDecode(response.body);
    
    People people = People.fromJson(jsonResponse);
    
    print('All person from SWAPI: ${people.count}');
    showAllNamesPeople(people.results);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void showAllNamesPeople(List<PeopleResults> peoples) {
  for(int i = 0; i < peoples.length; i++) {
    print("My name is ${peoples[i].name}");
    
  }
}

class People {
  final int count;
  final List<PeopleResults> results;

  People(this.count, this.results);
  
  People.fromJson2(Map<String, dynamic> json) : 
    count = json['count'], 
    results = List<PeopleResults>.from(convert.jsonDecode(json['results'].toString()) as List);
  
  factory People.fromJson(dynamic json) {
    var resultsObjsJson = json['results'] as List;
      List<PeopleResults> _peopleResults = resultsObjsJson.map((resultsJson) => PeopleResults.fromJson(resultsJson)).toList();
      
    return People(json['count'], _peopleResults);
  }
}

class PeopleResults {
  final String name;
  final String height;

  PeopleResults(this.name, this.height);
  
  PeopleResults.fromJson(Map<String, dynamic> json) : 
    name = json['name'],
    height = json['height'].toString();
}