import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/userResponse.dart';
import 'model/weatherappresponce.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int page = 1;
  Weatherappresponce weatherappresponce = Weatherappresponce();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserResponse();
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Weather App"), centerTitle: true),
      body:  Column(
        children: [
          Container(
            // alignment: Alignment.center,
            height: H / 3,
            width: W / 1,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.blue],
                  // begin: Alignment.bottomLeft,
                  // end: Alignment.topRight,
                ),
                // color: Colors.blue.shade400,
                borderRadius: BorderRadius.all(
                    Radius.circular(10.0)), // Set rounded corner radius
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.brown,
                    offset: Offset(1, 3),
                  ),
                ] //
            ),
            child: Row(
              children: [
                // Image(
                //   image: AssetImage('assert/img/Weather+Icons+_+_+_.png'),
                // ),
                 Column(
                  children: [
                    Text(
                      "surat",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      '${(weatherappresponce.main!.temp!.toInt())! - 273.15!.toInt()}℃',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: W / 11.5,
              ),
              Container(
                child: Column(
                  children: [
                    Text("wind\n",style: TextStyle(fontSize: 16)),
                    Text('${(weatherappresponce.wind!.speed!.toInt())!.toInt()} km/h',style: TextStyle(fontSize: 24),),
                  ],
                ),
                height: H / 6,
                width: W / 3.5,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // Set rounded corner radius
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.brown,
                        offset: Offset(1, 3),
                      ),
                    ] //
                ),
              ),
              SizedBox(width:W/12),
              Container(
                child: Column(
                  children: [
                    Text("humbidity\n",style: TextStyle(fontSize: 16)),
                    Text('${(weatherappresponce.main!.humidity!.toInt())!.toInt()} %',style: TextStyle(fontSize: 24),)
                  ],
                ),
                height: H / 6,
                width: W / 3.5,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // Set rounded corner radius
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.brown,
                        offset: Offset(1, 3),
                      ),
                    ] //
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: W / 11.5,
              ),
              Container(
                child: Column(
                  children: [
                    Text("max temp\n",style: TextStyle(fontSize: 16)),
                    Text('${(weatherappresponce.main!.tempMax!.toInt())!.toInt()}',style: TextStyle(fontSize: 24),),
                  ],
                ),
                height: H / 6,
                width: W / 3.5,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // Set rounded corner radius
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.brown,
                        offset: Offset(1, 3),
                      ),
                    ] //
                ),
              ),
              SizedBox(width:W/12),
              Container(
                child: Column(
                  children: [
                    Text("min temp\n",style: TextStyle(fontSize: 16)),
                    Text('${(weatherappresponce.main!.tempMin!.toInt())!.toInt()}',style: TextStyle(fontSize: 24),)
                  ],
                ),
                height: H / 6,
                width: W / 3.5,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blue],
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // Set rounded corner radius
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.brown,
                        offset: Offset(1, 3),
                      ),
                    ] //
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }



  getUserResponse() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=surat&appid=5fe236de42cb5920670014ae928ad892');
    var response = await http.get(url);
    try {
      setState(() {});
      if (response.statusCode == 200) {
        weatherappresponce = Weatherappresponce.fromJson(
          json.decode(response.body),
        );
      } else {
        print('data Not Found!');
      }

      return weatherappresponce;
    } catch (e) {
      log(e.toString());
    }
  }
}















// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: MyApp(),
//   ));
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   int page = 1;
//   Weatherappresponce weatherappresponce = Weatherappresponce();
//
//   @override
//   Widget build(BuildContext context) {
//     double H = MediaQuery.of(context).size.height;
//     double W = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(title: Text("Weather App"), centerTitle: true),
//       body: Column(
//         children: [
//           Container(
//             // alignment: Alignment.center,
//             height: H / 3,
//             width: W / 1,
//             margin: EdgeInsets.all(20),
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.lightBlueAccent, Colors.blue],
//                   // begin: Alignment.bottomLeft,
//                   // end: Alignment.topRight,
//                 ),
//                 // color: Colors.blue.shade400,
//                 borderRadius: BorderRadius.all(
//                     Radius.circular(10.0)), // Set rounded corner radius
//                 boxShadow: [
//                   BoxShadow(
//                     blurRadius: 10,
//                     color: Colors.brown,
//                     offset: Offset(1, 3),
//                   ),
//                 ] //
//             ),
//             child: Row(
//               children: [
//                 // Image(
//                 //   image: AssetImage('assert/img/Weather+Icons+_+_+_.png'),
//                 // ),
//                  Column(
//                   children: [
//                     Text(
//                       "surat",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 40,
//                           decoration: TextDecoration.underline),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Text(
//                       '${(weatherappresponce.main!.temp!.toInt())! - 273.15!.toInt()}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 40,
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 width: W / 12,
//               ),
//               Container(
//                 height: H / 6,
//                 width: W / 3.5,
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.lightBlueAccent, Colors.blue],
//                     ),
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(10.0)), // Set rounded corner radius
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 10,
//                         color: Colors.brown,
//                         offset: Offset(1, 3),
//                       ),
//                     ] //
//                 ),
//               ),
//               SizedBox(width:W/12),
//               Container(
//                 height: H / 6,
//                 width: W / 3.5,
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.lightBlueAccent, Colors.blue],
//                     ),
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(10.0)), // Set rounded corner radius
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 10,
//                         color: Colors.brown,
//                         offset: Offset(1, 3),
//                       ),
//                     ] //
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               SizedBox(
//                 width: W / 12,
//               ),
//               Container(
//                 height: H / 6,
//                 width: W / 3.5,
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.lightBlueAccent, Colors.blue],
//                     ),
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(10.0)), // Set rounded corner radius
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 10,
//                         color: Colors.brown,
//                         offset: Offset(1, 3),
//                       ),
//                     ] //
//                 ),
//               ),
//               SizedBox(width:W/12),
//               Container(
//                 height: H / 6,
//                 width: W / 3.5,
//                 margin: EdgeInsets.all(20),
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.lightBlueAccent, Colors.blue],
//                     ),
//                     borderRadius: BorderRadius.all(
//                         Radius.circular(10.0)), // Set rounded corner radius
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 10,
//                         color: Colors.brown,
//                         offset: Offset(1, 3),
//                       ),
//                     ] //
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
  // getUserResponse() async {
  //   var url = Uri.parse(
  //       'https://api.openweathermap.org/data/2.5/weather?q=surat&appid=5fe236de42cb5920670014ae928ad892');
  //   var response = await http.get(url);
  //   try {
  //     setState(() {});
  //     if (response.statusCode == 200) {
  //       weatherappresponce = Weatherappresponce.fromJson(
  //         json.decode(response.body),
  //       );
  //     } else {
  //       print('data Not Found!');
  //     }
  //
  //     return weatherappresponce;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }



