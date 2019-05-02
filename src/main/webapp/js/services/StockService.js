class StockService{
    constructor($http){
        this.$http = $http
    }

    findStock(callback){
        //TODO Hacer la llamada correctamente
        this.$http.get('http://localhost:9000/stock/consulta').then(callback)
    }

    filtrarProductos(parametrosBusqueda,callback){
        this.$http.post('http://localhost:9000/stock/buscar',parametrosBusqueda).then(callback)
    }

}

