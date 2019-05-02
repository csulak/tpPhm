class ProductoService{
    constructor($http){
        this.$http = $http
    }

    /**
     * Metodo que se llama para buscar un producto en particular.
     * 
     * @param {id del producto a buscar} id 
     * @param {funcion que se llama en caso exitoso} callback 
     */
    findProducto( id , callback){
        this.$http.get('http://localhost:9000/producto/'+id+'/detalle').then(callback)
    }

    /**
     * Metodo que vende productos.
     * 
     * @param {cantidad de productos a vender, debe ser numerico mayor a 0 y menor a stockActual - stockMinimo} cantidad 
     * @param {id del producto a vender} idProducto 
     * @param {funcion que se llama en caso exitoso} callback 
     * @param {funcion que se llama en caso de error} errorHandler 
     */
    vender(cantidad,idProducto,callback,errorHandler){
        this.$http.get('http://localhost:9000/producto/'+idProducto+'/venta/'+cantidad).then(callback , errorHandler)
    }

}

