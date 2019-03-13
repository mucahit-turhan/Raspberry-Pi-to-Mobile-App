import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspberry',
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      home: Raspberry(),
    );
  }
}

class Raspberry extends StatefulWidget {
  @override
  RaspberryState createState() => RaspberryState();
}

class RaspberryState extends State<Raspberry> {

  List data = [];
  String last_temp = "";

  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal.shade700,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/pi.png",
              width: 77,
              height: 77,
            ),
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          last_temp,
                          style: Theme.of(context).textTheme.display1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 80),
                        );
                      }
                      return CircularProgressIndicator();
                    })),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  data[index]['temperature'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  data[index]['datetime'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          );
                        });
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  debugPrint("tıkladık");
                  getData();
                });
              },
              child: Image.network(
                "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
                width: 125,
                height: 125,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Future getData() async {
    final response = await http.get('http://172.16.4.207/json.php');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      data = json.decode(response.body);
      last_temp = data[data.length - 1]["temperature"] + " °C";
      return data;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
