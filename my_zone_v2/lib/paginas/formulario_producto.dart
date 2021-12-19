import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_zone_v2/objetos/producto.dart';

class formularioProducto extends StatefulWidget {
  String texto;
  Producto? unProducto;
  formularioProducto(this.texto, this.unProducto);

  @override
  _formularioProductoState createState() => _formularioProductoState();
}

class _formularioProductoState extends State<formularioProducto> {
  FirebaseStorage storage = FirebaseStorage.instance;

  final nombre_producto = TextEditingController();
  final descripcion_producto = TextEditingController();
  final negocios_producto = TextEditingController();
  final celular_cliente = TextEditingController();
  final telefono_cliente = TextEditingController();
  final password_cliente = TextEditingController();
  File? imagenProducto = null;
  dynamic url;

  CollectionReference producto =
      FirebaseFirestore.instance.collection("Productos");

  void limpiar() {
    nombre_producto.text = "";
    descripcion_producto.text = "";
    negocios_producto.text = "";
  }

  void initState() {
    if (widget.unProducto != null) {
      nombre_producto.text = widget.unProducto!.nombreProducto;
      descripcion_producto.text = widget.unProducto!.descripcion;
      negocios_producto.text = widget.unProducto!.negociosProducto as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(widget.texto,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Center(
        child: SizedBox(
          height: 800.0,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 30,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Padding(padding: EdgeInsets.all(20.0)),
                  Text(widget.texto,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  _espacio(),
                  _textFieldNombre(),
                  _espacio(),
                  _textFieldDescripcion(),
                  _espacio(),
                  _textFieldNegocio(),
                  _espacio(),
                  _imagen(),
                  SizedBox(
                    child: _verImagen(),
                  ),
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
          controller: nombre_producto,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: InputDecoration(
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: Icon(FontAwesomeIcons.user, color: Colors.amber),
              labelText: "Ingrese el nombre del producto",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFieldDescripcion() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: descripcion_producto,
          keyboardType: TextInputType.emailAddress,
          maxLines: 4,
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
              labelText: "Ingrese la descripcion del producto",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _textFieldNegocio() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: TextField(
          controller: negocios_producto,
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
              labelText: "Ingrese los negocios del producto",
              labelStyle: TextStyle(
                color: Colors.black,
              ),
              filled: true,
              fillColor: Colors.grey[100]),
        ),
      );
    });
  }

  Widget _imagen() {
    return RaisedButton(
      onPressed: _seleccionarImagen,
      child: Text("Seleccion una imagen"),
    );
  }

  Widget _botonAgregar() {
    return FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15.0),
        onPressed: () {
          if (nombre_producto.text.isEmpty ||
              descripcion_producto.text.isEmpty ||
              negocios_producto.text.isEmpty) {
            print("Campos Vacios");
            _toastDialogo("Campos vacios");
          } else {
            _guardarDatos();
          }
          //limpiar();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.lightBlueAccent,
        child: Text("Guardar",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
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

  Future<void> _seleccionarImagen() async {
    var _imagen;
    _imagen = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 500,
      maxWidth: 400,
    );
    setState(() {
      if (_imagen != null) {
        imagenProducto = File(_imagen.path);
      } else {
        print("error no se subio la imagen");
      }
    });
  }

  _verImagen() {
    List<String> id_negocios = negocios_producto.text.split(",");
    if (imagenProducto != null) {
      return Image.file(imagenProducto!);
    } else {
      if (widget.unProducto != null) {
        return FadeInImage.assetNetwork(
          image: widget.unProducto!.fotoProducto,
          height: 500,
          width: 400,
          placeholder: '',
        );
      }
      return Text(
        "Imagen no seleccionada",
        style: TextStyle(fontSize: 25),
      );
    }
  }

  _guardarDatos() {
    List<String> id_negocios = negocios_producto.text.split(",");
    _guardarStorageYFirebase(nombre_producto.text, id_negocios);
  }

  Future<void> _guardarStorageYFirebase(
      String idImagen, List idNegocios) async {
    if (imagenProducto != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("imagenProducto")
          .child(idImagen);
      UploadTask task = ref.putFile(imagenProducto!);
      task.whenComplete(() async {
        try {
          url = await ref.getDownloadURL();
          setState(() {
            url;
          });

          if (widget.unProducto != null) {
            producto.doc(widget.unProducto!.idProducto).update({
              "nombre": nombre_producto.text,
              "descripcion": descripcion_producto.text,
              "negocios_id": idNegocios,
            }).then((_) => Navigator.pop(context));
          } else {
            producto.doc().set({
              "nombre_producto": nombre_producto.text,
              "descripcion": descripcion_producto.text,
              "negocios_id": idNegocios,
              "foto_producto": url
            }).then((_) => Navigator.pop(context));
          }
        } catch (e) {
          print(".......................");
          print(e.toString());
        }
      });
    }
  }
}
