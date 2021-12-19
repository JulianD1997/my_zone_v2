import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/objetos/negocio.dart';
import 'package:my_zone_v2/objetos/producto.dart';
import 'package:my_zone_v2/paginas/lista_negocios.dart';
import 'package:my_zone_v2/paginas/negocio_informacion.dart';

class ProductoTiendas extends StatefulWidget {
  final Producto unProducto;
  const ProductoTiendas({required this.unProducto});

  @override
  _ProductoTiendasState createState() => _ProductoTiendasState();
}

class _ProductoTiendasState extends State<ProductoTiendas> {
  List listaIds = [];
  List listaNegocios = [];
  List listaPrecios =[];
  void initState() {
    super.initState();
    setState(() {
      getNegocio();
      getPrecio();
    });
    
  }

  void getNegocio() async {
    CollectionReference _negocios =
        FirebaseFirestore.instance.collection('Negocios');
    setState(() {
      listaIds = widget.unProducto.negociosProducto;
    });
    for (String _id in listaIds) {
      print(_id);
      QuerySnapshot negocio =await _negocios.where(FieldPath.documentId, isEqualTo: _id).get();
      if (negocio.docs.isNotEmpty) {
        for (var neg in negocio.docs) {
          setState(() {
            listaNegocios.add(neg.data());
          });
        }
      } else {
        print("No hay Negocios con ese producto");
      }
    }
  }
  void getPrecio() async{
    CollectionReference _negocios =FirebaseFirestore.instance.collection('Negocios');
    for(String _id in listaIds){

      QuerySnapshot _precioProducto = await _negocios.doc(_id).collection("productos").where('nombre_producto',isEqualTo: widget.unProducto.nombreProducto).get();
      if(_precioProducto.docs.isNotEmpty){
        for(var pre in _precioProducto.docs){
          setState(() {
            listaPrecios.add(pre.data());
          });
        }
      }else{
        print("nada");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amber,
              title: Text(
                "tiendas con " + widget.unProducto.nombreProducto,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
              elevation: 20.0,
            ),
            body: Center(
                child: ListView.builder(
                    itemCount: listaPrecios.length,
                    itemBuilder: (BuildContext context,i) {
                      return ListTile(
                        title: _miCardPresentacion(
                            listaNegocios[i]['foto_negocio'],
                            listaNegocios[i]['nombre_negocio'],
                            listaNegocios[i]['categoria_negocio'],
                            listaNegocios[i]['celular_negocio'],
                            listaPrecios[i]['precio']
                            ),
                        onTap:(){
                          print(listaNegocios);
                          Negocio unNegocio=Negocio(listaIds[i],listaNegocios[i]['nombre_negocio'], listaNegocios[i]['foto_negocio'], listaNegocios[i]['direccion_negocio'], listaNegocios[i]['celular_negocio'], listaNegocios[i]['telefono_negocio'], listaNegocios[i]['pagina_web'], listaNegocios[i]['categoria_negocio'], listaNegocios[i]['geolocalizacion']);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> NegocioInformacion(unNegocio:unNegocio)));
                        }
                      );
                    }))));
  }

  SizedBox _miCardPresentacion(String _url, String _nombre,String _categoria,int _celular,int _precio) {
    return SizedBox(
        height: 550.0,
        child: Card(
            margin: EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            elevation: 30,
            child: Center(
              child: Card(
                elevation: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Colors.limeAccent[400],
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Text(_categoria,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 15),
                      width: 300.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_url),
                              alignment: Alignment.center),
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)),
                          color: Colors.redAccent),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                      child: Text(_nombre,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30,0, 30, 10),
                      child: Text(widget.unProducto.nombreProducto+" precio : "+_precio.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30,0, 30, 10),
                      child: Text("Numero de celular : "+_celular.toString(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}