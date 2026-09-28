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