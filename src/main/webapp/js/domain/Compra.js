class Compra {
  constructor() {
   
  }

  static asCompra(jsonCompra) {
    return angular.extend(new Compra(), jsonCompra);
  }
}
