import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// https://bitbucket.org/itesmguillermorivas/partial2/raw/45f22905941b70964102fce8caf882b51e988d23/carros.json

// when doing a json request you can work with a json object directly (Map)
// in this example we will define a class that translates that map into an object

class Car {

  Car({required this.brand, required this.model, required this.year});

  final String brand;
  final String model;
  final int year;

  // we are going to do our very own factory method! 
  // yay!
  // https://en.wikipedia.org/wiki/Factory_method_pattern
  factory Car.fromJSON(Map<String, dynamic> json) {
    return Car(
      brand: json['marca'],
      model: json['modelo'],
      year: json['anio']
    );
  }
}

// we are going to declare a function that does the actual request
// as you can imagine this will be used in a widget
Future<List<Car>> getCars() async {
  
  // do the request 
  final response = await http.get(
    Uri.parse("https://bitbucket.org/itesmguillermorivas/partial2/raw/45f22905941b70964102fce8caf882b51e988d23/carros.json")
  );

  // https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
  if(response.statusCode == 200){
    // if everything went ok build and return a car list 

    // step1 - parse response into json
    List<dynamic> jsonResult = jsonDecode(response.body);

    // declare structure to return
    List<Car> cars = [];

    // iterate through the objects in the json
    for(var current in jsonResult) {
      
      Car currentCar = Car.fromJSON(current);
      cars.add(currentCar);
    } 

    print("REQUEST DONE");
    return cars;
  } else {
    throw Exception("REQUEST HAD ERRORS: ${response.statusCode}");
  }
}

class RequestDetailWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<RequestDetailWidget> createState() => _RequestDetailWidgetState();
}

class _RequestDetailWidgetState extends State<RequestDetailWidget> {

  // add an instance variable that contains a reference to the future;
  late Future<List<Car>> cars;

  @override
  void initState() {
    super.initState();
    cars = getCars();
    print("REQUESTING");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("REQUEST VIEW")),
      body: Center(
        child: FutureBuilder(
          future: cars, 
          builder: (
            (context, snapshot) {

              // required: return a widget
              if(snapshot.hasData) {

                print("HAS DATA");
                List<Widget> children = [];

                if(snapshot.data != null) {

                  for(var currentCar in snapshot.data!){
                    children.add(Text("${currentCar.brand} ${currentCar.model} ${currentCar.year}"));
                  }
                }

                return Column(children: children);

              } else if(snapshot.hasError) {

                return Text("${snapshot.error}");
              } 
                
              return const CircularProgressIndicator();
              
                
            }
          )
        )
      )
    );
  }
}