import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_zone_v2/objetos/negocio.dart';
import 'package:my_zone_v2/paginas/productos_negocios.dart';
import 'package:my_zone_v2/widgets/menu_lateral.dart';
import 'package:url_launcher/url_launcher.dart';

class NegocioInformacion extends StatefulWidget {
  Negocio unNegocio;
  NegocioInformacion({required this.unNegocio, Key? key}) : super(key: key);

  @override
  _NegocioInformacionState createState() => _NegocioInformacionState();
}

class _NegocioInformacionState extends State<NegocioInformacion> {
  @override
  Widget build(BuildContext context) {
    late GeoPoint _punto= widget.unNegocio.posicion;
    final posicion = CameraPosition(
      target: LatLng(_punto.latitude,_punto.longitude),
      zoom: 15,
      );
    final Set<Marker> marcador = Set();
    marcador.add(Marker(
      markerId: MarkerId(widget.unNegocio.nombreNegocio),
      position: LatLng(_punto.latitude,_punto.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: InfoWindow(title: widget.unNegocio.nombreNegocio,
        snippet: widget.unNegocio.direccionNegocio),
    ));
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          widget.unNegocio.nombreNegocio,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 20.0,
      ),
      drawer: barraLateral(),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Center(
              child: Text(
                widget.unNegocio.categoriaNegocio,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
                height: 300,
                child: Image(
                  width: 300,
                  height: 300,
                  
                  image: NetworkImage(widget.unNegocio.fotoNegocio),
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              "Direccion : ${widget.unNegocio.direccionNegocio}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: GoogleMap(
                padding: EdgeInsets.all(15),
                initialCameraPosition: posicion,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: true,
                markers: marcador,
                ),
            
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(padding: EdgeInsets.all(2),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.mobileAlt,
                          size: 15,
                        ),
                        Container(
                            child: Text(
                              "Telefono Celular : ${widget.unNegocio.celularNegocio}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                            decoration: BoxDecoration(color: Colors.grey[350])),
                      ],
                    ),
                    VerticalDivider(width: 10),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.phoneAlt,
                          size: 15,
                        ),
                        Container(
                            child: 
                              Text(
                                "Telefono Fijo : ${widget.unNegocio.telefonoNegocio}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700)),
                              decoration: BoxDecoration(
                                color: Colors.grey[350] ,
                            ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(25),),
                    Icon(FontAwesomeIcons.globe),
                    VerticalDivider(width: 2,),
                    Text("Pagina Web : "),
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          _launchURL(widget.unNegocio.paginaWeb);
                        }, 
                        child: Text(widget.unNegocio.paginaWeb)),
                    )
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape:  StadiumBorder(),
                      onPrimary: Colors.white
                    ),
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => ProductoNegocio(unNegocio: widget.unNegocio,)));
                    }, 
                    child: Text("Nuestros productos",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                    )),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  void _launchURL(String url) async {

  String _url = url;
  if (!await launch(_url)) throw 'la direccion $_url no disponible ';
}
}
