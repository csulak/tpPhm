# tp-2018-grupo1
tp-2018-grupo1 created by GitHub Classroom

# Entrega 3
https://docs.google.com/document/d/1kP9QyiK3GkGaRIvvYgpWvkJii3AwPpLOMzuHJq9BJWU/edit?usp=sharing
### Punto 1
Saber qué órdenes de compra tienen productos que en su momento tenían un stock menor a 100 unidades.
db.getCollection('OrdenDeCompra')
.find({'productosComprados.producto.stockActual': {$lt: 100} })

### Punto 2
Saber cuántos movimientos (Ordenes de compras)  tuvo un producto día por día.

db.getCollection('OrdenDeCompra')
.aggregate(
    [
        { 
            $match : { 'productosComprados.producto.descripcion': 'Notebook' }
        },
        
        {
            $group: {
            _id: '$fechaDeCompra',
            cantidad : { $sum: 1 }
            }
        }
    ]
)

### Punto 3
Saber el total de órdenes de compra día por día (ej: 07/07/2018 2, 08/07/2018 10, etc.).
db.getCollection('OrdenDeCompra')
.aggregate(
    [
        {
            $group: {
            _id: '$fechaDeCompra',
            cantidad : { $sum: 1 }
            }
        }
    ]
)

### Punto 4
Saber el total de ventas de un proveedor, agrupado por producto. Ej: para “Acevedo Hnos.” sería Tornoplete 50, Pirufio 17, etc.
db.getCollection('OrdenDeCompra')
.aggregate(
    [
        { 
            $match : { 'proveedor.nombre': 'Noblex' }
        },
        { $unwind : "$productosComprados"},
        {
            $group: {
            _id: '$productosComprados.producto.descripcion',
            totalVentas : { $sum: '$total' }
            }
        }
    ]
)

# ------------------------------------------------------------------------

# Entrega 2
https://docs.google.com/document/d/13eMD374oPeQgkyYCKsa6Ad-Qx_SXmh1miE8Cv19R8Ig/edit?usp=sharing
### Punto 1 

MATCH (prod:Producto{descripcion:'Tornoplete'}) -[:CONTIENE]-> (ic:ItemCompra) -[:ITEMS]-> (oc:OrdenDeCompra) WITH oc, count(prod) as sumTornopletes
WHERE sumTornopletes = 2  return oc

### Punto 2

match(prod:Producto) where (prod.stockActual<prod.stockMinimo) return prod

### Punto 3 

match(oc:OrdenDeCompra) WHERE (oc.fechaDeCompra = '19/05/2018') return oc

### Punto 4 

match(prod:Producto) 
where ((prod.descripcion STARTS WITH 'P') OR (prod.descripcion STARTS WITH 'p')) return prod

### Eliminar todos los nodos y relaciones

MATCH (n) DETACH DELETE n;

# ------------------------------------------------------------------------

# Entrega 1
https://docs.google.com/document/d/1mlfia91BOTgXp6hNTaQJgy33wwIirMd-6zSSJEY4KXE/edit?usp=sharing
### Punto 2
Trigger 

use compraventa;

CREATE TABLE LogProducto (
  Id int AUTO_INCREMENT NOT NULL PRIMARY KEY,
  DescripcionAnterior varchar (150) NULL ,
  DescripcionNueva varchar (150) NULL ,
  Fecha datetime NOT NULL 
) ;

DELIMITER |

CREATE TRIGGER Modificacion_Producto AFTER UPDATE ON Producto
FOR EACH ROW 
BEGIN
   INSERT INTO LogProducto
   (DescripcionAnterior, DescripcionNueva, Fecha)
   VALUES
   ( OLD.descripcion , NEW.descripcion , SYSDATE());
END
|

DELIMITER ;

drop trigger Modificacion_Producto;

update Producto set descripcion = 'Nueva descripcion producto 1' where id_producto = 1;

select * from Producto;
select * from LogProducto;

### Punto 3

USE compraventa;

CREATE View ORDENES_DE_COMPRA_CON_MAS_DE_DOS_ITEMS AS
SELECT oc.id_orden_compra, oc.fechaDeCompra, COUNT(ic.id) AS cantidadItemCompra
FROM ordendecompra as oc, ordendecompra_itemcompra as ocic, itemcompra as ic
WHERE oc.id_orden_compra = ocic.OrdenDeCompra_id_orden_compra AND ic.id = ocic.productosComprados_id
GROUP BY oc.id_orden_compra, oc.fechaDeCompra
HAVING COUNT(ic.id) > 1;

SELECT * FROM ORDENES_DE_COMPRA_CON_MAS_DE_DOS_ITEMS;

### Punto 4

ALTER TABLE producto
ADD CONSTRAINT CHK_stockActual CHECK (stockActual > 0);

ALTER TABLE producto
ADD CONSTRAINT CHK_stockMinimo CHECK (stockMinimo > 0);

ALTER TABLE producto
ADD CONSTRAINT CHK_stockMaximo CHECK (stockMaximo > 0);

# Alumnos:

- Marcos Parisi
- Facundo Lopez Chaves
- Lucas
