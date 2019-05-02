class CrearOrdenDeCompraController {
  constructor(PersistenciaService, ComprasService, $state) {
    this.$state = $state
    this.compra;
    this.productosComprados = [];
    this.productoCompradosRequest = [];
    this.ComprasService = ComprasService;
    this.PersistenciaService = PersistenciaService;
    this.productos = [];
    this.findProductos();
    this.proveedores = [];
    this.findProveedores();

    this.productoSeleccionado = [];
    this.cantidad;
    this.total = 0;
    this.id;
    this.successMessage = ''
    this.persistenciaActual = "";
    this.moduloActual();
  }

  moduloActual() {
    this.PersistenciaService.moduloActual(response => {
    	this.persistenciaActual = response.data;
    });
  }
  
  findProductos() {
    this.ComprasService.findProductos(response => {
      this.productos = _.map(response.data, Producto.asProducto);
    });
  }

  findProveedores() {
    this.ComprasService.findProveedores(response => {
      this.proveedores = _.map(response.data, Proveedor.asProveedor);
    });
  }

  agregarItem() {
    this.productosComprados.push({
      cantidad: this.cantidad,
      producto: this.productoSeleccionado,
      idProducto: this.productoSeleccionado.codigo,
      costoTotal: this.cantidad * this.productoSeleccionado.costo
    });
    
    this.total =
      this.total +
      parseInt(this.cantidad, 10) * parseFloat(this.productoSeleccionado.costo);
  }

  aceptar() {
    this.compra = {
      fechaDeCompra: $("#fechaDeCompra").val(),
      idProveedor: this.proveedorSeleccionado.codigo,
      total: this.total
    };
    this.ComprasService.crearCompra(this.compra, responseCrearCompra => {
    	this.popularProductosCompradosRequest();
		this.idCompra = responseCrearCompra.data.IDcompra,

		this.ComprasService.insertarProductos(this.idCompra , this.productoCompradosRequest ,
			responseInsertarProductos => { this.successMessage = "Se registro la compra correctamente." },
			responseInsertarProductos => { this.errorMessage = "Ocurrio un error al insertar los productos." }
		);
    },
    responseCrearCompra => { this.errorMessage = "Ocurrio un error al crear la orden de compra" });
    
  }
  
  popularProductosCompradosRequest() {
	  this.productoCompradosRequest = [];
	  
		for( var i = 0 ; i < this.productosComprados.length ; i++ ){
			this.productoCompradosRequest.push({
				cantidad: this.productosComprados[i].cantidad,
				idProducto: this.productosComprados[i].producto.codigo,
				costoTotal: this.productosComprados[i].costoTotal
			})
		}
  }
  
  eliminar(itemCompra) {
    this.total =   this.total - parseFloat(itemCompra.costoTotal);
    this.productosComprados.splice(
      this.productosComprados.indexOf(itemCompra),
      1
    );
  }
}
