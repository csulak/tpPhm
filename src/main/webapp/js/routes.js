const routes = ($stateProvider, $urlRouterProvider) => {
    
      $urlRouterProvider.otherwise("/stock")
    
      $stateProvider
        
        .state('Stock', {
          url: "/stock",
          templateUrl: "partials/stock.html",
          controller: "StockController as stockCtrl"
        })
        .state('DetalleProducto', {
          url: "/detalle-producto/:id",
          templateUrl: "partials/detalle-producto.html",
          controller: "ProductoController as productoCtrl"
        })
        .state('OrdenesDeCompra', {
          url: "/ordenesDeCompra",
          templateUrl: "partials/ordenesDeCompra.html",
          controller: "ComprasController as comprasCtrl"
        })
        .state('CrearOrdenDeCompra', {
          url: "/crearOrdenDeCompra",
          templateUrl: "partials/crearOrdenDeCompra.html",
          controller: "CrearOrdenDeCompraController as comprasCtrl"
        })
        .state('CargaCompra', {
          url: "/CargaCompra/:id",
          templateUrl: "partials/cargaCompra.html",
          controller: "CargaCompraController as comprasCtrl"
        })
        .state('ModulosDePersistencia', {
          url: "/ModulosDePersistencia",
          templateUrl: "partials/modulosDePersistencia.html",
          controller: "PersistenciaController as persistenciaCtrl"
        })
    }
    