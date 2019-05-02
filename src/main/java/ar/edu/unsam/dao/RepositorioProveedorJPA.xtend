package ar.edu.unsam.dao

import ar.edu.unsam.model.Proveedor
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepositorioProveedorJPA extends RepoJPADefault<Proveedor> implements IRepositorio<Proveedor> {

	static var RepositorioProveedorJPA instance

	private new() {
		

	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioProveedorJPA
		}
		return instance
	}

	override buscarPorEjemplo(Proveedor ejemplo) {
		searchByExample(ejemplo)
	}

	def buscarPorNombre(String nombre) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(Proveedor))
			val Root<Proveedor> from = query.from(Proveedor)
			query.select(from).where(criteria.like(from.get("nombre"), nombre))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager.close
		}
	}

	override buscarPorId(int id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(Proveedor))
			val Root<Proveedor> from = query.from(Proveedor)
//			from.fetch("promesas", JoinType.LEFT)
//			from.fetch("opiniones", JoinType.LEFT)
			query.select(from).where(criteria.equal(from.get("codigo"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager.close
		}
	}

	override elementos() {
		allInstances
	}

	override agregarNuevo(Proveedor elemento) {
		create(elemento)
	}

	override getEntityType() {
		typeof(Proveedor)
	}

	/**
	 * aca va el codigo del getcriterio
	 */
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Proveedor> query, Root<Proveedor> camposCandidato,
		Proveedor t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override actualizar(Proveedor elemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override vender(Long cantidad, Long idElemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override init(){
		
	}
	
	override eliminar(Proveedor proveedor){
		
	}

}
