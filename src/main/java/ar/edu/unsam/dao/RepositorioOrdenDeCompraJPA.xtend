package ar.edu.unsam.dao

import ar.edu.unsam.exceptions.BusinessException
import ar.edu.unsam.model.ItemCompra
import ar.edu.unsam.model.OrdenDeCompra
import ar.edu.unsam.model.Producto
import java.util.Calendar
import java.util.GregorianCalendar
import java.util.List
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Predicate
import javax.persistence.criteria.Root

class RepositorioOrdenDeCompraJPA extends RepoJPADefault<OrdenDeCompra> implements IRepositorio<OrdenDeCompra> {

	static var RepositorioOrdenDeCompraJPA instance

	private new() {
//		var OC1 = new OrdenDeCompra() => [
//			var Calendar calendar = new GregorianCalendar(2018, 02, 04);
//			fechaDeCompra = calendar.getTime();
//			proveedor = RepositorioProveedorJPA.instance.buscarPorNombre("LG")
//			agregarProducto(new ItemCompra(1, RepositorioProductoJPA.instance.buscarPorId(1)))
//			agregarProducto(new ItemCompra(1, RepositorioProductoJPA.instance.buscarPorId(2)))
//		]
//
//		var OC2 = new OrdenDeCompra() => [
//			fechaDeCompra = Calendar.getInstance().getTime();
//			proveedor = RepositorioProveedorJPA.instance.buscarPorNombre("Samsung")
//			agregarProducto(new ItemCompra(1, RepositorioProductoJPA.instance.buscarPorId(2)))
//		]
//
//		var OC3 = new OrdenDeCompra() => [
//			fechaDeCompra = Calendar.getInstance().getTime();
//			proveedor = RepositorioProveedorJPA.instance.buscarPorNombre("Proveedor Tornoplete")
//			agregarProducto(new ItemCompra(1, RepositorioProductoJPA.instance.buscarPorId(3)))
//		]
//
//		var OC4 = new OrdenDeCompra() => [
//			fechaDeCompra = Calendar.getInstance().getTime();
//			proveedor = RepositorioProveedorJPA.instance.buscarPorNombre("Dell")
//			agregarProducto(new ItemCompra(1, RepositorioProductoJPA.instance.buscarPorId(4)))
//		]
//
//		var OC5 = new OrdenDeCompra() => [
//			fechaDeCompra = Calendar.getInstance().getTime();
//			proveedor = RepositorioProveedorJPA.instance.buscarPorNombre("LG")
//			agregarProducto(new ItemCompra(1, RepositorioProductoJPA.instance.buscarPorId(5)))
//		]
//		agregarNuevo(
//			OC1
//		)
//		agregarNuevo(
//			OC2
//		)
//		agregarNuevo(
//			OC3
//		)
//
//		agregarNuevo(
//			OC4
//		)
//
//		agregarNuevo(
//			OC5
//		)
//		( buscarPorId(1) as ProductoCompuesto).agregarProducto( buscarPorId(2) )
//		( buscarPorId(1) as ProductoCompuesto).agregarProducto( buscarPorId(3) )
	}

	public static def getInstance() {
		if (instance == null) {
			instance = new RepositorioOrdenDeCompraJPA
		}
		return instance
	}

	override buscarPorEjemplo(OrdenDeCompra ejemplo) {
		this.buscarEjemplo(ejemplo)
	}

	def buscarEjemplo(OrdenDeCompra ejemplo) {

		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(OrdenDeCompra))
			val from = query.from(typeof(OrdenDeCompra))

			val Predicate clausulaProveedor = criteria.and(criteria.equal(from.get("proveedor"), ejemplo.idProveedor))
			//val Predicate clausulaProducto = criteria.and(criteria.equal(from.get("productosComprados"), ejemplo.idProducto))
			val Predicate clausulaFechaDesde = criteria.and(
				criteria.greaterThanOrEqualTo(from.get("fechaDeCompra"), ejemplo.fechaDesde))
			val Predicate clausulaFechaHasta = criteria.and(
				criteria.lessThanOrEqualTo(from.get("fechaDeCompra"), ejemplo.fechaHasta))
			val Predicate clausulaTotalDesde = criteria.and(
				criteria.greaterThanOrEqualTo(from.get("total"), ejemplo.totalDesde))
			val Predicate clausulaTotalHasta = criteria.and(
				criteria.lessThanOrEqualTo(from.get("total"), ejemplo.totalHasta))

