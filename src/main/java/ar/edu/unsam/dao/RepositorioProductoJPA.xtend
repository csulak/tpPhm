package ar.edu.unsam.dao

import ar.edu.unsam.model.Producto
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root

/**
 * Repositorio de producto en base.
 */
class RepositorioProductoJPA extends RepoJPADefault<Producto> implements IRepositorio<Producto> {

	static var RepositorioProductoJPA instance

	private new() {
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioProductoJPA
		}
		return instance
	}

	def filtrarPorEjemplo(Producto ejemplo) {
		val entityManager = this.entityManager
		var List<Predicate> restricciones = newArrayList;
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(Producto))
			val Root<Producto> from = query.from(Producto)
			if (ejemplo.descripcion !== null && !ejemplo.descripcion.isEmpty) {
				restricciones.add(criteria.like(from.get("descripcion"), "%"+ejemplo.descripcion+"%"))
			}
			
			if (ejemplo.stockMayorA !== null) {
				restricciones.add(criteria.greaterThanOrEqualTo(from.get("stockActual"), ejemplo.stockMayorA))
			}
//		if (!ejemplo.debajoStockMinimo) {
////				restricciones.add(criteria.greaterThanOrEqualTo(from.get("stockActual"),from.get("stockMinimo")))
//			}
			if (ejemplo.stockMenorA !== null) {
				restricciones.add(criteria.lessThanOrEqualTo(from.get("stockActual"), ejemplo.stockMenorA))
			}
			query.select(from).where(criteria.and(restricciones))

			var List<Producto> productos = entityManager.createQuery(query).resultList
			productos.forEach[prod|prod.descartarLazies]
			
			if (!ejemplo.debajoStockMinimo){
				//return productos.map[prod | prod.stockActual>=prod.stockMinimo]
				var List<Producto> prodList = newArrayList
				for (var i = 0; i < productos.size; i++ ){
					if (productos.get(i).stockActual>=productos.get(i).stockMinimo){
						prodList.add(productos.get(i))
					}
					
				}
				return prodList
			} else {productos}
		
		} finally {
			entityManager.close
		}
	}

	override buscarPorEjemplo(Producto ejemplo) {
		filtrarPorEjemplo(ejemplo)
	}

	override buscarPorId(int id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(Producto))
			val Root<Producto> from = query.from(Producto)
//			from.fetch("promesas", JoinType.LEFT)
//			from.fetch("opiniones", JoinType.LEFT)
			query.select(from).where(criteria.equal(from.get("codigo"), id))
			var producto = entityManager.createQuery(query).singleResult
			producto.initProductos
			producto
		} finally {
			entityManager.close
		}
	}

	def contieneDescripcion(Producto producto, Producto ejemplo) {
//		 (ejemplo.descripcion === null) ||  producto.descripcion.contains(ejemplo.descripcion)
	}

	def entreStockMaxYMin(Producto producto, Producto ejemplo) {
//		(ejemplo.debajoStockMinimo || producto.stockActual >= producto.stockMinimo)
//		 &&
//		   (ejemplo.stockMenorA === null || producto.stockActual < ejemplo.stockMenorA) 
//		&& (ejemplo.stockMayorA === null || producto.stockActual > ejemplo.stockMayorA)
	}

	override elementos() {
		allInstances
	}

	override agregarNuevo(Producto elemento) {
		create(elemento)
	}

	override getEntityType() {
		typeof(Producto)
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Producto> query, Root<Producto> camposCandidato,
		Producto t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override actualizar(Producto elemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override vender(Long cantidad, Long idElemento) {
		var producto = buscarPorId( idElemento.intValue )
		producto.vender(cantidad)
		update( producto )
		return producto
	}
	
	override init(){
		
	}
	
	override eliminar(Producto ordenDeCompra){
		
	}
	
}
