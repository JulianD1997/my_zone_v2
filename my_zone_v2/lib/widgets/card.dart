import 'package:flutter/material.dart';

class miCardImagen extends StatelessWidget {

  final String foto;
  final String nombre;
  final String descripcion;
  final List negocios;

  const miCardImagen({required this.foto, required this.nombre, required this.descripcion,required this.negocios});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
      margin: EdgeInsets.all(20),
      elevation: 10,
      color: Colors.lightBlue,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Column(
          children: [
            Image.network(foto,alignment: Alignment.center,width: 300,),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(

              ),
              child: Column(
                children: [
                  Text(nombre),
                  Text(descripcion)
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}