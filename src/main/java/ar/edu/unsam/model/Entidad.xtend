package ar.edu.unsam.model

import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.neo4j.ogm.annotation.Transient
import org.neo4j.ogm.annotation.NodeEntity
import org.uqbar.commons.model.Entity
import ar.edu.unsam.exceptions.BusinessException
import javax.persistence.Column
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import com.google.gson.annotations.Expose
import org.bson.types.ObjectId

@javax.persistence.Entity
@Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)
@Accessors
@org.mongodb.morphia.annotations.Entity
class Entidad extends Entity {

	@org.mongodb.morphia.annotations.Transient
	@Transient
	@Id
	@GeneratedValue
	private Long id_jpa


	@org.mongodb.morphia.annotations.Transient
	@javax.persistence.Transient
	@org.neo4j.ogm.annotation.Id
	@org.neo4j.ogm.annotation.GeneratedValue
	private Long id_neo4j

	@Transient
	@javax.persistence.Transient
	@org.mongodb.morphia.annotations.Id
	ObjectId id_mongo;

	@Expose
	@org.neo4j.ogm.annotation.Property(name="codigo")
	@Column(name="codigo")
	@org.mongodb.morphia.annotations.Property("codigo")
	Integer codigo;
	
	override equals(Object other) {
		if (other == null) return false;
	    if (!(other instanceof Entidad))return false;
	    return codigo.equals( (other as Entidad).codigo )
	}
	
}
