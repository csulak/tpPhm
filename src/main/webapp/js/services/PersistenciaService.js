class PersistenciaService{
    constructor($http){
        this.$http = $http
    }

    findModulos(callback){
        this.$http.get('http://localhost:9000/persistencia/modulos').then(callback)
    }

    findModulosActivados(callback){
        this.$http.get('http://localhost:9000/persistencia/modulosActivados').then(callback)
    }

    agregarModulo(nombre, callback){
        this.$http.post('http://localhost:9000/persistencia/'+nombre+'/agregar').then(callback)
    }
    
    eliminarModulo(nombre, callback){
        this.$http.delete('http://localhost:9000/persistencia/'+nombre+'/eliminar').then(callback)
    }
    
    moduloActual(callback){
        this.$http.get('http://localhost:9000/persistencia/moduloActual').then(callback)
    }

}