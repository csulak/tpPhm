package ar.edu.unsam.dao

import ar.edu.unsam.controller.Repositorios
import ar.edu.unsam.model.OrdenDeCompra
import java.util.Calendar
import java.util.GregorianCalendar
import ar.edu.unsam.model.ItemCompra

class RepositorioOrdenDeCompraFacade extends AbstractRepositorioProductoFacade<OrdenDeCompra> {

	static var RepositorioOrdenDeCompraFacade instance

	new() {
		repositorios.put(Repositorios.DOCUMENTOS, RepositorioOrdenDeCompraMongo.instance)
		repositorios.put(Repositorios.GRAFOS, RepositorioOrdenDeCompraNeo4J.instance)
		repositorios.put(Repositorios.RELACIONAL, RepositorioOrdenDeCompraJPA.instance)
		repositorioDefault = RepositorioOrdenDeCompraMem.instance

		todosLosRepositorios = #[
									RepositorioOrdenDeCompraMem.instance, 
									RepositorioOrdenDeCompraJPA.instance,
									RepositorioOrdenDeCompraNeo4J.instance, 
									RepositorioOrdenDeCompraMongo.instance
								]

		init()
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioOrdenDeCompraFacade
		}
		return instance
	}

	override init() {

		super.init()

		var oc1 = new OrdenDeCompra() => [
			codigo = 1
			var Calendar calendar = new GregorianCalendar(2018, 05, 07);
			fechaDeCompra = calendar.getTime();
			proveedor = RepositorioProveedorFacade.instance.buscarPorId(1)
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(1)))
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(2)))
		]

		var oc2 = new OrdenDeCompra() => [
			codigo = 2
			fechaDeCompra = Calendar.getInstance().getTime();
			proveedor = RepositorioProveedorFacade.instance.buscarPorId(2)
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(2)))
		]

		var oc3 = new OrdenDeCompra() => [
			codigo = 3
			fechaDeCompra = Calendar.getInstance().getTime();
			proveedor = RepositorioProveedorFacade.instance.buscarPorId(3)
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(3)))
		]

		var oc4 = new OrdenDeCompra() => [
			codigo = 4
			fechaDeCompra = new GregorianCalendar(2018, 05, 04).time;
			proveedor = RepositorioProveedorFacade.instance.buscarPorId(4)
			agregarProducto(new ItemCompra(2, RepositorioProductoFacade.instance.buscarPorId(4)))
		]

		var oc5 = new OrdenDeCompra() => [
			codigo = 5
			fechaDeCompra = new GregorianCalendar(2018, 05, 05).time;
			proveedor = RepositorioProveedorFacade.instance.buscarPorId(5)
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(4)))
		]
		
		var oc6 = new OrdenDeCompra() => [
			codigo = 6
			fechaDeCompra = new GregorianCalendar(2018, 05, 06).time;
			proveedor = RepositorioProveedorFacade.instance.buscarPorId(5)
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(4)))
			agregarProducto(new ItemCompra(1, RepositorioProductoFacade.instance.buscarPorId(5)))
		]

		agregarNuevo(oc1)
		agregarNuevo(oc2)
		agregarNuevo(oc3)
		agregarNuevo(oc4)
		agregarNuevo(oc5)
		agregarNuevo(oc6)

	}

}
