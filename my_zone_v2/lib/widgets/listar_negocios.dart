import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_zone_v2/objetos/negocio.dart';
import 'package:my_zone_v2/paginas/negocio_informacion.dart';
import 'package:my_zone_v2/widgets/cart_presentacion.dart';

class ListadoNegocio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _negocios =
        FirebaseFirestore.instance.collection('Negocios').snapshots();

    return Center(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _negocios,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.hasError) {
              return Text("Error");
            }
            if (snapshots.connectionState == ConnectionState.waiting) {
              _negocios;
              return Text("Cargando Datos");
            }
            return Center(
              child: ListView(
                padding: EdgeInsets.all(5),
                children: snapshots.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Center(
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                            title: CartPresentacion(
                                data['foto_negocio'], data['nombre_negocio']),
                            onTap: () {
                              Negocio unNegocio=Negocio(document.id,data['nombre_negocio'],data['foto_negocio'], data['direccion_negocio'], data['celular_negocio'], data['telefono_negocio'], data['pagina_web'], data['categoria_negocio'], data['geolocalizacion']);

                              Navigator.push(context, MaterialPageRoute(builder: (context)=> NegocioInformacion(unNegocio:unNegocio)));
                            },
                          ),
                        ),
                      ],
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
