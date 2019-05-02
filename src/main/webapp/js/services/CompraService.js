class ComprasService{
    constructor($http){
        this.$http = $http
        this.compras =[
            new Compra(1,"cositas","12/10/2017",[]),
            new Compra(2,"cosas","12/10/2017",[]),
            new Compra(3,"fin de mes","29/10/2017",[]),
            new Compra(4,"primero de mes","01/11/2017",[])
        ]
        
    }

    findCompras(callback){
        this.$http.get('http://localhost:9000/orden-de-compra/consulta').then(callback)
    }
    findProductos(callback){
        this.$http.get('http://localhost:9000/orden-de-compra/productos').then(callback)
    }
    findProveedores(callback){
        this.$http.get('http://localhost:9000/orden-de-compra/proveedores').then(callback)
    }

    filtrarCompras(parametrosBusqueda,callback){
        this.$http.post('http://localhost:9000/orden-de-compra/buscar' ,parametrosBusqueda).then(callback)
    }

    crearCompra(compra,successCallback,errorCallback){
        this.$http.put('http://localhost:9000/orden-de-compra/crearCompra', compra).then(successCallback,errorCallback)
    }

    insertarProductos(idcompra, productos,successCallback,errorCallback){
        this.$http.put('http://localhost:9000/orden-de-compra/insertarProductos/' + idcompra, productos).then(successCallback,errorCallback)
    }

    findCompra(idcompra, callback){
        this.$http.get('http://localhost:9000/orden-de-compra/consultaIndividual/'+ idcompra).then(callback)
    }

}

