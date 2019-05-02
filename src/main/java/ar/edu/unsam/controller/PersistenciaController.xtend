package ar.edu.unsam.controller

import ar.edu.unsam.dao.IRepositorio
import ar.edu.unsam.dao.RepositorioProductoJPA
import ar.edu.unsam.model.Producto
import java.util.ArrayList
import java.util.List
import org.uqbar.xtrest.api.Result
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import ar.edu.unsam.dao.RepositorioOrdenDeCompraJPA
import ar.edu.unsam.dao.RepositorioOrdenDeCompraMem
import ar.edu.unsam.model.ModuloDePersistencia
import ar.edu.unsam.dao.RepositorioModulosDePersistencia
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Delete

@Controller
class PersistenciaController {
	// IRepositorio<Producto> repositorioProducto = RepositorioProductoJPA.instance
	var RepositorioModulosDePersistencia repoModulosDePersistencia = RepositorioModulosDePersistencia.instance

	var List<IRepositorio> reposCompra = newArrayList
	extension JSONUtils = new JSONUtils

	new() {

//		reposCompra.add(RepositorioOrdenDeCompraJPA.instance)
		reposCompra.add(RepositorioOrdenDeCompraMem.instance)
	}

	@Get("/persistencia/moduloActual")
	def Result moduloActualConsulta() {
		try {
			var modulos = repoModulosDePersistencia.elementos
			var String moduloActivo
			
			if( modulos != null && !modulos.isEmpty ){
				moduloActivo = modulos.head.nombre.name
			} else {
				moduloActivo = "MEMORIA"
			}
			 
			response.contentType = ContentType.TEXT_PLAIN
			ok(moduloActivo)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}

	}
	
	@Get("/persistencia/modulosActivados")
	def Result componentesActivadosConsulta() {
		try {
			var List<ModuloDePersistencia> modulos = new ArrayList<ModuloDePersistencia>()

			modulos = repoModulosDePersistencia.elementos
			response.contentType = ContentType.APPLICATION_JSON
			ok(modulos.toJson)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}

	}

	@Get("/persistencia/modulos")
	def Result componentesConsulta() {
		try {
			var Repositorios[] repositorios = Repositorios.values

			var List<ModuloDePersistencia> listaDeModulos = newArrayList

			for (var i = 0; i < repositorios.size; i++) {
				var modulo = new ModuloDePersistencia
				modulo.setNombre(repositorios.get(i))
//				modulo.setId(i)
				listaDeModulos.add(modulo)
			}

			response.contentType = ContentType.APPLICATION_JSON
			ok(listaDeModulos.toJson)
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}
	}
	
	
	@Post("/persistencia/:nombre/agregar")
	def Result agregarComponente() {
		try {
			repoModulosDePersistencia.agregarNuevo(nombre)
			response.contentType = ContentType.APPLICATION_JSON
			ok()
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}

	}
	
	@Delete("/persistencia/:nombre/eliminar")
	def Result eliminarComponente() {
		try {
			repoModulosDePersistencia.eliminarModulo(nombre)
			response.contentType = ContentType.APPLICATION_JSON
			ok()
		} catch (Exception E) {
			E.printStackTrace();
			return null;
		}

	}

	def repositoriosCompra() {
		reposCompra
	}
}

enum Repositorios {
	RELACIONAL,
	GRAFOS,
	DOCUMENTOS
}
