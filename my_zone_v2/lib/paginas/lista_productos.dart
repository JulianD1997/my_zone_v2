import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/paginas/formulario_producto.dart';
import 'package:my_zone_v2/widgets/buscar_productos.dart';
import 'package:my_zone_v2/widgets/listar_productos.dart';
import 'package:my_zone_v2/widgets/menu_lateral.dart';

class ListaProducto extends StatefulWidget {
  static String id = "lista_productos";

  @override
  _ListaProductoState createState() => _ListaProductoState();
}

class _ListaProductoState extends State<ListaProducto> {
  
  String _producto="";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Lista Productos',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),),
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
              child: _buscarProducto()),
            Expanded(
              child:(_producto.isEmpty)?ListadoProducto():BuscarProductos(_producto)),
          ],
        )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) =>formularioProducto("Nuevo Producto", null)));
        },
        child: Icon(
          FontAwesomeIcons.plus,
          size: 20,
        ),
        backgroundColor: Colors.amber,
      ),));
  }
  Widget _buscarProducto() {
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
            labelText: "Buscar Producto",
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            filled: true,
            fillColor: Colors.grey[100]),
          onChanged: (valor){
            setState(() {
              _producto=valor;
            });
          },
        ),
      );
    });
  }

}