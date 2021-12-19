import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/widgets/buscar_negocios.dart';
import 'package:my_zone_v2/widgets/listar_negocios.dart';
import 'package:my_zone_v2/widgets/listar_productos.dart';
import 'package:my_zone_v2/widgets/menu_lateral.dart';

class ListaNegocio extends StatefulWidget {
  static String id = "lista_negocios";

  @override
  _ListaNegocioState createState() => _ListaNegocioState();
}

class _ListaNegocioState extends State<ListaNegocio> {
  
  String _negocio="";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Lista Negocios',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
        centerTitle: true,
        elevation: 20.0,
      ),
      drawer: barraLateral(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: _buscarNegocio()),
            Expanded(
              child:(_negocio.isEmpty)?ListadoNegocio():BuscarNegocios(_negocio)),
          ],
        )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) =>formularioProducto("Nuevo Producto", null)));
        },
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
        backgroundColor: Colors.amber,
      ),));
  }
  Widget _buscarNegocio() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: TextField(
          keyboardType: TextInputType.name,
          autocorrect: true,
          style: TextStyle(fontSize: 20,color: Colors.black,),
          decoration: InputDecoration(
            enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            icon: Icon(FontAwesomeIcons.search, color: Colors.amber),
            labelText: "Buscar Negocio",
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            filled: true,
            fillColor: Colors.grey[100]),
          onChanged: (valor){
            setState(() {
              _negocio=valor;
            });
          },
        ),
      );
    });
  }

}