
class Cliente {
  Cliente(this._nombreCliente,this._direccionCliente,this._correoCliente,this._celularCliente,this._telefonoCliente,this._password,this._foto);

  String _nombreCliente = "";
  String _direccionCliente= "";
  String _correoCliente=""; // documento id Clientes
  int _celularCliente=0;
  int _telefonoCliente=0;
  String _password="";
  String _foto="https://firebasestorage.googleapis.com/v0/b/my-zone-v2.appspot.com/o/logo%20app.png?alt=media&token=79c4a5ab-3b49-45c1-8c6a-a6c385f93ac7";


  String get correoCliente => _correoCliente;
  String get nombreCliente => _nombreCliente;
  String get direccionCliente => _direccionCliente;
  int get celularCliente => _celularCliente;
  int get telefonoCliente => _telefonoCliente;
  String get password=>_password;
  String get foto=>_foto;

  setCorreoCliente(String correoCliente) => _correoCliente = correoCliente;
  setNombreCliente(String nombreCliente) => _nombreCliente = nombreCliente;
  setDireccionCliente(String direccionCliente) => _direccionCliente = direccionCliente;
  setCelularCliente(int celularCliente) => _celularCliente = celularCliente;
  setTelefonoCliente(int telefonoCliente) => _telefonoCliente = telefonoCliente;
  setPassword(String password) => _password = password;
  setFoto(String foto) => _foto = foto;

  
  Cliente.inicializar(); 

  
}
