import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_zone_v2/objetos/producto.dart';
import 'package:my_zone_v2/paginas/presentacion_producto.dart';
import 'package:my_zone_v2/widgets/cart_presentacion.dart';

class BuscarProductos extends StatelessWidget {
  final String _nombreProducto;
  BuscarProductos(this._nombreProducto);

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _productos =FirebaseFirestore.instance.collection('Productos').where("nombre_producto",isEqualTo: _nombreProducto,).snapshots();
    return Center(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(stream: _productos,builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshots){
          
          if(snapshots.hasError){
            return Text("Error");
          }
          if(snapshots.connectionState == ConnectionState.waiting){
            return Text("Cargando Datos");
          }         
          return Center(
            child: ListView(
                  padding: EdgeInsets.all(5),
                  children:snapshots .data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              child: ListTile(
                                title: CartPresentacion(data['foto_producto'], data['nombre_producto']),
                                onTap: () {
                                  print(data['nombre_producto']);
                                  Producto unProducto = Producto(
                                  document.id.toString(),
                                  data['nombre_producto'],
                                  data['foto_producto'],
                                  data['negocios_id'],
                                  data['descripcion']);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> presentacionProductoPagina(unProducto:unProducto)));
                      },
                    ),
                            ),
                          ],
                        ),
                      );
                  }).toList(),
                ),

            );
        },),
      ),
    );
  }
}