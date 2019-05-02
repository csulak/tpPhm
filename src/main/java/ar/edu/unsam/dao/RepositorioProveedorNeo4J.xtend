package ar.edu.unsam.dao

import java.util.ArrayList
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters
import ar.edu.unsam.model.Proveedor

class RepositorioProveedorNeo4J extends AbstractRepoNeo4J implements IRepositorio<Proveedor> {

	static var RepositorioProveedorNeo4J instance

	private new() {
	
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioProveedorNeo4J
		}
		return instance
	}

	override buscarPorEjemplo(Proveedor ejemplo) {
		return new ArrayList(session.loadAll(typeof(Proveedor), filtroEjemplo(ejemplo), PROFUNDIDAD_BUSQUEDA_LISTA))
	}

	def Filters filtroEjemplo(Proveedor ejemplo) {
		// Construyo un filtro que no filtra, para que filtroPeliculas devuelva siempre Filters
		var filtroTrue = new Filter("nombre", ComparisonOperator.MATCHES, ".*")
		val filtroNombre = new Filter("nombre", ComparisonOperator.MATCHES, ".*(?i)" + ejemplo.nombre + ".*")

		filtroTrue.and(filtroNombre)
	}

	def buscarPorNombre(String nombre){
		val session = sessionFactory.openSession
		val filtroPorNombre = new Filter("nombre", ComparisonOperator.CONTAINING, nombre)
		return new ArrayList(session.loadAll(typeof(Proveedor), filtroPorNombre)).get(0)
	}

	override buscarPorId(int id) {
		val session = sessionFactory.openSession
		var filtroPorCodigo = new Filter("codigo", ComparisonOperator.EQUALS, id.intValue)
		var proveedor = ( new ArrayList(session.loadAll(typeof(Proveedor), filtroPorCodigo)) ).head
		
		proveedor
		//session.load(typeof(Proveedor), new Long (id), PROFUNDIDAD_BUSQUEDA_CONCRETA)
	}

	override elementos() {
		new ArrayList(session.loadAll(typeof(Proveedor), PROFUNDIDAD_BUSQUEDA_LISTA))
	}

	override agregarNuevo(Proveedor elemento) {
		session.save(elemento)
	}

	override actualizar(Proveedor elemento) {
		session.save(elemento)
	}

	override vender(Long cantidad, Long idElemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override init(){
		elementos.forEach[ elemento | eliminar(elemento)]
		
	}
	
	override eliminar(Proveedor proveedor){
		val session = sessionFactory.openSession
		session.delete(proveedor)
	}
	
	
	
}
