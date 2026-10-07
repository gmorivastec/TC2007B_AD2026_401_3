// we DON'T have npm here!
// - pub

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'request.dart';


// 2 types of widgets to explore:
// 1. stateful
// 2. stateless

class StatelessExampleWidget extends StatelessWidget {
  const new({super.key});

  // stateless widgets have a build method that must be implemented
  // this is where the UI is built
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("EXAMPLE")),
        body: StatefulWidgetExample()
    );
    //const Placeholder();
    // const objects - 
    // run time optimization
    // objects that are const are created on compilation-time
    // if the object has to change internally it cannot be const
    // THIS IS PREMIUM QUIZ MATERIAL.

  }
}

// stateful widget:
// 1. it can have several UIs associated through a state
// 2. you can use state variables! 
class StatefulWidgetExample extends StatefulWidget {
  const new({super.key});

  // stateful widgets DON'T have a build method
  // they return a state that has a build method itself
  @override
  State<StatefulWidgetExample> createState() => _StatefulWidgetExampleState();
}

// states -
// classes that are related to a particular widget
// this relationship is estabilshed in the inheritance (the generic <> part)
class _StatefulWidgetExampleState extends State<StatefulWidgetExample> {

  // adding some dummy data to display
  final List<String> content = ["a", "b", "c", "d", "e"]; 
  final TextStyle textStyle = TextStyle(fontSize: 20.0);

  // as stated before statefulwidgets have no build BUT
  // their states do
  @override
  Widget build(BuildContext context) {
    return buildList();
  }

  Widget buildList() {
    // factory method! 
    // a method that creates an instance of an object based on certain paramters
    // and logic that would not fit a constructor
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: content.length,
        itemBuilder: (context, i) {
            return buildRow(content[i]);
        }
    );
    
  }

  Widget buildRow(String value) {
    return ListTile(
        title: Text(
            value,
            style: textStyle
        ),
        onTap: () {
            
            // display toast (simple emerging window message)
            Fluttertoast.showToast(
                msg: "YOU TOUCHED A TILE: $value",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 2
            );

            // navigate
            Navigator.push(
                context,
                //MaterialPageRoute(builder: (context) => DetailViewWidget(externalArg: value,))
                MaterialPageRoute(builder: (context) => RequestDetailWidget())
            );
        },
    );
  }
}

class DetailViewWidget extends StatelessWidget {
  const new({super.key, required this.externalArg});

  final String externalArg; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("DETAIL VIEW")),
        body: Center(
            child: Text("SOME INFO TO DISPLAY: $externalArg")
        )
    );
  }
}