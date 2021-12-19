import 'package:flutter/material.dart';

class CartPresentacion extends StatelessWidget {
  final String foto;
  final String nombre;

  CartPresentacion(this.foto,this.nombre,);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        elevation: 30,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.lightBlue[200],
        child: Row(children: [
            Container(
              padding: EdgeInsets.all(2),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(foto,scale: 0.5),
              )
              ),
              Container(
                  child: Text(nombre,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900), textAlign: TextAlign.right,),
                ),],),
      ),
    );
    }
}