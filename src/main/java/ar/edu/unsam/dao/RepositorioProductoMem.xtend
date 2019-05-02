package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import org.uqbar.commons.model.CollectionBasedRepo

/**
 * Repositorio de producto en memoria.
 */
class RepositorioProductoMem extends CollectionBasedRepo<Producto> implements IRepositorio<Producto>{
	
	static var RepositorioProductoMem instance
	
	private new(){
	}
	
	public static def getInstance(){
		if( instance == null ){
			instance = new RepositorioProductoMem
		}
		return instance
	}
	
	override protected getCriterio(Producto example) {
		[ producto | return contieneDescripcion(producto, example) && this.entreStockMaxYMin(producto, example) ]
	}
	
	override createExample() {
		return new Producto();
	}
	
	override getEntityType() {
		return Producto;
	}
	
	override buscarPorEjemplo(Producto ejemplo) {
		//var List<Producto> lista = new ArrayList()
		//lista=searchByExample(ejemplo)
		searchByExample(ejemplo)
		//return lista
	}
	
	override buscarPorId(int id) {
		searchById(id)
	}
	
	override searchById(int id){
		for (Producto candidate : this.allInstances()) {
			if (candidate.codigo.equals(id)) {
				return candidate;
			}
		}

		// TODO Mejorar el mensaje de error
		throw new RuntimeException("No se encontró el objeto con el id: " + id);
		//TODO Ver si es mejor redefinir el getId para que te devuelva el codigo y filtre por codigo.
	}
	
	
	def contieneDescripcion(Producto producto, Producto ejemplo) {
		 (ejemplo.descripcion === null) ||  producto.descripcion.contains(ejemplo.descripcion)
	//	if (producto !=null && producto.descripcion!=null && ejemplo.descripcion !=null){
	//	return producto.descripcion.contains(ejemplo.descripcion)
		
		//}
		//return true
	}

	def entreStockMaxYMin(Producto producto, Producto ejemplo) {
		(ejemplo.debajoStockMinimo || producto.stockActual >= producto.stockMinimo)
		 &&
		   (ejemplo.stockMenorA === null || producto.stockActual < ejemplo.stockMenorA) 
		&& (ejemplo.stockMayorA === null || producto.stockActual > ejemplo.stockMayorA)
//		((ejemplo.debajoStockMinimo && producto.stockActual < ejemplo.stockMenorA) && producto.stockActual > ejemplo.stockMayorA) || ejemplo.stockMenorA == ejemplo.stockMayorA
//		( bp.stockMenorA != null && (prod.stockActual < bp.stockMenorA) ) && ( bp.stockMayorA != null && (prod.stockActual > bp.stockMayorA) )
	}
	
	override elementos() {
		objects
	}
	
	override agregarNuevo(Producto elemento) {
		effectiveCreate(elemento)
	}
	
	override actualizar(Producto elemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override vender(Long cantidad, Long idElemento){
		var producto = buscarPorId( idElemento.intValue )
		producto.vender(cantidad);
		return producto
	}
	
	override init(){
		
	}
	
	override eliminar(Producto ordenDeCompra){
		
	}
	
}