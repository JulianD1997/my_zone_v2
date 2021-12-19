import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/objetos/negocio.dart';
import 'package:my_zone_v2/objetos/producto.dart';
import 'package:my_zone_v2/paginas/carrito_compras.dart';
import 'package:my_zone_v2/paginas/presentacion_producto.dart';
import 'package:my_zone_v2/widgets/cart_presentacion.dart';

class ProductoNegocio extends StatefulWidget {
  Negocio unNegocio;

  ProductoNegocio({required this.unNegocio});

  @override
  _ProductoNegocioState createState() => _ProductoNegocioState();
}

class _ProductoNegocioState extends State<ProductoNegocio> {
  List<datosPedido> pedidos = [];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productos = FirebaseFirestore.instance
        .collection('Negocios')
        .doc(widget.unNegocio.idNegocio)
        .collection('productos')
        .snapshots();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Productos",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 20.0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Stack(
              children: [
                Positioned(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CarritoCompra(pedido: pedidos)));
                        setState(() {
                          
                        });
                      },
                      icon: Icon(FontAwesomeIcons.shoppingCart)),
                ),
                Positioned(
                    top: 2.0,
                    right: 2.0,
                    child: ClipOval(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            color: Colors.blueAccent,
                            child: (pedidos.isEmpty)
                                ? Text("0")
                                : Text((pedidos.length).toString()))))
              ],
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _productos,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.hasError) {
              return Text("Error");
            }
            if (snapshots.connectionState == ConnectionState.waiting) {
              _productos;
              return Text("Cargando Datos");
            }
            return Center(
              child: ListView(
                padding: EdgeInsets.all(5),
                children: snapshots.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(FontAwesomeIcons.cartPlus),
                        onPressed: () {
                          if (pedidos
                              .where((pedido) =>
                                  pedido.nombre_producto ==
                                  data['nombre_producto'])
                              .isNotEmpty) {
                            print("el pedido ya esta en la lista");
                          } else {
                            setState(() {
                              datosPedido unPedido = datosPedido(
                                  document.id,
                                  widget.unNegocio.idNegocio,
                                  widget.unNegocio.nombreNegocio,
                                  data['nombre_producto'],
                                  data['precio']);
                              pedidos.add(unPedido);
                            });
                          }
                        },
                      ),
                      title: Text(data['nombre_producto']),
                      subtitle: Text(data['precio'].toString()),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class datosPedido {
  String id_producto = '';
  String id_negocio = '';
  String nombre_negocio="";
  String nombre_producto = '';
  int precio_producto = 0;
  int _cantidadProducto=1;
  int _totalProducto=1;

  int get cantidadProducto => _cantidadProducto;
  setCantidadProducto(int cantidadProducto) => _cantidadProducto = cantidadProducto;

  int get totalProducto => _totalProducto;
  setTotalProducto(int totalProducto) => _totalProducto = totalProducto;

  datosPedido(this.id_producto, this.id_negocio,this.nombre_negocio, this.nombre_producto,
      this.precio_producto);
}
