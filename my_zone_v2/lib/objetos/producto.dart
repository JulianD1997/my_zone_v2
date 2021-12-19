import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {

  Producto(this._idProducto,this._nombreProducto,this._fotoProducto,this._negociosProducto,this._descripcionProducto);
  
  String _idProducto;
  String _nombreProducto;
  String _fotoProducto;
  List _negociosProducto; // documento id Clientes
  String _descripcionProducto;
  
  String get idProducto => _idProducto;
  String get nombreProducto => _nombreProducto;
  String get fotoProducto => _fotoProducto;
  List get negociosProducto => _negociosProducto;
  String get descripcion => _descripcionProducto;

}
