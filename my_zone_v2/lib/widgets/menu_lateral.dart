import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_zone_v2/objetos/auth_firebase.dart';
import 'package:my_zone_v2/objetos/cliente.dart';
import 'package:my_zone_v2/paginas/configuracion_cuenta.dart';
import 'package:my_zone_v2/paginas/lista_negocios.dart';
import 'package:my_zone_v2/paginas/lista_productos.dart';
import 'package:my_zone_v2/paginas/login.dart';
import 'package:my_zone_v2/paginas/registro_cliente.dart';
import 'package:my_zone_v2/paginas/sesion.dart';
import 'package:my_zone_v2/widgets/listar_negocios.dart';
import 'package:my_zone_v2/widgets/mensajes.dart';

final cliente = FirebaseFirestore.instance.collection("Clientes");

enum Estatus { logeado, noLogueado }

class barraLateral extends StatefulWidget {
  static String id ="barraLateral";
  Cliente unCliente=Cliente.inicializar();
  @override
  _barraLateralState createState() => _barraLateralState();
}

class _barraLateralState extends State<barraLateral> {
  AuthFirebase authFirebase = AuthFirebase();
  Estatus estado = Estatus.noLogueado;
  dynamic correo;

  @override
    void initState() {
    authFirebase.usuarioActual().then((userEmail) {

      setState(() {
        if (userEmail != null) {
          correo = userEmail;
          print(userEmail);
          estado = Estatus.logeado;
          _clienteInicializar();
        } else {
          estado = Estatus.noLogueado;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _estadoCliente(),
          ListTile(
            leading: Icon(FontAwesomeIcons.storeAlt),
            title: Text("Negocios",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListaNegocio()));
            },),
            ListTile(
              leading: Icon(FontAwesomeIcons.shoppingBag),
              title: Text("Productos",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ListaProducto()));
              },),
            ListTile(
              leading: Icon(FontAwesomeIcons.shoppingCart),
              title: Text("Carrito de compras",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: (correo!=null)?(){}:null,),
            ListTile(
              leading: Icon(FontAwesomeIcons.userCog),
              title: Text((correo!=null)?"Configuracion de cuenta":"Crear Cuenta",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: () {
                if(correo!=null){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>ConfiguracionCuenta(correo)));
                }else{
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>registroCliente()));
                }
              },),
              ListTile(
              leading: Icon(FontAwesomeIcons.userCog),
              title: Text((correo!=null)?"Notificaciones":"",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>mensajes()));
              },),
            ListTile(
              leading: Icon(FontAwesomeIcons.userAlt),
              title: Text((correo!=null)?"Cerrar Sesion":"Iniciar Sesion"),
              onTap: () {
                if(correo!=null){
                  authFirebase.cerrarSesion();
                  Navigator.pop(context);
                }else{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(authFirebase)));
                }
              },),
        ],
      ),
    );
  }
  _clienteInicializar() async {
    QuerySnapshot existe =
        await cliente.where(FieldPath.documentId, isEqualTo: correo).get();
    List lista = [];
    if (existe.docs.isNotEmpty) {
      for (var cli in existe.docs) {
        lista.add(cli.data());
      }
      setState(() {
        widget.unCliente.setNombreCliente(lista[0]['nombre_cliente']);
        widget.unCliente.setDireccionCliente(lista[0]['direccion_cliente']);
        widget.unCliente.setCorreoCliente(correo);
        widget.unCliente.setCelularCliente(lista[0]['celular_cliente']);
        widget.unCliente.setTelefonoCliente(lista[0]['telefono_cliente']);
        widget.unCliente.setPassword(lista[0]["password"]);
        widget.unCliente.setFoto(lista[0]["foto_cliente"]);
        });
    }
  }
  
  Widget _estadoCliente() {
    switch (estado) {
      case Estatus.logeado:
      _clienteInicializar();
        return UserAccountsDrawerHeader(
            accountName: Text(widget.unCliente.nombreCliente,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple[700],
                    fontWeight: FontWeight.w900)),
            accountEmail: Text(widget.unCliente.correoCliente,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.purple[700],
                    fontWeight: FontWeight.w900)),
            decoration: BoxDecoration(
              color: Colors.amber,
              border: Border.all(width:5, color: Colors.amber),
              image: const DecorationImage(
                  image: AssetImage("images/drawer_usuario.png"),
                  alignment: FractionalOffset.centerLeft,
                  scale: 0.5
                  ),


            ),
            currentAccountPicture: CircleAvatar(
              radius: 500,
              backgroundColor: Colors.amberAccent,
              backgroundImage:  NetworkImage(widget.unCliente.foto,scale: 10),
            ));
      case Estatus.noLogueado:
        return UserAccountsDrawerHeader(
          accountName: Text(""),
          accountEmail: Text(""),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlue[200],
            border: Border.all(width: 2, color: Colors.amber),
            image: DecorationImage(
                image: AssetImage("images/drawer_usuario.png"),
                alignment: Alignment.center),
          ),
        );
    }
  }
}
class BuscarCliente extends StatelessWidget {
  final String correo;
  BuscarCliente(this.correo);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _Cliente =FirebaseFirestore.instance.collection('Clientes').where(FieldPath.documentId,isEqualTo: correo).snapshots();
    return Center(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(stream: _Cliente,builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshots){
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
                                title: Text(data['nombre_cliente']),
                                subtitle: Text(data['direccion_cliente']),
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