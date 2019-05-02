package ar.edu.unsam.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class BusquedaProducto extends Producto {

	Integer stockMayorA
	Integer stockMenorA
	Boolean debajoStockMinimo

	new() {
	}
}

//@Accessors
//class BusquedaProductoNeo4J extends ProductoNeo4J {
//
//	Integer stockMayorA
//	Integer stockMenorA
//	Boolean debajoStockMinimo
//
//	new() {
//	}
//}