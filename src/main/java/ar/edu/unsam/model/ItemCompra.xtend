package ar.edu.unsam.model

import javax.persistence.Column
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.ManyToOne
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Relationship
import org.mongodb.morphia.annotations.Embedded
import javax.persistence.Transient

@NodeEntity(label="ItemCompra")
@Entity
@org.mongodb.morphia.annotations.Entity(value="ItemCompra", noClassnameStored=true)
@Accessors
class ItemCompra extends Entidad {
	
	@org.neo4j.ogm.annotation.Property(name="cantidad")
	@Column		
	@org.mongodb.morphia.annotations.Property("cantidad")
	int cantidad;
	
	@org.neo4j.ogm.annotation.Property(name="costoTotal")
	@Column
	@org.mongodb.morphia.annotations.Property("costoTotal")
	Double costoTotal; // Valuado en pesos
	

	@Relationship(type = "CONTIENE", direction = "INCOMING")
	@ManyToOne
	@Embedded
	Producto producto
	
	@Transient
	@org.neo4j.ogm.annotation.Transient
	@org.mongodb.morphia.annotations.Transient
	Integer idProducto;
	
	new(){
		
	}
	
	new (int cant, Producto prod){
		cantidad = cant
		producto = prod
//		costoTotal = this.calcularCosto()
	}
	
	/**
	 * Devuelve un double con la cantidad que se vendio en la linea por el costo del producto
	 */
	def double getCostoTotal(){
		cantidad * producto.costo
	}
	
}