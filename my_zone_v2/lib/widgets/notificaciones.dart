import 'package:firebase_messaging/firebase_messaging.dart';
class notificaciones{
  FirebaseMessaging notifica= FirebaseMessaging.instance;
  generarToken (){
    notifica.requestPermission();
    notifica.getToken().then((token) {
      print ('token: ' + token.toString());
    });
  }
}