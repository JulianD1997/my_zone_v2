
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/paginas/sesion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"My Zone",
      debugShowCheckedModeBanner: false,
      initialRoute: EstadoLogin.id,
      routes: {
        EstadoLogin.id : (context) => EstadoLogin(AuthFirebase()),
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

