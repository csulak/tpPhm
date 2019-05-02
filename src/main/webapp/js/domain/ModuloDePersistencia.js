class ModuloDePersistencia {

    constructor() {
        this.nombre;
        this.id_modulo;
    }

    static asModuloDePersistencia(jsonModulo) {
        return angular.extend(new ModuloDePersistencia(), jsonModulo)
    }

}