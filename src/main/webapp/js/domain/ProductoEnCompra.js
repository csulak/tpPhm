class ItemCompra{
 
  constructor(){
    this.cantidad;
    this.producto = [];
    this.costoTotal
  }

  static asItemCompra(jsonItemCompra) {
    return angular.extend(new ItemCompra(), jsonItemCompra)
  }

}