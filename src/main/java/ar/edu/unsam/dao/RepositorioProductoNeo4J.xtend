package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import org.neo4j.ogm.cypher.BooleanOperator

class RepositorioProductoNeo4J extends AbstractRepoNeo4J implements IRepositorio<Producto>{

	private static RepositorioProductoNeo4J instance
	
	def static RepositorioProductoNeo4J getInstance() {
		if (instance === null) {
			instance = new RepositorioProductoNeo4J
		}
		instance
	}

	def List<Producto> getProductos(String valor) {
//		val transaction = graphDb.beginTx
//		try {
//			getNodosProductos(valor).map [ Node node |
//				node.convertToProducto
//			].toList
//		} finally {
//			cerrarTransaccion(transaction)
//		}
	}
	
	private def getNodosProductos(String valor) {
//		basicSearch("actor.name =~ '(?i).*" + valor + ".*'")
	}

	def getNodoProductoById(Long id) {
//		val transaction = graphDb.beginTx
//		try {
//			basicSearch("ID(actor) = " + id).head.convertToProducto
//		} finally {
//			cerrarTransaccion(transaction)
//		}
	}

	private def basicSearch(String where) {
//		val Result result = graphDb.execute("match (producto:Producto) where " + where + " return producto")
//		val Iterator<Node> producto = result.columnAs("producto")
//		return producto
	}
	
//	override buscarPorEjemplo(Producto ejemplo) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
//	}
	
	override buscarPorId(int id) {
		val session = sessionFactory.openSession
		var filtroPorCodigo = new Filter("codigo", ComparisonOperator.EQUALS, id.intValue)
		var producto = ( new ArrayList(session.loadAll(typeof(Producto), filtroPorCodigo)) ).head
		producto.initProductos
		producto
	}
	
	override elementos() {
		new ArrayList(session.loadAll(typeof(Producto), PROFUNDIDAD_BUSQUEDA_LISTA))
	}
	
//	override agregarNuevo(Producto elemento) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
//	}
	
//	override actualizar(Producto elemento) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
//	}
	
	override vender(Long cantidad, Long idElemento) {
		var Producto producto = buscarPorId(idElemento.intValue)
		producto.vender(cantidad)
		session.save(producto)
		producto
	}
	
	override buscarPorEjemplo(Producto ejemplo) {
		var List<Producto> productos = new ArrayList(session.loadAll(typeof(Producto), filtroProductos(ejemplo), PROFUNDIDAD_BUSQUEDA_LISTA))
		
		
		if (!ejemplo.debajoStockMinimo){
			var List<Producto> prodList = newArrayList
			for (var i = 0; i < productos.size; i++ ){
				if (productos.get(i).stockActual>=productos.get(i).stockMinimo){
					prodList.add(productos.get(i))
				}
				
			}
			return prodList
		} else {productos}
	}
	
	def Filters filtroProductos(Producto ejemplo){
		var List<Filter> filters = newArrayList
		var Boolean hasFilter = false
		var filtroTrue = new Filter("descripcion", ComparisonOperator.MATCHES, ".*")
		
		if (ejemplo.descripcion !== null && !ejemplo.descripcion.isEmpty) {
			var filtroDescripcion = new Filter("descripcion", ComparisonOperator.MATCHES, ".*(?i)" + ejemplo.descripcion + ".*")
			filters.add(filtroDescripcion)
			hasFilter = true
		}
		
		if (ejemplo.stockMayorA !== null) {
			var filtroStockMayorA = new Filter("stockActual", ComparisonOperator.GREATER_THAN_EQUAL, ejemplo.stockMayorA)
			
			if(!hasFilter) {
				hasFilter = true	
			} else {
				filtroStockMayorA.setBooleanOperator(BooleanOperator.AND)
			}
			filters.add(filtroStockMayorA)
		}
	
//		if (!ejemplo.debajoStockMinimo ) {
//				var filtro = new Filter("stockMinimo", ComparisonOperator.GREATER_THAN_EQUAL)
//				var function = new FilterFunction(filtro)
//				var filtroDebajoStockMinimo = new Filter("stockActual", ComparisonOperator.GREATER_THAN_EQUAL, "stockMinimo")
//				restricciones.add(criteria.greaterThanOrEqualTo(from.get("stockActual"),from.get("stockMinimo")))
//			}

			
		if (ejemplo.stockMenorA !== null) {
			var filtroStockMenorA = new Filter("stockActual", ComparisonOperator.LESS_THAN_EQUAL, ejemplo.stockMenorA)
			
			if(!hasFilter) {
				hasFilter = true	
			} else {
				filtroStockMenorA.setBooleanOperator(BooleanOperator.AND)
			}
			filters.add(filtroStockMenorA)
		}
		
		if (filters.size == 1) {
			filtroTrue.setBooleanOperator(BooleanOperator.AND)
			filters.add(filtroTrue)
		} else if (filters.size == 0) {
			return filtroTrue.and(filtroTrue)
		}
		
		new Filters(filters)
	}
	
	override agregarNuevo(Producto elemento) {
		session.save(elemento)
	}
	
	override actualizar(Producto elemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override eliminar(Producto elemento){
		val session = sessionFactory.openSession
		session.delete(elemento)
	}
	
	override init(){
		elementos.forEach[ elemento | eliminar(elemento) ]
	}
	
}
