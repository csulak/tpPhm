package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import org.neo4j.graphdb.Node

class ProductoToNodeConverter {

	def static Producto convertToProducto(Node nodeProducto) {
		new Producto => [
			id = nodeProducto.id.intValue
//			id_producto = nodeProducto.id.intValue
			descripcion = nodeProducto.getProperty("descripcion", "") as String
			stockMinimo = nodeProducto.getProperty("stockMinimo", "") as Long
			stockMaximo = nodeProducto.getProperty("stockMaximo", "") as Long
			stockActual = nodeProducto.getProperty("stockActual", "") as Long
			costo = new Double ( nodeProducto.getProperty("costo", "") as Long )
		]
	}
}
