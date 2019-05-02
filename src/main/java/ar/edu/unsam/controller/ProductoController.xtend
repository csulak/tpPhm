package ar.edu.unsam.controller

import ar.edu.unsam.dao.IRepositorio
import ar.edu.unsam.dao.RepositorioProductoNeo4J
import ar.edu.unsam.exceptions.BusinessException
import ar.edu.unsam.model.Producto
import com.google.gson.Gson
import org.apache.commons.lang.StringUtils
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import com.google.gson.GsonBuilder
import ar.edu.unsam.dao.RepositorioProductoFacade
import ar.edu.unsam.dao.RepositorioProductoJPA

@Controller
class ProductoController {
	
	IRepositorio<Producto> repositorioProducto = RepositorioProductoFacade.instance
	
	extension JSONUtils = new JSONUtils
	
	 
	@Get("/producto/:id/detalle")
	def Result produtoDetalle() {
		var producto = repositorioProducto.buscarPorId(new Integer(id) )
		response.contentType = ContentType.APPLICATION_JSON
		var gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation.create;
		ok(gson.toJson(producto))
	}
	
	@Get("/producto/:id/venta/:cantidad")
	def Result ventaProducto() {
		try{
			validarCantidad(cantidad)
			var producto = repositorioProducto.vender( new Long(cantidad) , new Long (id))
			response.contentType = ContentType.APPLICATION_JSON
			ok(producto.toJson)
		} catch( BusinessException be ){
			be.printStackTrace
			internalServerError(be.message)
		}
		
	}
	
	def validarCantidad(String cantidad) {
		if( StringUtils.isBlank(cantidad) || !StringUtils.isNumeric(cantidad) ){
			throw new BusinessException("Cantidad invalida")
		}
	}
	
}
