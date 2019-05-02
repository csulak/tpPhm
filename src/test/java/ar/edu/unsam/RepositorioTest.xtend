package ar.edu.unsam

import ar.edu.unsam.dao.IRepositorio
import ar.edu.unsam.dao.RepositorioProductoMem
import ar.edu.unsam.model.Producto
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.unsam.model.BusquedaProducto

class ReposotorioTest {

	IRepositorio<Producto> repoProducto = RepositorioProductoMem.instance

	@Before
	def void init() {
	}

	/**
	 * Testea que traiga correctamente por id.
	 */
	@Test
	def void testBuscarPorIdOk() {
		Assert.assertEquals(1, repoProducto.buscarPorId(1).id)
	}

	/**
	 * Testea que si el id no existe, no traiga nada.
	 */
	@Test(expected=RuntimeException)
	def void testBuscarPorIdSinResultado() {
		repoProducto.buscarPorId(0)
	}

	/**
	 * Testea que si el id no existe, no traiga nada.
	 */
	@Test
	def void testBuscarPorEjemploTraeMuchosResultados() {
		var ejemplo = new BusquedaProducto() => [
			descripcion = "Producto";
			debajoStockMinimo = false
		]
		Assert.assertTrue((repoProducto.buscarPorEjemplo(ejemplo).length) > 1)
	// sabiendo la cantidad de productos, hacer la comparacion por la cantidad exacta
	}

	/**
	 * Testea que si el id no existe, no traiga nada.
	 */
	@Test
	def void testBuscarPorEjemploTrae1Resultado() {
		var ejemplo = new BusquedaProducto() => [
			descripcion = "1"
			debajoStockMinimo = false
		]
		Assert.assertTrue((repoProducto.buscarPorEjemplo(ejemplo).length) == 1)
	}

	/**
	 * Testea que si el id no existe, no traiga nada.
	 */
	@Test
	def void testBuscarPorEjemploStockMayorAYNoDevuelveResultados() {
		var ejemplo = new BusquedaProducto() => [
			stockMayorA = 10000
			debajoStockMinimo = false
		]		
		Assert.assertTrue((repoProducto.buscarPorEjemplo(ejemplo).length) == 0)
	}

}
