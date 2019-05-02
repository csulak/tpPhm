class CargaCompraController {
  constructor(PersistenciaService,ComprasService, $state, $stateParams) {
    this.ComprasService = ComprasService;
    this.PersistenciaService = PersistenciaService;
    this.$stateParams = $stateParams
    this.compra;
    this.findCompra()
    this.persistenciaActual = "";
    this.moduloActual();
  }

  moduloActual() {
	    this.PersistenciaService.moduloActual(response => {
	    	this.persistenciaActual = response.data;
	    });
	  }
  
  findCompra() {
    this.ComprasService.findCompra(this.$stateParams.id, response => {
     
      this.compra =  Compra.asCompra(response.data)
      
      
    });
  }

 
}
