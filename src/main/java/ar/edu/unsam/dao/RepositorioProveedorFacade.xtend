package ar.edu.unsam.dao

import ar.edu.unsam.controller.Repositorios
import ar.edu.unsam.model.Proveedor

class RepositorioProveedorFacade extends AbstractRepositorioProductoFacade<Proveedor> {

	new() {
		repositorios.put(Repositorios.DOCUMENTOS, RepositorioProveedorMongo.instance)
		repositorios.put(Repositorios.GRAFOS, RepositorioProveedorNeo4J.instance)
		repositorios.put(Repositorios.RELACIONAL, RepositorioProveedorJPA.instance)
		repositorioDefault = RepositorioProveedorMem.instance
		todosLosRepositorios = #[RepositorioProveedorMem.instance, RepositorioProveedorJPA.instance,
			RepositorioProveedorNeo4J.instance, RepositorioProveedorMongo.instance]

		init()

	}

	static var RepositorioProveedorFacade instance

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioProveedorFacade
		}
		return instance
	}

	override init() {
		super.init()

		var proveedor1 = new Proveedor() => [
			codigo = 1
			nombre = "LG"
		]

		var proveedor2 = new Proveedor() => [
			codigo = 2
			nombre = "Samsung"
		]

		var proveedor3 = new Proveedor() => [
			codigo = 3
			nombre = "ProveedorTornoplete"
		]

		var proveedor4 = new Proveedor() => [
			codigo = 4
			nombre = "Dell"
		]
		var proveedor5 = new Proveedor() => [
			codigo = 5

			nombre = "Noblex"
		]
		agregarNuevo(
			proveedor1
		)
		agregarNuevo(
			proveedor2
		)
		agregarNuevo(
			proveedor3
		)

		agregarNuevo(
			proveedor4
		)

		agregarNuevo(
			proveedor5
		)

	}

}
