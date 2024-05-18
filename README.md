Requisitos

Realizado los 5 puntos Obligatorios:

1.Base de datos(modelo E-R, modelo Relacional y Scrip SQL)

2.Todos lo stextos en Ingles

3.Git Implementado con Git Flow

4.Funcionalidad Listado detalle de 3 tablas completo(Users,Suppliers,Products), y visualizacion de pedidos realizados con sumatorio

5.Funcionalidad de Registro y borrado en 3 tablas completo(User,Suppliers,Products)

Otras funcionalidades:

Extra 1: Funcionalidad Modificar(3 tablas)

Extra 2: Funcionalidad Busqueda(sobre 3 4 campos incluido fecha previa trnasformacion a cadena)

Extra 3: Relaciones, se ha hecho relacion entre Productos y Proveedores en Listado de productos sin Stock(list-out-stock.jsp) y en tabla orders_done cuando se compra algun producto

Extra 4: Funcionalidad Javascrip. Ejecucion de forma asincrona

Extra 5: Diseño. Utilizacion de Boostrap para realizar maquetacion.

Extra 6: Diseño responsive

Extra 7: Creación de Diagrama de Clases y Diagrama de Casos de Uso

Otras funciones implementadas:

            * En Alta y Modificacion de producto se introduce en el formulario listado de proveedores desplegable con datos de la BD de la tabla de Proveedores
            
            * Control de unidades de Stock, si no hay no deja comprar y da mensaje de sin stock habilitando boton para su consulta con tienda, se utiliza como booleano
            
            * Obliga a iniciar sesion para iniciar el proceso de compra, localiza si no hay ususario que no ha iniciado sesion, pero deja ver productos de tienda
            
            * El Listado de productos sin stock se deja al administrador que decida si borra o no el producto dependiendo del interes, tb se pueden borrar todos a la vez
            
            * Proteccion de acceso a paginas sensibles que solo puede entrar el administrador o el usuario en cada caso
            
            * Un usuario que es administrador no puede comprar
            
            * Listado de pedidos realizados para administrador, con filtros por 4 campos incluido fecha y sumatorio de importe total de datos seleccionados
            
            * Un administrador no puede ver la contraseña de ningun usuario, puede ver sus datos y eliminar, pero no ver su contraseña
            
            * Se permite modificar a cada usuario(administradores incluidos), modificar sus datos incluido el password
