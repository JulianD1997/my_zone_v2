import 'package:flutter/material.dart';

class miCardPresentancion extends StatelessWidget {

  final String foto;
  final String nombre;

  const miCardPresentancion({required this.foto, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      shadowColor: Colors.amber,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),

      elevation: 10,
      color: Colors.lightBlue,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Image.network(foto,alignment: Alignment.center,height: 200, width: 100,),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
              ),
              child: Column(
                children: [
                  Text(nombre),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}