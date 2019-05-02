package ar.edu.unsam.dao

import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import ar.edu.unsam.model.ModuloDePersistencia
import ar.edu.unsam.controller.Repositorios
import java.util.List

class RepositorioModulosDePersistencia extends RepoJPADefault<ModuloDePersistencia>  {
// repositorio de modulos de persistencia activados
	static var RepositorioModulosDePersistencia instance

	private new() {
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioModulosDePersistencia
		}
		return instance
	}

	override getEntityType() {
		typeof(ModuloDePersistencia)
	}

	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<ModuloDePersistencia> query,
		Root<ModuloDePersistencia> camposCandidato, ModuloDePersistencia t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def elementos() {
		allInstances.sortBy[ modulo | - modulo.id_modulo ]
	}
	
	def agregarNuevo(String nombre) {
		var Repositorios repoNombre = Repositorios.valueOf(nombre)
		var ModuloDePersistencia elemento = buscarPorNombre(repoNombre)
		
		if (elemento === null ){
			elemento = new ModuloDePersistencia	
			elemento.setNombre(repoNombre)
			
			create(elemento)
		}

	}
	
	def eliminarModulo(String nombre) {
		var Repositorios repoNombre = Repositorios.valueOf(nombre)
		var ModuloDePersistencia elemento = buscarPorNombre(repoNombre)
		delete(elemento)
	}

	def buscarPorNombre(Repositorios repoNombre) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(ModuloDePersistencia))
			val Root<ModuloDePersistencia> from = query.from(ModuloDePersistencia)
			query.select(from).where(criteria.equal(from.get("nombre"), repoNombre))
			var List<ModuloDePersistencia> lista = entityManager.createQuery(query).resultList
			if (lista !== null && !lista.isEmpty){
				return lista.get(0)
			}
			else{
				return null
			}
		} finally {
			entityManager.close
		}
	}





}
