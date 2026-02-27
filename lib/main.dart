


import 'package:flutter/material.dart';
import 'package:xo_games/xogame/login.dart';
import 'package:xo_games/xogame/xogames.dart';





void main()
{
  runApp(Myapp());

}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:  Login.routename,
      routes:{
        Login.routename:(context)=>Login(),
        Xogame.routename:(context)=>Xogame(),
      } ,



    );
  }
}
