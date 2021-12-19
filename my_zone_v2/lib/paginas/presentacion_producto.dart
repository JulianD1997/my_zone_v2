import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/objetos/producto.dart';
import 'package:my_zone_v2/paginas/tiendas_con_un_producto.dart';

class presentacionProductoPagina extends StatefulWidget {
  final Producto unProducto;
  const presentacionProductoPagina({required this.unProducto});

  @override
  _presentacionProductoPaginaState createState() => _presentacionProductoPaginaState();
}

class _presentacionProductoPaginaState extends State<presentacionProductoPagina> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text(widget.unProducto.nombreProducto,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900)),
              centerTitle: true,
              elevation: 20.0,
            ),
            body: Center(
                child: SizedBox(
                  height: 600.0,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                      elevation: 30,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Card(
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                              color: Colors.greenAccent[400],
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(30,10, 30, 25),
                                    width: 300.0,
                                    height: 300.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          widget.unProducto.fotoProducto),alignment: Alignment.center),
                                      borderRadius:BorderRadius.all(Radius.circular(25.0)),
                                      color: Colors.redAccent
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(30, 10, 30, 30),
                                    child: Text(
                                      widget.unProducto.descripcion,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      )))),
                      floatingActionButton:FloatingActionButton.extended(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductoTiendas(unProducto: widget.unProducto)));
                        },
                        label: Text("Tiendas",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,)),
                        icon: Icon(FontAwesomeIcons.handPointRight),
                      ) ,
                      ));
  }
}