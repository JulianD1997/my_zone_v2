import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/objetos/cliente.dart';
import 'package:my_zone_v2/paginas/login.dart';
import 'package:my_zone_v2/widgets/menu_lateral.dart';

class ConfiguracionCuenta extends StatefulWidget {
  String correo;
  ConfiguracionCuenta(this.correo);

  @override
  _ConfiguracionCuentaState createState() => _ConfiguracionCuentaState();
}

class _ConfiguracionCuentaState extends State<ConfiguracionCuenta> {
  AuthFirebase authFirebase = AuthFirebase();
  File? imagenCliente = null;
  dynamic url;

  final direccion_cliente = TextEditingController();
  final celular_cliente = TextEditingController();
  final telefono_cliente = TextEditingController();
  final password_cliente = TextEditingController();
  bool _isEnableDireccion = false;
  bool _isEnableTelefono = false;
  bool _isEnableCelular = false;
  bool _isEnablePassword = false;

  Cliente unCliente = Cliente.inicializar();
  @override
  void initState() {
    clienteInicializar();

    setState(() {
      direccion_cliente.text = unCliente.direccionCliente;
      celular_cliente.text = unCliente.celularCliente.toString();
      telefono_cliente.text = unCliente.telefonoCliente.toString();
      password_cliente.text = unCliente.password;
    });
    super.initState();
  }

  @override
  void dispose() {
    direccion_cliente.dispose();
    celular_cliente.dispose();
    telefono_cliente.dispose();
    password_cliente.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text("Configuracion Cuenta",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
              centerTitle: true,
              elevation: 20.0,
            ),
            body: Center(
              child: ListView(
                padding: EdgeInsets.all(10),
                physics: BouncingScrollPhysics(),
                children: [
                  Center(
                    child: Stack(children: [
                      ClipOval(
                        child: Material(
                          color: Colors.amber,
                          child: Ink.image(
                            alignment: Alignment.topCenter,
                            image: verImagen(),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 4,
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(3),
                            color: Colors.white,
                            child: ClipOval(
                              child: Container(
                                color: Colors.amber,
                                child: IconButton(
                                  onPressed:(){
                                    _seleccionarImagen();
                                    setState(() {
                                      
                                    });
                                  },
                                  icon: Icon(
                                  FontAwesomeIcons.pencilAlt,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                )
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        unCliente.nombreCliente,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(unCliente.correoCliente,
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Direccion",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 300,
                              child: TextField(
                                controller: direccion_cliente,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black87),
                                enabled: _isEnableDireccion,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isEnableDireccion = true;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.pencilAlt,
                                  color: Colors.amber,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Telefono",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 300,
                              child: TextField(
                                controller: telefono_cliente,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black87),
                                enabled: _isEnableTelefono,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isEnableTelefono = true;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.pencilAlt,
                                  color: Colors.amber,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Celular",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 300,
                              child: TextField(
                                controller: celular_cliente,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black87),
                                enabled: _isEnableCelular,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isEnableCelular = true;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.pencilAlt,
                                  color: Colors.amber,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Contraseña",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 300,
                              child: TextField(
                                obscureText:
                                    (_isEnablePassword == false) ? true : false,
                                controller: password_cliente,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black87),
                                enabled: _isEnablePassword,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isEnablePassword = true;
                                  });
                                },
                                icon: Icon(
                                  FontAwesomeIcons.pencilAlt,
                                  color: Colors.amber,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          onPrimary: Colors.white,
                        ),
                        onPressed: (_isEnablePassword == true ||
                                _isEnableTelefono == true ||
                                _isEnableCelular == true ||
                                _isEnableDireccion == true)
                            ? () {
                                if (_isEnablePassword == true ||
                                    _isEnableTelefono == true ||
                                    _isEnableCelular == true ||
                                    _isEnableDireccion == true) {
                                  setState(() {
                                    _isEnableDireccion = false;
                                    _isEnablePassword = false;
                                    _isEnableTelefono = false;
                                    _isEnableCelular = false;
                                  });
                                }
                                _guardarStorageYFirebase(unCliente.correoCliente);
                              }
                            : null,
                        child: Text("Guardar",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ))),
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      child: TextButton(
                        onPressed: () async {
                          await _asyncConfirmDialog(context);

                        },
                        child: Text(
                          "¿Deseo Borrar mi cuenta?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ))
                ],
              ),
            )));
  }

  clienteInicializar() async {
    QuerySnapshot existe = await cliente
        .where(FieldPath.documentId, isEqualTo: widget.correo)
        .get();
    List lista = [];
    if (existe.docs.isNotEmpty) {
      for (var cli in existe.docs) {
        lista.add(cli.data());
      }
      setState(() {
        unCliente.setNombreCliente(lista[0]['nombre_cliente']);
        unCliente.setDireccionCliente(lista[0]['direccion_cliente']);
        unCliente.setCorreoCliente(widget.correo);
        unCliente.setCelularCliente(lista[0]['celular_cliente']);
        unCliente.setTelefonoCliente(lista[0]['telefono_cliente']);
        unCliente.setPassword(lista[0]["password"]);
        unCliente.setFoto(lista[0]["foto_cliente"]);
        direccion_cliente.text = unCliente.direccionCliente;
        celular_cliente.text = unCliente.celularCliente.toString();
        telefono_cliente.text = unCliente.telefonoCliente.toString();
        password_cliente.text = unCliente.password;
      });
    }
  }

  Future _asyncConfirmDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Desea Eliminar la cuenta?'),
          content: const Text('Si desea Eliminar la cuenta oprima Aceptar'),
          actions: [
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
            FlatButton(
              child: const Text('ACEPTAR'),
              onPressed: () {
                authFirebase.eliminarUsuario();
                cliente.doc(widget.correo).delete();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login(authFirebase)));
              },
            )
          ],
        );
      },
    );
  }
 
  Future<void> _seleccionarImagen() async {
    var _imagen;
    _imagen = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    setState(() {
      if (_imagen != null) {
        imagenCliente = File(_imagen.path);
      } else {
        print("error no se subio la imagen");
      }
    });
  }

  verImagen(){
    if(imagenCliente!=null){
       return FileImage(imagenCliente!);
    }else{
      return NetworkImage (unCliente.foto);

    }
  }
  Future<void> _guardarStorageYFirebase(String _correo) async {
    if (imagenCliente != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("imagenCliente")
          .child(_correo);
      UploadTask task = ref.putFile(imagenCliente!);
      task.whenComplete(() async {
        try {
          url = await ref.getDownloadURL();
          setState(() {
            url;
          });
            cliente.doc(_correo).update({

              "direccion_cliente":direccion_cliente.text,
              "foto_cliente": url,
              "password": password_cliente.text,
              "telefono_cliente":int.parse(telefono_cliente.text),
              "celular_cliente":int.parse(celular_cliente.text)

            }).then((_) => Navigator.pop(context));
          } catch (e) {
          print(".......................");
          print(e.toString());
        }
      });
    }
  }
}
