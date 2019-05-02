package ar.edu.unsam.controller

import ar.edu.unsam.dao.IRepositorio
import ar.edu.unsam.dao.RepositorioProductoFacade
import ar.edu.unsam.model.BusquedaProducto
import ar.edu.unsam.model.Producto
import com.google.gson.Gson
import java.util.ArrayList
import java.util.List
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils

@Controller
class StockController {

	IRepositorio<Producto> repositorioProducto = RepositorioProductoFacade.instance

	extension JSONUtils = new JSONUtils

	@Get("/stock/consulta")
	def Result stockConsulta() {
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

	@Post("/stock/buscar")
	def Result buscarStockPorEjemplo(@Body String body) {

		try {
			
			var gson = new Gson()
			var BusquedaProducto productoJson = gson.fromJson(body,typeof(BusquedaProducto))

			var List<Producto> productos = new ArrayList<Producto>()

			productos = repositorioProducto.buscarPorEjemplo(productoJson)
			response.contentType = ContentType.APPLICATION_JSON
			ok(productos.toJson)

		} catch (Exception E) {
			println(E.message)
			internalServerError(E.message)
		}
	}

}
