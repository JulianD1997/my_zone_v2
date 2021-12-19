import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthFirebase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future login(String _email, String _password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      User? user= userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('el usuario no existe');
      } else if (e.code == 'wrong-password') {
        print('contraseña equivocada');
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registro(String _email, String _password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      User? user =userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future usuarioActual() async {
    User? user = await firebaseAuth.currentUser;
    if (user != null){
      return user.email;
    }else{
      return null;
    }
  }

  Future cerrarSesion() async {
    return await firebaseAuth.signOut();
  }

  Future eliminarUsuario()async{
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('El usuario debe estar logueado');
        }
    }
  }
}
