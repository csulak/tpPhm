describe('Tests para el pokemon', () => {
    const ash = new Entrenador();
    const gary = new Entrenador();
    const squirtle = new Especie();
    const pikachu = new Especie();
    const electricidad = new Tipo("Electricidad");
    const agua = new Tipo("Agua");
    var poke1 = new Pokemon(pikachu);
    var poke2 = new Pokemon(squirtle);

    beforeEach( () => {
        pikachu.agregarTipo(electricidad);
        electricidad.agregarEsFuerte(agua);
        electricidad.agregarEsResistente(agua);
        pikachu.puntosAtaque = 5000;
        squirtle.agregarTipo(agua);
        squirtle.puntosAtaque = 1000;

        poke1 = new Pokemon(pikachu);
        poke2 = new Pokemon(squirtle);
        poke1.entrenador = ash;
        poke2.entrenador = gary;
    })

    it('obtener nivel 1', () => {
        expect(1).toBe( poke1.getNivel() );
    })

    it('obtener nivel 5', () => {
    	poke1.experiencia = 1000;
        expect(5).toBe( poke1.getNivel() );
    })

    it('saber si es fuerte contra otro pokemon', () => {
        expect(true).toBe( poke1.esFuerteContra(poke2) );
    })

    it('obtener chances de ganar sin ventaja', () => {
        expect(1000).toBe( poke2.calcularChancesCombate(poke1) );
    })

    it('obtener chances de ganar con ventaja', () => {
        expect((7187.50).toFixed(2)).toBe( poke1.calcularChancesCombate(poke2) );
    })

    it('obtener chances de ganar con entrenador experto', () => {
        ash.esExperto = true;
        expect((8625.00).toFixed(2)).toBe( poke1.calcularChancesCombate(poke2) );
    })
})