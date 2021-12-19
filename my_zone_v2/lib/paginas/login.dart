import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/objetos/cliente.dart';
import 'package:my_zone_v2/paginas/lista_productos.dart';
import 'package:my_zone_v2/paginas/registro_cliente.dart';



class Login extends StatefulWidget {
  final AuthFirebase _auth;
  static String id = 'login';

  Login(this._auth);


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final correo_usuario = TextEditingController();
  final password_usuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Iniciar Sesión',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image(),
              SizedBox(
                height: 70,
              ),
              _email(),
              _espacio(),
              _password(),
              _espacio(),
              _loginBotton(),
              botonTexto(),
            ],
          ),
        ),
      ),
    ));
  }
  SizedBox _espacio() {
    return SizedBox(
      height: 20.0,
    );
  }
  Widget botonTexto() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          padding: EdgeInsets.all(20.0),
          child: TextButton(
            onPressed: () => nuevoCliente(context),
            child: Text(
              "No tengo cuenta. Registrarse",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ));
    });
  }

  Widget _email() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: TextField(
          controller: correo_usuario,
          keyboardType: TextInputType.name,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              icon:
                  Icon(FontAwesomeIcons.envelopeOpenText, color: Colors.amber),
              labelText: "Ingrese su correo",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _password() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
        child: TextField(
          controller: password_usuario,
          keyboardType: TextInputType.name,
          obscureText: true,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              icon: Icon(FontAwesomeIcons.key, color: Colors.amber),
              labelText: "Ingrese su contraseña",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _loginBotton() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
            child: Text(
              'Iniciar Sesión',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 10.0,
          color: Colors.lightBlueAccent,
          onPressed: () async {
            await widget._auth.cerrarSesion();
            if (correo_usuario.text.isNotEmpty ||
                password_usuario.text.isNotEmpty) {
                  dynamic result = await widget._auth.login(correo_usuario.text, password_usuario.text);
                  if (result == null) {
                    print("ocurrio un error");
                    }else {
                       print("BIENVENIDO");
                       print(result);
                      Navigator.push(context,MaterialPageRoute(builder: (context) => ListaProducto()));
                }
              }
          });
    });
  }

  Future<bool?> _toastDialogo(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 30,
        backgroundColor: Colors.indigo,
        textColor: Colors.black54,
        gravity: ToastGravity.CENTER);
  }

  Widget _image() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: Image.asset('images/Logo_MyZone.jpeg', height: 150),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.amber,
            border: Border.all(color: Colors.green, width: 4),
            borderRadius: BorderRadius.circular(20)),
      );
    });
  }

  void nuevoCliente(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => registroCliente(),
        ));
  }
}
