class PersistenciaController{
    
    constructor(PersistenciaService,$state,$location,$stateParams){
        this.$state=$state;
        this.$stateParams = $stateParams
        this.$location = $location;
        this.PersistenciaService = PersistenciaService;
        this.findModulos();
        this.successMessage = null;
        this.errorMessage = null;
        this.modulos = null;
        this.moduloSeleccionado = null;
        this.findModulosActivados();
        this.modulosActivados = null;
    }

    findModulos(){
        this.PersistenciaService.findModulos((response)=>{
            this.modulos = _.map(response.data, ModuloDePersistencia.asModuloDePersistencia)
        })
    }

    findModulosActivados(){
        this.PersistenciaService.findModulosActivados((response)=>{
            this.modulosActivados = _.map(response.data, ModuloDePersistencia.asModuloDePersistencia)
        })
    }

    agregarModulo(){
        if(this.validarModuloSeleccionado()){
        this.PersistenciaService.agregarModulo(this.moduloSeleccionado.nombre, (response)=>{this.findModulosActivados()})
        }   
    }
    
    validarModuloSeleccionado(){
        return this.moduloSeleccionado!=null ? this.modulosActivados.indexOf(this.moduloSeleccionado)<0 : false
    }
    
    eliminarModulo(nombreModuloAEliminar){
    	if( nombreModuloAEliminar ){
    		this.PersistenciaService.eliminarModulo(nombreModuloAEliminar, (response)=>{this.findModulosActivados()});
    	}
    }

}

