package ar.edu.unsam.dao

import org.uqbar.commons.model.CollectionBasedRepo
import ar.edu.unsam.model.Proveedor

class RepositorioProveedorMem extends CollectionBasedRepo<Proveedor> implements IRepositorio<Proveedor> {

	static var RepositorioProveedorMem instance

	private new() {


	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioProveedorMem
		}
		return instance
	}

	override buscarPorId(int id) {
		return searchById(id)
	}

	override searchById(int id) {
		for (Proveedor candidate : this.allInstances()) {
			if (candidate.codigo.equals(id)) {
				return candidate;
			}
		}

		// TODO Mejorar el mensaje de error
		throw new RuntimeException("No se encontró el objeto con el id: " + id);
	// TODO Ver si es mejor redefinir el getId para que te devuelva el codigo y filtre por codigo.
	}

	
	override protected getCriterio(Proveedor example) {
		[ proovedor | proovedor.equals( example ) ]
	}
	
	override createExample() {
		return new Proveedor();
	}
	
	override getEntityType() {
		return Proveedor
	}
	
	override buscarPorEjemplo(Proveedor ejemplo) {
		return searchByExample(ejemplo)
	}
	
	override elementos() {
		objects
	}
	
	override agregarNuevo(Proveedor elemento) {
		effectiveCreate(elemento)
	}
	
	override actualizar(Proveedor elemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override vender(Long cantidad, Long idElemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override init(){
		
	}
	
	override eliminar(Proveedor proveedor){
		
	}
	
}
