package ar.edu.unsam.dao

import ar.edu.unsam.model.ItemCompra
import ar.edu.unsam.model.OrdenDeCompra
import ar.edu.unsam.model.Proveedor
import java.util.ArrayList
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import java.util.List
import org.neo4j.ogm.cypher.BooleanOperator

class RepositorioOrdenDeCompraNeo4J extends AbstractRepoNeo4J implements IRepositorio<OrdenDeCompra> {

	static var RepositorioOrdenDeCompraNeo4J instance

	private new() {
		
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioOrdenDeCompraNeo4J
		}
		return instance
	}

	override buscarPorEjemplo(OrdenDeCompra ejemplo) {
		var Filters filters = new Filters();
		
		obtenerFiltroTotal(filters , ejemplo)
		obtenerFiltroFecha(filters , ejemplo)
		obtenerFiltrosProveedor(filters , ejemplo)
		
		return new ArrayList( session.loadAll(typeof(OrdenDeCompra), filters , 2) )
	}

	def obtenerFiltroTotal(Filters filters , OrdenDeCompra ejemplo){
		var Filter filtroTotalDesde = new Filter("total", ComparisonOperator.GREATER_THAN, ejemplo.totalDesde);
		var Filter filtroTotalHasta = new Filter("total", ComparisonOperator.LESS_THAN, ejemplo.totalHasta);
		
		if( ejemplo.totalHasta != null ){
			filters.and( filtroTotalHasta )
		} 
		if( ejemplo.totalDesde != null ){
			filters.and( filtroTotalDesde )
		}
		
	}
	
	def obtenerFiltroFecha(Filters filters , OrdenDeCompra ejemplo){
		var Filter filtroFechaDesde = new Filter("fechaDeCompra", ComparisonOperator.GREATER_THAN, ejemplo.fechaDesde);
		var Filter filtroFechaHasta = new Filter("fechaDeCompra", ComparisonOperator.LESS_THAN, ejemplo.fechaHasta);
		
		if( ejemplo.fechaHasta != null ){
			filters.and( filtroFechaHasta )
		}
		if( ejemplo.fechaDesde != null ){
			filters.and( filtroFechaDesde )
		}
		
	}

	def Filters obtenerFiltrosProveedor(Filters filters ,OrdenDeCompra ejemplo) {
		if (ejemplo.proveedor !== null) {
            val Filter filterProveedor = new Filter("codigo", ComparisonOperator.EQUALS, ejemplo.proveedor.codigo)
            filterProveedor.nestedPropertyName = "Proveedor"
            filterProveedor.nestedEntityTypeLabel = "Proveedor"
            filterProveedor.nestedPropertyType = Proveedor
            filterProveedor.relationshipDirection = "INCOMING" // Relationship.INCOMING
            if( !filters.isEmpty ){
				filterProveedor.booleanOperator = BooleanOperator.AND;
			}
            filters.and(filterProveedor)
        }
		
	}

	override buscarPorId(int id) {
		val session = sessionFactory.openSession
		var filtroPorCodigo = new Filter("codigo", ComparisonOperator.EQUALS, id.intValue)
		var ordenesDeCompra = session.loadAll(typeof(OrdenDeCompra), filtroPorCodigo , PROFUNDIDAD_BUSQUEDA_CONCRETA)
		var OrdenDeCompra ordenDeCompra = ( new ArrayList(ordenesDeCompra) ).head
		
		ordenDeCompra.productosComprados.forEach[ item | 
			var itemCompra = session.load(typeof(ItemCompra), item.id_neo4j)
			item.producto = itemCompra.producto
		]
		
		ordenDeCompra 

	}

	override elementos() {
		new ArrayList(session.loadAll(typeof(OrdenDeCompra), 3))

	}

	override agregarNuevo(OrdenDeCompra elemento) {
		val proveedor = RepositorioProveedorNeo4J.instance.buscarPorId(elemento.proveedor.codigo)
		elemento.proveedor = proveedor
		session.save(elemento)
	}

	override actualizar(OrdenDeCompra elemento) {
		val proveedor = RepositorioProveedorNeo4J.instance.buscarPorId(elemento.proveedor.codigo)
		elemento.proveedor = proveedor
		var OrdenDeCompra ordenDeCompraAModificar = buscarPorId(elemento.codigo)
		ordenDeCompraAModificar.productosComprados = obtenerProductoAModificar(elemento)
		session.save(ordenDeCompraAModificar)
//		elemento.id_neo4j = buscarPorId (elemento.codigo).id_neo4j
//		session.save(elemento)
	}
	
	def obtenerProductoAModificar(OrdenDeCompra elemento){
		val List<ItemCompra> productosCompradosNeo4J = newArrayList
		
		elemento.productosComprados.forEach[ 
			item | 
			val productoCompradoNeo4J = RepositorioProductoNeo4J.instance.buscarPorId( item.producto.codigo )
			val itemNeo4J = new ItemCompra()
			itemNeo4J.cantidad = item.cantidad
			itemNeo4J.producto = productoCompradoNeo4J
//			itemNeo4J.calcularCosto
			productosCompradosNeo4J.add( itemNeo4J )
		]
		
		productosCompradosNeo4J
	}

	override vender(Long cantidad, Long idElemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override init(){
		elementos.forEach[ elemento | eliminar(elemento) ]
	}
	
	override eliminar(OrdenDeCompra ordenDeCompra){
		val session = sessionFactory.openSession
		session.delete(ordenDeCompra)
	}


}
