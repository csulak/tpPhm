package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import java.util.List
import ar.edu.unsam.model.OrdenDeCompra
import ar.edu.unsam.model.Proveedor

class RepositorioProveedorMongo extends AbstractRepositoryMongo<Proveedor> {

	private static RepositorioProveedorMongo instance
	
	def static RepositorioProveedorMongo getInstance() {
		if (instance === null) {
			instance = new RepositorioProveedorMongo
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
	
	override elementos() {
		allInstances
	}
	
	override vender(Long cantidad, Long idElemento) {
//		var Producto producto = buscarPorId(idElemento.intValue)
//		producto.vender(cantidad)
//		session.save(producto)
//		producto
	}
	
	override buscarPorEjemplo(Proveedor ejemplo) {
//		var List<Producto> productos = new ArrayList(session.loadAll(typeof(Producto), filtroProductos(ejemplo), PROFUNDIDAD_BUSQUEDA_LISTA))
//		
//		
//		if (!ejemplo.debajoStockMinimo){
//			var List<Producto> prodList = newArrayList
//			for (var i = 0; i < productos.size; i++ ){
//				if (productos.get(i).stockActual>=productos.get(i).stockMinimo){
//					prodList.add(productos.get(i))
//				}
//				
//			}
//			return prodList
//		} else {productos}
	}
	
	override agregarNuevo(Proveedor elemento) {
		create(elemento)
	}
	
	override actualizar(Proveedor elemento) {
//		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override eliminar(Proveedor elemento){
		delete(elemento)
	}
	
	override init(){
		elementos.forEach[ elemento | eliminar(elemento) ]
	}
	
	override searchByExample(Proveedor t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override defineUpdateOperations(Proveedor t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getEntityType() {
		return Proveedor
	}
	
}
