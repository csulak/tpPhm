package ar.edu.unsam.dao

import ar.edu.unsam.controller.Repositorios
import ar.edu.unsam.model.Producto

class RepositorioProductoFacade extends AbstractRepositorioProductoFacade<Producto> {
	
	static var RepositorioProductoFacade instance
	
	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioProductoFacade
		}
		return instance
	}
	
	new(){
		repositorios.put( Repositorios.DOCUMENTOS , RepositorioProductoMongo.instance )
		repositorios.put( Repositorios.GRAFOS , RepositorioProductoNeo4J.instance )
		repositorios.put( Repositorios.RELACIONAL , RepositorioProductoJPA.instance )
	
		repositorioDefault = RepositorioProductoMem.instance
		
		todosLosRepositorios = #[ 
			RepositorioProductoMem.instance , 
			RepositorioProductoJPA.instance , 
			RepositorioProductoNeo4J.instance ,
			RepositorioProductoMongo.instance
		]
		
		init()
	}
	
	override init(){
		
		super.init()
		
		var producto1 = new Producto() => [
			codigo = 1
			descripcion = "MicroChipSmart"
			stockMinimo = 100l
			stockMaximo = 1000l
			stockActual = 500l
			costo = 100.0
		]
		var producto2 = new Producto() => [
			codigo = 2
			descripcion = "SmartTv"
			stockMinimo = 10l
			stockMaximo = 100l
			stockActual = 50l
			costo = 10.0

		]

		var producto3 = new Producto() => [
			codigo = 3
			descripcion = "Tornoplete"
			stockMinimo = 300l
			stockMaximo = 900l
			stockActual = 45l
			costo = 62.5
		]

		var producto4 = new Producto() => [
			codigo = 4
			descripcion = "Notebook"
			stockMinimo = 300l
			stockMaximo = 900l
			stockActual = 450l
			costo = 620.5
		]

		var producto5 = new Producto() => [
			codigo = 5
			descripcion = "Luzled"
			stockMinimo = 1l
			stockMaximo = 10l
			stockActual = 6l
			costo = 6.5
		]
		var producto6 = new Producto() => [
			codigo = 6
			descripcion = "Timbre"
			stockMinimo = 10l
			stockMaximo = 110l
			stockActual = 20l
			costo = 100.0
		]
		
		agregarNuevo(producto1)
		producto2.agregarProducto(this.buscarPorId(1))
		agregarNuevo(producto2)
		agregarNuevo(producto3)
		agregarNuevo(producto4)
		agregarNuevo(producto5)
		agregarNuevo(producto6)
		
	}
	
}