package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import org.neo4j.ogm.cypher.BooleanOperator
import ar.edu.unsam.model.OrdenDeCompra
import ar.edu.unsam.model.BuscaOrdenCompra
import ar.edu.unsam.model.ItemCompra

class RepositorioOrdenDeCompraMongo extends AbstractRepositoryMongo<OrdenDeCompra> {

	private static RepositorioOrdenDeCompraMongo instance
	
	def static RepositorioOrdenDeCompraMongo getInstance() {
		if (instance === null) {
			instance = new RepositorioOrdenDeCompraMongo
		}
		instance
	}

	def List<Producto> getProductos(String valor) {
	}
	
	private def getNodosProductos(String valor) {
	}

	def getNodoProductoById(Long id) {
	}

	private def basicSearch(String where) {
	}
	
	override buscarPorId(int id) {
		ds.createQuery(entityType).field("codigo").equal(id).asList.head
	}
	
	def buscarItemCompraPorId(int id) {
		ds.createQuery(ItemCompra).field("codigo").equal(id).asList.head
	}
	
	override elementos() {
		allInstances
	}
	
	override vender(Long cantidad, Long idElemento) {
	}
	
	override buscarPorEjemplo(OrdenDeCompra ejemplo) {
		searchByExample(ejemplo)
	}
	
	override agregarNuevo(OrdenDeCompra elemento) {
		create(elemento)
	}
	
	override actualizar(OrdenDeCompra ordenDeCompra) {
//		val List<ItemCompra> productosCompradosMongo = newArrayList
//		
//		ordenDeCompra.productosComprados.forEach[ 
//			item | 
//			val productoCompradoMongo = RepositorioProductoMongo.instance.buscarPorId( item.producto.codigo )
//			val itemMongo = new ItemCompra()
//			itemMongo.cantidad = item.cantidad
//			itemMongo.producto = productoCompradoMongo
////			itemMongo.calcularCosto
//			productosCompradosMongo.add( itemMongo )
//		]
//		var ordenDeCompraAActualizar = buscarPorId( ordenDeCompra.codigo )
//		ordenDeCompraAActualizar.productosComprados = productosCompradosMongo
		
		ordenDeCompra.id_mongo = buscarPorId( ordenDeCompra.codigo ).id_mongo
		
		update(ordenDeCompra)
	}
	
	override eliminar(OrdenDeCompra elemento){
		delete(elemento)
	}
	
	override init(){
		elementos.forEach[ elemento | eliminar(elemento) ]
	}
	
	override searchByExample(OrdenDeCompra example) {
		var query = ds.createQuery(entityType)
		
		if( example.totalDesde !== null ){
			query = query.field("total").greaterThanOrEq(example.totalDesde)			
		}
		
		if( example.totalHasta !== null ){
			query = query.field("total").lessThanOrEq(example.totalHasta)
		}
		
		if( example.fechaDesde !== null ){
			query = query.field("fechaDeCompra").greaterThanOrEq(example.fechaDesde)			
		}
		
		if( example.fechaHasta !== null ){
			query = query.field("fechaDeCompra").lessThanOrEq(example.fechaHasta)
		}
		
		if( example.proveedor !== null ){
			query = query.field("proveedor.codigo").equal(example.proveedor.codigo)
		}
		
		if( example.idProducto !== null ){
			query = query.field("productosComprados.producto.codigo").equal(example.idProducto)
		}
		
		query.asList
	}
	
	override defineUpdateOperations(OrdenDeCompra ordenDeCompra) {
		val operations = ds.createUpdateOperations(entityType)
		operations.set("productosComprados" , ordenDeCompra.productosComprados)
	}
	
	override getEntityType() {
		return OrdenDeCompra
	}
	
}
