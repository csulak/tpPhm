class ComprasController {
  constructor(PersistenciaService, ComprasService, $state) {
    this.$state = $state;
    this.ComprasService = ComprasService;
    this.PersistenciaService = PersistenciaService;
    this.compras 
    this.findCompras();
    this.productos = [];
    this.findProductos();
    this.proveedores = [];
    this.findProveedores();
    this.fechaDesde;
    this.fechaDesde2;
    this.fechaHasta;
    this.proveedorSeleccionado = []
    this.productoSeleccionado = []
    this.totalDesde;
    this.totalHasta;
    this.errorMessage;
    this.persistenciaActual = "";
    this.moduloActual();
  }

  moduloActual() {
    this.PersistenciaService.moduloActual(response => {
    	this.persistenciaActual = response.data;
    });
  }
  
  findCompras() {
    this.ComprasService.findCompras(response => {
       this.compras = _.map(response.data, Compra.asCompra);
    });
  }

  findProductos() {
    this.ComprasService.findProductos(response => {
      this.productos = _.map(response.data, Producto.asProducto)
      
    });
  }

  findProveedores() {
    this.ComprasService.findProveedores(response => {
      this.proveedores = _.map(response.data, Proveedor.asProveedor);
    });
  }




  buscar() {
    if(!this.validarFechas()){
      this.errorMessage="Error en la fechas elegidas."
      return false;
    }
    if(!this.validarTotal()){
      this.errorMessage="Error en el rango de totales."
      return false;
    }
    this.errorMessage=''
    this.parametrosBusqueda = {};
    
    if( this.totalDesde ){
    	this.parametrosBusqueda["totalDesde"] = this.totalDesde;
    }
    
    if( this.totalHasta ){
    	this.parametrosBusqueda["totalHasta"] = this.totalHasta;
    }

    if( this.proveedorSeleccionado !== undefined && this.proveedorSeleccionado !== null ){
    	this.parametrosBusqueda["idProveedor"] = this.proveedorSeleccionado.codigo;
    }
    
    if( this.productoSeleccionado !== undefined && this.productoSeleccionado !== null ){
    	this.parametrosBusqueda["idProducto"] = this.productoSeleccionado.codigo;
    }
    
    if( this.fechaDesde !== undefined ){
    	this.parametrosBusqueda["fechaDesde"] = this.fechaDesde;
    }
    
    if( this.fechaHasta !== undefined ){
    	this.parametrosBusqueda["fechaHasta"] = this.fechaHasta;
    }
    
      this.ComprasService.filtrarCompras(this.parametrosBusqueda, response => {
        this.compras = _.map(response.data, Compra.asCompra);
      });
    }
  
  parsearFechas(){
      this.fechaDesde = this.obtenerFecha( $("#fechaDesde").val() );
      this.fechaHasta = this.obtenerFecha( $("#fechaHasta").val() );
  }

  obtenerFecha(valor){
    if (valor) {
      this.parteDesde = valor.split("/");
      return new Date(
        parseInt(this.parteDesde[2], 10),
        parseInt(this.parteDesde[1], 10) - 1,
        parseInt(this.parteDesde[0], 10)
      );
    } else{
      return undefined;  
    }
  }
  
  /*
  * Es Valido ?
  * */
  validarFechas() {
   this.parsearFechas();
    return this.fechaDesde == undefined || this.fechaHasta == undefined || Date.parse(this.fechaDesde) <= Date.parse(this.fechaHasta);
  }

  /**
   * False -> Es invalido
   * True -> Es valido
   */
  validarTotal() {
    return this.isEmpty(this.totalHasta) || this.isEmpty(this.totalDesde) || (parseFloat(this.totalDesde) < parseFloat( this.totalHasta) )
  }
  
  isEmpty(str) {
	return (!str || 0 === str.length);
  }

  nuevaCompra(){
    
  }
  
}