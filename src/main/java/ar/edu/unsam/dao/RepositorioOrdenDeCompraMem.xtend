package ar.edu.unsam.dao

import ar.edu.unsam.model.OrdenDeCompra
import org.uqbar.commons.model.CollectionBasedRepo

class RepositorioOrdenDeCompraMem extends CollectionBasedRepo<OrdenDeCompra> implements IRepositorio<OrdenDeCompra> {

	static var RepositorioOrdenDeCompraMem instance

	private new() {
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioOrdenDeCompraMem
		}
		return instance
	}

	def contieneProveedor(OrdenDeCompra oc, OrdenDeCompra compra) {
		compra.idProveedor == null || (oc.proveedor.id == compra.idProveedor) || compra.idProveedor == 0
	}

	def entreTotalMaxYMin(OrdenDeCompra oc, OrdenDeCompra compra) {
		(compra.totalDesde < oc.total && oc.total < compra.totalHasta) || compra.totalDesde == compra.totalHasta
	}

	def entreFechaMaxYMin(OrdenDeCompra oc, OrdenDeCompra compra) {
		( compra.fechaDesde === null || compra.fechaDesde < oc.fechaDeCompra ) &&
			( compra.fechaHasta === null || oc.fechaDeCompra < compra.fechaHasta )
	}

	boolean match

	def contienProducto(OrdenDeCompra oc, OrdenDeCompra compra) {
		if (compra != null && compra.idProducto != null && compra.idProducto != 0) {
			match = false
//			oc.productosComprados.forEach[p1, p2|			
//			  if(	p2.producto.equals(RepositorioProductoMem.instance.searchById(Integer.valueOf(compra.idProducto)))){match = true}] 
			return match || compra.idProducto == 0
		}
		return true;
	}

	def int findNuevoMaxID() {
		return elementos.last.id + 1
	}

	override protected getCriterio(OrdenDeCompra example) {
		[ ordenDeCompra |
			this.contieneProveedor(ordenDeCompra, example) && this.entreTotalMaxYMin(ordenDeCompra, example) &&
				this.entreFechaMaxYMin(ordenDeCompra, example) && this.contienProducto(ordenDeCompra, example)
		]
	}

	override createExample() {
		return new OrdenDeCompra();
	}

	override getEntityType() {
		return OrdenDeCompra
	}

	override buscarPorEjemplo(OrdenDeCompra ejemplo) {
		searchByExample(ejemplo)
	}

	override buscarPorId(int id) {
		searchById(id)
	}

	override searchById(int id) {
		for (OrdenDeCompra candidate : this.allInstances()) {
			if (candidate.codigo.equals(id)) {
				return candidate;
			}
		}

		// TODO Mejorar el mensaje de error
		throw new RuntimeException("No se encontró el objeto con el id: " + id);
	// TODO Ver si es mejor redefinir el getId para que te devuelva el codigo y filtre por codigo.
	}

	override elementos() {
		objects
	}

	override agregarNuevo(OrdenDeCompra elemento) {
		effectiveCreate(elemento);
	}

	override actualizar(OrdenDeCompra elemento) {
		update(elemento)
	}

	override vender(Long cantidad, Long idElemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override init() {
	}

	override eliminar(OrdenDeCompra ordenDeCompra) {
	}
}
