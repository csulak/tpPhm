package ar.edu.unsam.model

import ar.edu.unsam.exceptions.BusinessException
import java.util.HashMap
import java.util.List
import java.util.Map
import javax.persistence.CollectionTable
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.FetchType
import javax.persistence.JoinColumn
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Property
import org.neo4j.ogm.annotation.Relationship
import org.neo4j.ogm.annotation.Transient
import com.google.gson.annotations.Expose
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue

@NodeEntity(label="Producto")
@Entity
@Accessors
@org.mongodb.morphia.annotations.Entity
class Producto extends Entidad { 
	
	@Expose
	@Column(length=150)
	@Property(name="descripcion")
	String descripcion;
	
	@Expose
	@Column
	@Property(name="stockMinimo")
	Long stockMinimo;
	
	@Expose
	@Column
	@Property(name="stockMaximo")
	Long stockMaximo;
	
	@Expose
	@Column
	@Property(name="stockActual")
	Long stockActual;
	
	@Expose
	@Column
	@Property(name="costo")
	Double costo; // Valuado en pesos
	
	@ElementCollection(fetch = FetchType.EAGER)
	@CollectionTable(name="ProductosInternos", joinColumns=@JoinColumn(name="producto_id") )
	@Transient
	@org.mongodb.morphia.annotations.Transient
	private Map<Producto,Integer> productosJPA = new HashMap();
		
	@Relationship(type = "COMPUESTO_POR", direction = "OUTGOING")
	@javax.persistence.Transient
	List<Producto> productosNeo4J = newArrayList();
	
	@Expose
	@Transient
	@javax.persistence.Transient
	@org.mongodb.morphia.annotations.Transient
	private Map<Producto,Integer> productos = new HashMap
	
	 def vender(Long cantidad){
	 	if( stockActual - cantidad < stockMinimo ){
			throw new BusinessException("No puede vender " + cantidad + " stock. El stock minimo es " + stockMinimo + " y el actual es " + stockActual + ". ")
		}
		if( cantidad <= 0 ){
			throw new BusinessException("La cantidad debe ser mayor a 0.")
		}
		
	 	this.stockActual = this.stockActual - cantidad;
	 	
	 }
	 
//	 def Map<Producto,Integer> getProductos(){
//	 	productosNeo4J.forEach[ productoNeo4J | agregarProducto( productoNeo4J.productoEmbebido ) ]
//	 	productos;
//	 }
	 
	def Integer getStockMayorA() { return null }
	def Integer getStockMenorA() { return null }
	def Boolean getDebajoStockMinimo() { return null }
	
	override toString() {
		descripcion
	}
	
	def void agregarProducto(Producto producto){//TODO Ver que esto funcione tambien en jpa y neo4j
		agregarProductoGenerico(this.productos,producto);
		agregarProductoGenerico(this.productosJPA,producto);
		
		productosNeo4J.add(producto);
	}
	
	def void agregarProductoGenerico(Map<Producto,Integer> hashmap , Producto producto){//TODO Ver que esto funcione tambien en jpa y neo4j
		if( hashmap.containsKey(producto) ){
			hashmap.put( producto , this.productos.get(producto) + 1 )
		} else {
			hashmap.put( producto , 1 )
		}
	}

	def void descartarLazies() {}
	
	def initProductos(){
		this.productos = productosJPA
		productosNeo4J.forEach[ productoNeo4J | agregarProductoGenerico( this.productosJPA , productoNeo4J ) ]
	}
	
}