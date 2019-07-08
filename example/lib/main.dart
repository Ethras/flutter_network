import 'package:flutter/material.dart';
import 'package:flutter_network/flutter_network.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isRestricted = false;

  @override
  void initState() {
    super.initState();
    http
        .get('https://jsonplaceholder.typicode.com/posts/');
    FlutterNetwork.dataRestrictedStateChanged().listen((restricted) {
      print("DataRestriction changed : $restricted");
    });
  }

  _checkCellularRestriction() async {
    final res = await FlutterNetwork.isCellularDataRestricted;
    setState(() {
      isRestricted = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Check cellular restriction"),
                onPressed: _checkCellularRestriction,
              ),
              Text('Cellular restriction $isRestricted'),
            ],
          ),
        ),
      ),
    );
  }
}
