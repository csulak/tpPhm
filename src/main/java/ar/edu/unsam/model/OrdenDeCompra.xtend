package ar.edu.unsam.model

import java.util.Date

import javax.persistence.Column
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.neo4j.ogm.annotation.Relationship
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.mongodb.morphia.annotations.Embedded

@NodeEntity(label="OrdenDeCompra")
@javax.persistence.Entity
@org.mongodb.morphia.annotations.Entity(value="OrdenDeCompra", noClassnameStored=true)
@Accessors
class OrdenDeCompra extends Entidad {

	@org.neo4j.ogm.annotation.Property(name="fechaDeCompra")
	@Column
	@org.mongodb.morphia.annotations.Property("fechaDeCompra")
	Date fechaDeCompra;

	@Relationship(type="PROVEE", direction="INCOMING")
	@ManyToOne()
	@Embedded
	Proveedor proveedor;

	@Relationship(type="ITEMS", direction="INCOMING")
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@Embedded
	List<ItemCompra> productosComprados = newArrayList

	@Property(name="total")
	@Column
	@org.mongodb.morphia.annotations.Property("total")
	double total = 0;

	def void agregarProducto(ItemCompra productoAgregar) {
		productosComprados.add(productoAgregar)
		total = total + productoAgregar.costoTotal
	}

	def Integer getIdProveedor() { return null }

	def Date getFechaDesde() { return null }

	def Date getFechaHasta() { return null }

	def Integer getIdProducto() { return null }

	def Double getTotalDesde() { return null }

	def Double getTotalHasta() { return null }

}
