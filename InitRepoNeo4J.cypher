CREATE (microChip:Producto { id: 1 , id_producto:1 , descripcion:'MicroChip Smart', stockMinimo: 100 , stockMaximo: 100, stockActual : 500 , costo : 100 })
CREATE (smartTv:Producto { id: 2 , id_producto:2 , descripcion:"Smart TV", stockMinimo:10, stockMaximo:100, stockActual:50, costo:10 })
CREATE (tornoplete:Producto { id: 3 , id_producto:3 , descripcion:'Tornoplete', stockMinimo: 300 , stockMaximo: 900, stockActual : 45 , costo : 62.5 })
CREATE (notebook:Producto { id: 4 , id_producto:4 , descripcion:"Notebook" , stockMinimo:300 , stockMaximo:900 , stockActual:450 , costo:620.5 })
CREATE (luzLed:Producto { id: 5 , id_producto:5 , descripcion:"Luz led" , stockMinimo:1 , stockMaximo:10 , stockActual:6 , costo:6.5 })
CREATE (timbre:Producto { id: 6 , id_producto:6 , descripcion:"Timbre" , stockMinimo:0 , stockMaximo:0 , stockActual:0 , costo:100.0 })
CREATE (palangana:Producto { id: 7 , id_producto:7 , descripcion:"palangana" , stockMinimo:100 , stockMaximo:550 , stockActual:200 , costo:111.0 })
CREATE (pascualina:Producto { id: 8 , id_producto:8 , descripcion:"Pascualina" , stockMinimo:200 , stockMaximo:660 , stockActual:300 , costo:120.0 })


CREATE (proveedor1:Proveedor { id_proveedor: 1 , nombre:"LG" } )
CREATE (proveedor2:Proveedor { id_proveedor: 2 , nombre:"Samsung" } )
CREATE (proveedor3:Proveedor { id_proveedor: 3 ,  nombre:"Proveedor Tornoplete" } )
CREATE (proveedor4:Proveedor { id_proveedor: 4 , nombre:"Dell" } )
CREATE (proveedor5:Proveedor { id_proveedor: 5 , nombre:"Noblex" } )

CREATE (oc1:OrdenDeCompra { id: 1 , id_orden_compra:1 , descripcion:"oc1" , fechaDeCompra: "10/05/2018", total : 110 } )
CREATE (oc2:OrdenDeCompra { id: 2 , id_orden_compra:2 , descripcion:"oc2" , fechaDeCompra: "14/05/2018", total : 10 } )
CREATE (oc3:OrdenDeCompra { id: 3 , id_orden_compra:3 , descripcion:"oc3" , fechaDeCompra: "19/05/2018", total : 62.5 } )
CREATE (oc4:OrdenDeCompra { id: 4 , id_orden_compra:4 , descripcion:"oc4" , fechaDeCompra: "19/05/2018", total : 620.5 } )
CREATE (oc5:OrdenDeCompra { id: 5 , id_orden_compra:5 , descripcion:"oc5" , fechaDeCompra: "19/05/2018", total : 6.5 } )

CREATE (ic1:ItemCompra {id_item : 1, cantidad : 1, costoTotal : 100 })
CREATE (ic2:ItemCompra {id_item : 2, cantidad : 1, costoTotal : 10 })
CREATE (ic3:ItemCompra {id_item : 3, cantidad : 1, costoTotal : 10 })
CREATE (ic4:ItemCompra {id_item : 4, cantidad : 1, costoTotal : 62.5 })
CREATE (ic5:ItemCompra {id_item : 5, cantidad : 1, costoTotal : 620.5 })
CREATE (ic6:ItemCompra {id_item : 6, cantidad : 1, costoTotal : 6.5 })

CREATE (proveedor1)-[:PROVEE]->(oc1), (microChip)-[:PRODUCTO]->(ic1),(ic1)-[:ITEMS]->(oc1), (smartTv)-[:PRODUCTO]->(ic2),(ic2)-[:ITEMS]->(oc1)
CREATE (proveedor2)-[:PROVEE]->(oc2), (smartTv)-[:PRODUCTO]->(ic3) , (ic3)-[:ITEMS]->(oc2)
CREATE (proveedor3)-[:PROVEE]->(oc3), (tornoplete)-[:PRODUCTO]->(ic4),(ic4)-[:ITEMS]->(oc3)
CREATE (proveedor4)-[:PROVEE]->(oc4), (notebook)-[:PRODUCTO]->(ic5),(ic5)-[:ITEMS]->(oc4)
CREATE (proveedor5)-[:PROVEE]->(oc5), (luzLed)-[:PRODUCTO]->(ic6),(ic6)-[:ITEMS]->(oc5)


