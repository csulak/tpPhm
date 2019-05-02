package ar.edu.unsam.model

import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.EndNode
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.RelationshipEntity
import org.neo4j.ogm.annotation.StartNode

@RelationshipEntity(type="COMPUESTO_POR")
@Accessors
class CompuestoPor {
	@Id
	@GeneratedValue
	Long id
	
//	@StartNode 
//	Producto productoPadre
	
	@EndNode 
	Producto productoEmbebido
	
	override toString() {
//		productoPadre + " compuesto por " + productoEmbebido
	}
	
}