package ar.edu.unsam.controller

import ar.edu.unsam.dao.IRepositorio
import ar.edu.unsam.dao.RepositorioModulosDePersistencia
import ar.edu.unsam.dao.RepositorioOrdenDeCompraFacade
import ar.edu.unsam.dao.RepositorioProductoFacade
import ar.edu.unsam.dao.RepositorioProveedorFacade
import ar.edu.unsam.model.BuscaOrdenCompra
import ar.edu.unsam.model.ItemCompra
import ar.edu.unsam.model.OrdenDeCompra
import ar.edu.unsam.model.Producto
import ar.edu.unsam.model.Proveedor
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.time.ZoneId
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.XTRest
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import com.google.gson.GsonBuilder
import ar.edu.unsam.dao.RepositorioOrdenDeCompraMem
import ar.edu.unsam.dao.RepositorioOrdenDeCompraMongo

@Controller
class OrdenDeCompraController {

	IRepositorio<Proveedor> repositorioProovedor = RepositorioProveedorFacade.instance
	IRepositorio<Producto> repositorioProducto = RepositorioProductoFacade.instance
	IRepositorio<OrdenDeCompra> repositorioOrdenDeCompra = RepositorioOrdenDeCompraFacade.instance

	extension JSONUtils = new JSONUtils
	Gson gson = new Gson();

	def static void main(String[] args) {
		RepositorioProductoFacade.instance
		RepositorioProveedorFacade.instance
		RepositorioOrdenDeCompraFacade.instance
		
		RepositorioModulosDePersistencia.instance.agregarNuevo(Repositorios.RELACIONAL.name)
		RepositorioModulosDePersistencia.instance.agregarNuevo(Repositorios.GRAFOS.name)
		RepositorioModulosDePersistencia.instance.agregarNuevo(Repositorios.DOCUMENTOS.name)
		
		XTRest.start(9000, ProductoController, OrdenDeCompraController, StockController, PersistenciaController)
	}

	@Get("/orden-de-compra/consulta")
	def Result ordenCompraConsulta() {
		try {

			var List<OrdenDeCompra> compras = new ArrayList<OrdenDeCompra>()

			compras = repositorioOrdenDeCompra.elementos.sortBy[ codigo ]
			response.contentType = ContentType.APPLICATION_JSON
			ok(compras.toJson)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}
	}

	@Get("/orden-de-compra/consultaIndividual/:id")
	def Result ordenCompraConsultaIndividual() {
		try {

			repositorioOrdenDeCompra.elementos
			response.contentType = ContentType.APPLICATION_JSON
			ok(repositorioOrdenDeCompra.buscarPorId(Integer.parseInt(id)).toJson)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}
	}

	@Get("/orden-de-compra/productos")
	def Result productosConsulta() {
		try {
			var List<Producto> productos = new ArrayList<Producto>()
			productos = repositorioProducto.elementos

			response.contentType = ContentType.APPLICATION_JSON
			ok(productos.toJson)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}
	}

	@Get("/orden-de-compra/proveedores")
	def Result proveedoresConsulta() {
		try {

			var List<Proveedor> proveedor = new ArrayList<Proveedor>()

			proveedor = repositorioProovedor.elementos
			response.contentType = ContentType.APPLICATION_JSON
			ok(proveedor.toJson)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}
	}

	@Post("/orden-de-compra/buscar")
	def Result buscarOrdenDeCompra(@Body String body) {
		try {
			var BuscaOrdenCompra buscaOrdenCompra = gson.fromJson(body, BuscaOrdenCompra)
			
			if( buscaOrdenCompra.idProveedor != null ){
				buscaOrdenCompra.proveedor = repositorioProovedor.buscarPorId(buscaOrdenCompra.idProveedor)
			}
			
			var List<OrdenDeCompra> compras = repositorioOrdenDeCompra.buscarPorEjemplo(buscaOrdenCompra)

			response.contentType = ContentType.APPLICATION_JSON
			ok(compras.toJson)
		} catch (Exception e) {
			println(e.message)
			internalServerError(e.message)
		}
	}

	@Put("/orden-de-compra/crearCompra")
	def Result crearOrdenDeCompra(@Body String body) {
		try {
			
			var gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create
			val BuscaOrdenCompra ordenDeCompraJson = gson.fromJson(body,typeof(BuscaOrdenCompra))
			
			var OrdenDeCompra ordenDeCompra = new OrdenDeCompra() => [
				fechaDeCompra = ordenDeCompraJson.fechaDeCompra
				proveedor = repositorioProovedor.buscarPorId( ordenDeCompraJson.idProveedor )
				total = ordenDeCompraJson.total
				codigo = getNextCodigoSequence()
			]
			
			repositorioOrdenDeCompra.agregarNuevo(ordenDeCompra)
			response.contentType = ContentType.APPLICATION_JSON
			ok("{\"IDcompra\":\"" + ordenDeCompra.codigo + "\"}")

		} catch (Exception e) {
			println(e.message)
			internalServerError(e.message)
		}
	}
	
	def getNextCodigoSequence() {
		repositorioOrdenDeCompra.elementos.map[oc | oc.codigo].max + 1
	}

	@Put("/orden-de-compra/insertarProductos/:idCompra")
	def Result insertarProductosOrdenDeCompra(@Body String body) {

		try {
			val OrdenDeCompra ordenDeCompra = repositorioOrdenDeCompra.buscarPorId(Integer.parseInt(idCompra))
			var List<ItemCompra> items = gson.fromJson(body, new TypeToken<List<ItemCompra>>() {}.getType());

			items.forEach[ item | 
				item.producto = repositorioProducto.buscarPorId(item.idProducto)
				ordenDeCompra.agregarProducto( item )
//				item.calcularCosto
			]
			
			repositorioOrdenDeCompra.actualizar(ordenDeCompra)
			response.contentType = ContentType.APPLICATION_JSON
			ok()

		} catch (Exception e) {
			println(e.message)
			internalServerError(e.message)
		}
	}

}
