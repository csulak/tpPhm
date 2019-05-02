class Proveedor{
 
  constructor(){
 
  }

  static asProveedor(jsonProveedor) {
    return angular.extend(new Proveedor(), jsonProveedor)
  }

}