			var List<Predicate> predicados = newArrayList

			if (ejemplo.idProveedor !== null) {
				predicados.add(clausulaProveedor)
			}
//			if (ejemplo.idProducto !== 0) {
//				predicados.add(clausulaProducto)
//			}
			if (ejemplo.fechaDesde !== null) {
				predicados.add(clausulaFechaDesde)
			}
			if (ejemplo.fechaHasta !== null) {
				predicados.add(clausulaFechaHasta)
			}
			if (ejemplo.totalDesde !== null) {
				predicados.add(clausulaTotalDesde)
			}
			if (ejemplo.totalHasta !== null) {
				predicados.add(clausulaTotalHasta)
			}
			if (ejemplo.idProducto !== null){
				val joinProducto = from.joinList ("itemCompra", JoinType.LEFT)
				predicados.add(criteria.and(
				criteria.equal(joinProducto.get("producto"), RepositorioProductoJPA.instance.buscarPorId(ejemplo.idProducto))))
				
			}
			if (predicados.length !== 0) {
				query.select(from).where(predicados)

			} else
				(query.select(from)
			)

			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	override buscarPorId(int id) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(OrdenDeCompra))
			val Root<OrdenDeCompra> from = query.from(OrdenDeCompra)
			query.select(from).where(criteria.equal(from.get("codigo"), id))
			entityManager.createQuery(query).singleResult
		} catch (Exception e) {
			throw new BusinessException("Error de busqueda")
		} finally {
			entityManager.close
		}
	}

	def contieneDescripcion(Producto producto, Producto ejemplo) {
		(ejemplo.descripcion === null) || producto.descripcion.contains(ejemplo.descripcion)
	// if (producto !=null && producto.descripcion!=null && ejemplo.descripcion !=null){
	// return producto.descripcion.contains(ejemplo.descripcion)
	// }
	// return true
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

	override elementos() {
		val entityManager = this.entityManager
		try {

			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(typeof(OrdenDeCompra))
			val from = query.from(OrdenDeCompra)

			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager.close
		}
	}

	override agregarNuevo(OrdenDeCompra elemento) {
		val proveedor = RepositorioProveedorJPA.instance.buscarPorId(elemento.proveedor.codigo)
		elemento.proveedor = proveedor
		create(elemento)
	}

	override getEntityType() {
		typeof(OrdenDeCompra)
	}

	/**
	 * aca va el codigo del getcriterio
	 */
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<OrdenDeCompra> query,
		Root<OrdenDeCompra> camposCandidato, OrdenDeCompra t) {

		criteria.greaterThanOrEqualTo(camposCandidato.get("fechaDeCompra"), t.fechaDeCompra)
		criteria.lessThanOrEqualTo(camposCandidato.get("fechaHasta"), t.fechaDeCompra)

	}

	override actualizar(OrdenDeCompra ordenDeCompra) {
		val List<ItemCompra> productosCompradosMongo = newArrayList
		
		ordenDeCompra.productosComprados.forEach[ 
			item | 
			val productoCompradoMongo = RepositorioProductoJPA.instance.buscarPorId( item.producto.codigo )
			val itemJpa = new ItemCompra()
			itemJpa.cantidad = item.cantidad
			itemJpa.producto = productoCompradoMongo
//			itemJpa.calcularCosto
			productosCompradosMongo.add( itemJpa )
		]
		var ordenDeCompraAActualizar = buscarPorId( ordenDeCompra.codigo )
		ordenDeCompraAActualizar.productosComprados = productosCompradosMongo
		
		update(ordenDeCompraAActualizar)
	}
	
	override vender(Long cantidad, Long idElemento) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override init(){
		
	}
	
	override eliminar(OrdenDeCompra ordenDeCompra){
		
	}
	
}
