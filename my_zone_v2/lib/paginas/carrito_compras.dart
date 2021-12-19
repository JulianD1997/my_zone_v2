import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/paginas/lista_productos.dart';
import 'package:my_zone_v2/paginas/negocio_informacion.dart';
import 'package:my_zone_v2/paginas/productos_negocios.dart';
import 'package:my_zone_v2/widgets/menu_lateral.dart';

class CarritoCompra extends StatefulWidget {
  final List<datosPedido> pedido;
  CarritoCompra({required this.pedido});
  @override
  _CarritoCompraState createState() => _CarritoCompraState();
}

class _CarritoCompraState extends State<CarritoCompra> {
  @override
  void initState() {
    super.initState();
    widget.pedido;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Carrito de compras",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 20.0,
        ),
        drawer: barraLateral(),
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(10, 50, 5, 20),
          child: ListView.builder(
              itemCount: widget.pedido.length,
              itemBuilder: (BuildContext context, i) {
                var cantidad = TextEditingController();
                return SizedBox(
                  child: SingleChildScrollView(
                    child: ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              widget.pedido.removeAt(i);
                            });
                          },
                          icon: Icon(FontAwesomeIcons.trashAlt)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Text(
                                    "Producto",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.pedido[i].nombre_producto,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )),
                          Column(
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text((widget.pedido[i].cantidadProducto == 1)
                                  ? widget.pedido[i].precio_producto.toString()
                                  : widget.pedido[i].totalProducto.toString())
                            ],
                          )
                        ],
                      ),
                      subtitle: Container(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "cantidad total : " +
                                  widget.pedido[i].cantidadProducto.toString()),
                          controller: cantidad,
                          onEditingComplete: () {
                            setState(() {
                              cantidad.text.isEmpty
                                  ? print("vacio")
                                  : widget.pedido[i].setCantidadProducto(
                                      int.parse(cantidad.text));
                              if (widget.pedido[i].cantidadProducto == 1) {
                                var totalProducto =
                                    1 * widget.pedido[i].precio_producto;
                                widget.pedido[i]
                                    .setTotalProducto(totalProducto);
                              } else {
                                var totalProducto = int.parse(cantidad.text) *
                                    widget.pedido[i].precio_producto;
                                widget.pedido[i]
                                    .setTotalProducto(totalProducto);
                              }
                              cantidad.text =
                                  widget.pedido[i].cantidadProducto.toString();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        bottomNavigationBar: confirmar(
          pedidoFinal: widget.pedido,
        ),
      ),
    );
  }
  
}

class confirmar extends StatelessWidget {
  final List<datosPedido> pedidoFinal;
  const confirmar({required this.pedidoFinal});

  @override
  void registrarDetalle(idPedido) {
    AuthFirebase authFirebase = AuthFirebase();
    authFirebase.usuarioActual().then((userEmail) {
      if (userEmail != null) {
        var correo = userEmail;
        CollectionReference detalle = FirebaseFirestore.instance
            .collection("Clientes")
            .doc(correo)
            .collection("Pedidos")
            .doc(idPedido)
            .collection("detalleVentas");
        for (int dato = 0; dato < pedidoFinal.length; dato++) {
          detalle.add({
            "pedido": idPedido,
            "producto": pedidoFinal[dato].nombre_producto,
            "cantidad": pedidoFinal[dato].cantidadProducto,
            "total": pedidoFinal[dato].totalProducto
          });
        }
      } else {}
    });
  }

  void registrar() {
    DateTime hoy = new DateTime.now();
    DateTime fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    int total = 0;
    for (int i = 0; i < pedidoFinal.length; i++) {
      total += pedidoFinal[i].totalProducto;
    }
    AuthFirebase authFirebase = AuthFirebase();
    authFirebase.usuarioActual().then((userEmail) {
      if (userEmail != null) {
        var correo = userEmail;
        CollectionReference pedido = FirebaseFirestore.instance
            .collection("Clientes")
            .doc(correo)
            .collection("Pedidos");
        pedido.add({
          "correo_usuario": correo,
          "negocio": pedidoFinal[1].nombre_negocio,
          "fecha": fecha,
          "total": total
        }).then((value) => registrarDetalle(value.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.amber,
      selectedItemColor: Colors.black,
      selectedFontSize: 18,
      unselectedFontSize: 18,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartPlus, size: 30),
            label: "Agregar\nProducto"),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.solidCheckSquare, size: 30),
            label: "Confirmar\nPedido")
      ],
      onTap: (indice) {
        if (indice == 0) {
          Navigator.pop(context);
        }
        if (indice == 1) {
          int total = 0;
          for (int i = 0; i < pedidoFinal.length; i++) {
            total += pedidoFinal[i].totalProducto;
          }
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(
                      "Confirmar Pedido",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                    contentPadding: EdgeInsets.all(20.0),
                    content: Text("Total a pagar: " + total.toString(),
                        style:
                            TextStyle(color: Colors.redAccent, fontSize: 18)),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            registrar();
                            Fluttertoast.showToast(
                                msg: "Pedido registrado...",
                                toastLength: Toast.LENGTH_LONG,
                                fontSize: 20,
                                backgroundColor: Colors.white,
                                textColor: Colors.amber,
                                gravity: ToastGravity.CENTER);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListaProducto()));
                          },
                          child: Text("Confirmar")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancelar"))
                    ],
                  ));
        }
      },
    );
  }
}
