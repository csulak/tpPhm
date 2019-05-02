package ar.edu.unsam.dao

import java.util.List

/**
 * Interfaz que provee de todos los metodos de busqueda que se van a usar en el TP.
 */
interface IRepositorio<T> {

	/**
	 * Busca por ejemplo
	 */
	def List<T> buscarPorEjemplo(T ejemplo);

	/**
	 * Busca por id
	 */
	def T buscarPorId(int id);

	/**
	 * Devuelve todos los elementos
	 */
	def List<T> elementos();

	/*
	 * Metodo para agregar un elemento
	 */
	def void agregarNuevo(T elemento);

	def void actualizar(T elemento);
	
	def T vender(Long cantidad, Long idElemento);
	
	/**
	 * Inicializa el repo, es para neo4j para que elimine todo lo que ya habia
	 */
	def void init();
	
	def void eliminar(T elemento);
}
