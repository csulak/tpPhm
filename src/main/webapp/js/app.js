var myApp = angular.module("myApp",  ['ui.router']);

//Route
myApp.config(routes)

//Services
myApp.service('StockService', StockService)
myApp.service('ProductoService', ProductoService)
myApp.service('ComprasService', ComprasService)
myApp.service('PersistenciaService', PersistenciaService)


//Controllers
myApp.controller("StockController", StockController )
myApp.controller("ProductoController", ProductoController )
myApp.controller("ComprasController", ComprasController )
myApp.controller("CrearOrdenDeCompraController", CrearOrdenDeCompraController )
myApp.controller("CargaCompraController", CargaCompraController )
myApp.controller("PersistenciaController", PersistenciaController )