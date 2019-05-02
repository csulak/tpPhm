class Producto{
 
  constructor(){
    this.id = 1;
    this.descripcion = "";
    this.stockMinimo = 0;
    this.stockMaximo = 0;
    this.stockActual = 0;
    this.costo = 0;
    this.productos = null;
  }

  static asProducto(jsonProduto) {
    return angular.extend(new Producto(), jsonProduto)
  }

}