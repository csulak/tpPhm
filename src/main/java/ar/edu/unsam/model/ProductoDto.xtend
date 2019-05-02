package ar.edu.unsam.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ProductoDto {
	
	new() {
		
	}
	
	Integer cantidad;
	String nombre;
}