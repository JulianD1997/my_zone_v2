import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_zone_v2/widgets/notificaciones.dart';

class mensajes extends StatefulWidget {
  const mensajes({Key? key}) : super(key: key);

  @override
  _mensajesState createState() => _mensajesState();
}

class _mensajesState extends State<mensajes> {
  void initState(){
    super.initState;
    final notificaciones mensaje=new notificaciones();
    mensaje.generarToken();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Notificaciones: '),
      ),
    );
  }
}