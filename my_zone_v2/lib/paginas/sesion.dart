import 'package:flutter/material.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/objetos/producto.dart';
import 'package:my_zone_v2/paginas/lista_productos.dart';
import 'package:my_zone_v2/paginas/login.dart';

enum Estatus{
  logeado,
  noLogueado
}

class EstadoLogin extends StatefulWidget {
  static String id ="estado_login";

  EstadoLogin(this.authFirebase);

  final AuthFirebase authFirebase;

  @override
  _EstadoLoginState createState() => _EstadoLoginState();
}

class _EstadoLoginState extends State<EstadoLogin> {
  @override
  Estatus estado = Estatus.noLogueado;

  @override
  void initState() {
    widget.authFirebase.usuarioActual().then((userId){
      setState(() {
        if(userId!=null){
          estado=Estatus.logeado;
        }else{
          estado=Estatus.noLogueado;
        }
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    switch(estado){
      case Estatus.noLogueado: return Login(widget.authFirebase);
      case Estatus.logeado: return ListaProducto();
    }
  }
}