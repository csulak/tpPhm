package ar.edu.unsam.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

@Accessors
class BuscaOrdenCompra extends OrdenDeCompra  {

	Integer idProveedor
	Date fechaDesde
	Date fechaHasta
	Integer idProducto
	Double totalDesde
	Double totalHasta

	new() {
	}

}


