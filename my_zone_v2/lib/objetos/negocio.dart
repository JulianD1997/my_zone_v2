import 'package:cloud_firestore/cloud_firestore.dart';

class Negocio{

  String _id="";
  String _nombre_negocio="";
  String _foto_negocio="";
  String _direccion_negocio="";
  int _celular_negocio=0;
  int _telefono_negocio=0;
  String _categoria_negocio="";
  String _pagina_web="";
  late GeoPoint posicion;

  String get idNegocio => _id;
  String get nombreNegocio => _nombre_negocio;
  String get fotoNegocio => _foto_negocio;
  String get direccionNegocio => _direccion_negocio;
  int get celularNegocio => _celular_negocio;
  int get telefonoNegocio => _telefono_negocio;
  String get categoriaNegocio => _categoria_negocio;
  String get paginaWeb => _pagina_web;


  Negocio(this._id,this._nombre_negocio, this._foto_negocio, this._direccion_negocio, this._celular_negocio, this._telefono_negocio, this._pagina_web, this._categoria_negocio, this.posicion);
}
