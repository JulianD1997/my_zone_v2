// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/paginas/lista_productos.dart';

class registroCliente extends StatefulWidget {
  @override
  _registroClienteState createState() => _registroClienteState();
  late AuthFirebase auth;
}

class _registroClienteState extends State<registroCliente> {
  final nombre_cliente = TextEditingController();
  final direccion_cliente = TextEditingController();
  final correo_cliente = TextEditingController();
  final celular_cliente = TextEditingController();
  final telefono_cliente = TextEditingController();
  final password_cliente = TextEditingController();
  final AuthFirebase _auth = AuthFirebase();
  

  CollectionReference cliente =
      FirebaseFirestore.instance.collection("Clientes");

  void limpiar() {

    nombre_cliente.text = "";
    direccion_cliente.text = "";
    correo_cliente.text = "";
    celular_cliente.text = "";
    telefono_cliente.text = "";
    password_cliente.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Registro de Clientes",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Center(
        child: SizedBox(
          height: 700.0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 30,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Padding(padding: EdgeInsets.all(20.0)),
                  Text("Nuevo usuario",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  _espacio(),
                  _textFieldNombre(),
                  _espacio(),
                  _textFieldDireccion(),
                  _espacio(),
                  _textFieldCorreo(),
                  _espacio(),
                  _textFieldCelular(),
                  _espacio(),
                  _textFieldTelefono(),
                  _espacio(),
                  _textFielPassword(),
                  _espacio(),
                  _botonAgregar()
                ])),
          ),
        ),
      ),
    ));
  }

  Widget _espacio() => SizedBox(
        height: 15,
      );

  Widget _textFieldNombre() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: nombre_cliente,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: Icon(FontAwesomeIcons.user, color: Colors.amber),
              labelText: "Ingrese su Nombre",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFieldDireccion() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: direccion_cliente,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: Icon(
                FontAwesomeIcons.mapMarked,
                color: Colors.amber,
              ),
              labelText: "Ingrese su Direccion de residencia",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFieldCorreo() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: correo_cliente,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: Icon(
                FontAwesomeIcons.envelopeOpenText,
                color: Colors.amber,
              ),
              labelText: "Ingrese su Correo",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFieldCelular() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: celular_cliente,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: Icon(FontAwesomeIcons.mobileAlt, color: Colors.amber),
              labelText: "Ingrese Su numero de Celular",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFieldTelefono() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: telefono_cliente,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: Icon(FontAwesomeIcons.phoneAlt, color: Colors.amber),
              labelText: "Ingrese su Numero de Telefono",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFielPassword() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: password_cliente,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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

  Widget _botonAgregar() {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15.0),
      onPressed: () async {
        if (nombre_cliente.text.isEmpty ||
            direccion_cliente.text.isEmpty ||
            correo_cliente.text.isEmpty ||
            celular_cliente.text.isEmpty ||
            password_cliente.text.isEmpty) {
          _toastDialogo("Campos vacios");
        } else {
          dynamic result =await _auth.registro(correo_cliente.text, password_cliente.text);
          if (result == null) {
            print("error al crear cliente");
          } else {
            print("cliente creado");
            print(result);
            cliente.doc(correo_cliente.text).set({
              "nombre_cliente": nombre_cliente.text,
              "direccion_cliente": direccion_cliente.text,
              "celular_cliente": int.parse(celular_cliente.text),
              "telefono_cliente": int.parse(telefono_cliente.text),
              "password": password_cliente.text,
              "foto_cliente":"https://firebasestorage.googleapis.com/v0/b/my-zone-v2.appspot.com/o/imagenCliente%2FCliente2%20(2).png?alt=media&token=82d65614-ca5e-47e0-a21b-349fbe813a5a"
            }).then((_) => Navigator.push(context, MaterialPageRoute(builder: (context) => ListaProducto())));
          }
          limpiar();
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.lightBlueAccent,
      child: Text("Guardar",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }

  Future<bool?> _toastDialogo(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 30,
        backgroundColor: Colors.indigo,
        textColor: Colors.black54,
        gravity: ToastGravity.CENTER);
  }
}
