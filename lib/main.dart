import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}
 class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context ){
    return MaterialApp(
      home: HomePage()
    );}
  }


class HomePage  extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();



}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          title: Text("WEATHER API"),
          centerTitle: true,

          backgroundColor: Colors.white54,
        ), //appbar
        body: Center(

            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 400,
                        width: 1000,
                        color: Colors.lightGreenAccent,
                        child:
                        FutureBuilder(
                            future: apicall(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 20, 30, 40),
                                        child:Column(
                                          children: [
                                            Text(
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 50.0,
                                                    fontStyle: FontStyle.italic,

                                                    fontFamily: 'cursive'
                                                ),
                                                snapshot.data['name'].toString()
                                            ),

                                           Container(
                                             height: 200,
                                             width: 900,
                                            color: Colors.blueGrey,
                                             child: Column(
                                                 mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 Text(
                                                     style: TextStyle(
                                                       color: Colors.black87,
                                                       fontWeight: FontWeight.bold,

                                                     ),

                                                     "Temperature in F:                                                "

                                                 ),
                                                 Text(
                                                   style: TextStyle(
                                                     color: Colors.black87,
                                                     fontWeight: FontWeight.bold,

                                                   ),

                                                    snapshot.data['temp'].toString()

                                                   ),
                                                 Text(
                                                     style: TextStyle(
                                                       color: Colors.black87,
                                                       fontWeight: FontWeight.bold,

                                                     ),

                                                     "Description:                                                    "

                                                 ),
                                                 Text(
                                                   style: TextStyle(
                                                     color: Colors.black87,
                                                     fontWeight: FontWeight.bold,
                                                   ),

                                                   snapshot.data['description'].toString(),

                                                 ),
                                                 Text(
                                                     style: TextStyle(
                                                       color: Colors.black87,
                                                       fontWeight: FontWeight.bold,

                                                     ),

                                                     "Icon :                                                          "

                                                 ),
                                                 Text(
                                                   style: TextStyle(
                                                     color: Colors.black87,
                                                     fontWeight: FontWeight.bold,

                                                   ),

                                                   snapshot.data['icon'].toString()
                                                 ),

                                                 ]



                                             ),
                                           )


                                          ]
                                        )
                                      ),

                                    ]

                                );
                              }
                              else {
                                return CircularProgressIndicator();
                              }
                            })
                    )
                  ],

                )
            )

        )
    );
  }


  Future apicall() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=3747a29e5253b164edc6cc4e0a530217");

    // final url = Uri.parse(host: "https://api.openweathermap.org",
    //     path: "/data/2.5/weather",
    // quweyParameters: {
    //   'q': 'bangalore',
    //   'appid' : '3747a29e5253b164edc6cc4e0a530217'
    // });
    // ?q=bangalore&appid=3747a29e5253b164edc6cc4e0a530217");  //other way to do

    final response = await http.get(url); //final or var
    print(response.body);
    final json = jsonDecode(response.body);
    print(json['weather'][0]['description']);
    final output = {
      'description': json['weather'][0]['description'],
      'icon': json['weather'][0]['icon'],
      'temp': json['main']['temp'],
      'name': json['name']
      //icon_url = "http://openweathermap.org/img/w/" + json["weather"]["icon"] +".png"
    };
    return output;
  }


}
