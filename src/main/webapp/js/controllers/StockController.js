class StockController{
    
    constructor(PersistenciaService,StockService,$state){
        this.$state=$state;
        this.StockService = StockService;
        this.PersistenciaService = PersistenciaService;
        this.stock = [];
        this.findStock();
        this.stockMenorA;
        this.stockMayorA;
        this.descripcion;
        this.persistenciaActual = "";
        this.moduloActual();
    }
    
    moduloActual() {
	    this.PersistenciaService.moduloActual(response => {
	    	this.persistenciaActual = response.data;
	    });
	  }
    
    findStock() {
      this.StockService.findStock(response =>{
           this.stock = _.map( response.data , Producto.asProducto)
      });
    }

    buscar() {
        if (this.validarStock()) {
          this.parametrosBusqueda = {
            "descripcion": this.descripcion,
            "stockMayorA": this.stockMayorA,
            "stockMenorA": this.stockMenorA,
            "debajoStockMinimo": ((this.debajoStockMinimo == undefined) ? 'false' : this.debajoStockMinimo)
          };

          this.StockService.filtrarProductos(this.parametrosBusqueda, response => {
            this.stock = _.map(response.data, Producto.asProducto);
          });
        } else {
          alert("ERROR");
        }
      }

      validarStock() {
        console.log(this.stockMenorA)
        if (this.stockMayorA==""){
          this.stockMayorA=undefined;
        }

        if (this.stockMenorA==""){
          this.stockMenorA=undefined;
        }

        if (this.stockMayorA != undefined && this.stockMenorA != undefined){
          return (this.stockMayorA > 0 && this.stockMenorA > 0 && this.stockMenorA > this.stockMayorA)
          
        }else if (this.stockMayorA != undefined){
          return this.stockMayorA > 0
        }else if (this.stockMenorA != undefined){
          return this.stockMenorA > 0
        }else {
          return true
        }
       // return ( this.stockMenorA > this.stockMayorA) || this.stockMayorA== undefined;
      }

}