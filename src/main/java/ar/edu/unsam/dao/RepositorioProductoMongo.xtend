package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import java.util.List
import org.mongodb.morphia.query.Query

class RepositorioProductoMongo extends AbstractRepositoryMongo<Producto> {

	private static RepositorioProductoMongo instance
	
	def static RepositorioProductoMongo getInstance() {
		if (instance === null) {
			instance = new RepositorioProductoMongo
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
		var producto = ds.createQuery(entityType).field("codigo").equal(id).asList.head
		producto.initProductos
		producto
	}
	
	override elementos() {
		allInstances
	}
	
	override vender(Long cantidad, Long idElemento) {
		var Producto producto = buscarPorId(idElemento.intValue)
		producto.vender(cantidad)
		update(producto)
		producto
	}
	
	override buscarPorEjemplo(Producto ejemplo) {
			var Query<Producto> query = ds.createQuery(entityType)
			.field("descripcion").containsIgnoreCase(ejemplo.descripcion ?: "")
			
			if(ejemplo.stockMayorA !== null){
				query.field("stockActual").greaterThanOrEq(ejemplo.stockMayorA)
			}
			
			if(ejemplo.stockMenorA !== null){
				query.field("stockActual").lessThanOrEq(ejemplo.stockMenorA)
			}
			
			if(!ejemplo.debajoStockMinimo){
				query.where("this.stockActual >= this.stockMinimo")
			}
			
			query.asList
	}
	
	override agregarNuevo(Producto elemento) {
		create(elemento)
	}
	
	override actualizar(Producto elemento) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override eliminar(Producto elemento){
		delete(elemento)
	}
	
	override init(){
		elementos.forEach[ elemento | eliminar(elemento) ]
	}
	
	override searchByExample(Producto t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override defineUpdateOperations(Producto producto) {
		val operations = ds.createUpdateOperations(entityType)
		operations.set("stockActual" , producto.stockActual)
	}
	
	override getEntityType() {
		return Producto
	}
	
}
