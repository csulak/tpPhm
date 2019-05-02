package ar.edu.unsam.model

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.NodeEntity

@NodeEntity(label="Proveedor")
@Entity
@org.mongodb.morphia.annotations.Entity("Proveedor")
@Accessors
class Proveedor extends Entidad{

	@Column(length=150)
	@org.mongodb.morphia.annotations.Property("nombre")
	String nombre;

	new() {
	}

	new(String _nombre) {
		nombre = _nombre
	}
}
