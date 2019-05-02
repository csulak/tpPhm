	class ProductoController{
    
    constructor(PersistenciaService,ProductoService,$state,$location,$stateParams){
        this.$state=$state;
        this.$stateParams = $stateParams
        this.$location = $location;
        this.ProductoService = ProductoService;
        this.PersistenciaService = PersistenciaService;
        this.producto ={};
        this.cantidad = 1;
        this.findProducto();
        this.successMessage = null;
        this.errorMessage = null;
        this.persistenciaActual = "";
        this.moduloActual();
    }
    
    moduloActual() {
	    this.PersistenciaService.moduloActual(response => {
	    	this.persistenciaActual = response.data;
	    });
	  }
    
    findProducto(){
      this.ProductoService.findProducto( this.$stateParams.id , (response)=>{
           this.producto = Producto.asProducto( response.data )
      })
    }

    /**
     * Cheque que la venta no supere la maxima permitida.
     */
    esVentaInvalida(){
        return this.producto.stockActual - this.cantidad < this.producto.stockMinimo;
    }

    /**
     * Vende un producto.
     */
    vender(){
        if( this.esVentaInvalida() ){
            this.successMessage = null;
            this.errorMessage = "La cantidad es muy grande, no puede quedarse sin stock minimo.";
            return;
        }
        if( this.cantidad <= 0 ){
            this.successMessage = null;
            this.errorMessage = "La cantidad debe ser mayor a 0.";
            return;
        }
        this.ProductoService.vender( this.cantidad , this.producto.codigo ,
            (response)=>{
                this.producto = response.data;
                this.successMessage = "Se ha vendido con exito " + this.cantidad + " productos.";
                this.errorMessage = null;
            },
            (response)=>{
                this.successMessage = null;
                this.errorMessage = "Error al vender " + this.cantidad +" productos. Mensaje de error : '" + response.data + "'"
           })
    }

    /**
     * Limpia los mensajes y vuelve a la pantalla anterior
     */
    volver(){
        this.successMessage = null;
        this.errorMessage = null;
        this.$location.path('/stock');
    }
    
    esProductoCompuesto(){
    	return ( this.producto.productos != null && !this.isEmpty(this.producto.productos) );
    }
    
    isEmpty(obj) {
        for(var prop in obj) {
            if(obj.hasOwnProperty(prop))
                return false;
        }
        return true;
    }	

}