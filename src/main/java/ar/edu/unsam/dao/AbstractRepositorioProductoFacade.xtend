package ar.edu.unsam.dao

import ar.edu.unsam.controller.Repositorios
import java.util.ArrayList
import java.util.List
import java.util.Map
import java.util.HashMap

/**
 * Repositorio de producto en base.
 */
class AbstractRepositorioProductoFacade<T> implements IRepositorio<T> {
	
	protected var Map<Repositorios,IRepositorio<T> > repositorios = new HashMap
	protected var IRepositorio<T> repositorioDefault
	var List<IRepositorio<T> > repositoriosActivos = new ArrayList
	
	protected var List<IRepositorio<T> > todosLosRepositorios
	
	var RepositorioModulosDePersistencia repoModulosDePersistencia = RepositorioModulosDePersistencia.instance
	
	new() {
	}
	
	override init(){
		todosLosRepositorios.forEach[ repo | repo.init ]
	}
	
	def IRepositorio<T> getRepoConsulta(){
		var reposActivos = repoModulosDePersistencia.elementos
		
		if( reposActivos == null || reposActivos.isEmpty ){
			return repositorioDefault
		}
		
		reposActivos.map[ repo | repositorios.get( repo.nombre ) ].head
		
	}
	
	override buscarPorEjemplo(T ejemplo) {
		repoConsulta.buscarPorEjemplo(ejemplo)
	}

	override buscarPorId(int id) {
		repoConsulta.buscarPorId(id)
	}

	override elementos() {
		repoConsulta.elementos
	}

	override agregarNuevo(T elemento) {
		todosLosRepositorios.forEach[ repo | repo.agregarNuevo(elemento) ]
	}
	
	override actualizar(T elemento) {
		todosLosRepositorios.forEach[ repo | repo.actualizar(elemento) ]
	}
	
	override vender(Long cantidad, Long idElemento) {
		todosLosRepositorios.forEach[ repo | repo.vender(cantidad,idElemento) ]
		repoConsulta.buscarPorId(idElemento.intValue)
	}
	
	override eliminar(T elemento){
		todosLosRepositorios.forEach[ repo | repo.eliminar(elemento) ]
	}
	
}
