package ar.edu.unsam.model

import ar.edu.unsam.controller.Repositorios
import javax.persistence.EnumType
import javax.persistence.Enumerated
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.Entity

@Accessors
@javax.persistence.Entity
class ModuloDePersistencia extends Entity {
	
	@Id @GeneratedValue
	private Integer id_modulo
	
	@Enumerated(EnumType.STRING)
	Repositorios nombre

}