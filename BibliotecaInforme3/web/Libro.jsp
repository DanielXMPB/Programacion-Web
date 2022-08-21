<%-- 
    Document   : Libro
    Created on : 21/08/2022, 1:33:50 a. m.
    Author     : MIGUEL HENAO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Libro</title>
        <style>
            div{
                padding: 4px;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid" style="background-color: #B9FAF1" ng-app="demoB1" ng-controller="b1Controller as b1" >
            <div class="row">
                <div class="col-6">
                    <h3>Seccion 1</h3>
                    <div class="row">
                        <div class="col-6"> 
                            <label>ISBN</label>
                            <input type="text" class="form-control" placeholder="ISBN" ng-model="b1.isbn">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" placeholder="nombre" ng-model="b1.nombre">

                        </div>
                        <div class="col-6"><label>Id autor</label>
                            <select class="form-control" ng-model="b1.id_autor"> 
                                <option ng-repeat="a in b1.Autores" value="{{a.id_autor}}">{{a.nombre}}</option>
                            </select>
                        </div>
                        <div class="col-6"><label>Id categoria</label>
                            <select class="form-control" ng-model="b1.id_categoria"> 
                                <option ng-repeat="c in b1.Categorias" value="{{c.id_categoria}}">{{c.nombre}}</option>
                            </select>
                        </div>
                        <div class="col-6"><label>Descripcion</label>
                            <input type="text" class="form-control" placeholder="Descripcion" ng-model="b1.descripcion" >
                        </div>
                        <div class="col-6"><label>Id editorial</label>
                            <select class="form-control" ng-model="b1.id_editorial"> 
                                <option ng-repeat="e in b1.Editoriales" value="{{e.id_editorial}}">{{e.nombre}}</option>
                            </select>
                        </div>
                        <div class="col-6"><label>Fecha de publicacion</label>
                            <input type="text" class="form-control" placeholder="Fecha de publicacion" ng-model="b1.fechapublicacion" >
                        </div>
                        <div class="col-6"><label>Paginas</label>
                            <input type="text" class="form-control" placeholder="Paginas" ng-model="b1.Paginas" >
                        </div>

                    </div>
                </div>
                <div class="col-6">
                    <h3>Seccion 2</h3>
                    <div class="row">
                        <div class="col-6"> 
                            <label>ISBN</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.isbn}}">
                        </div>
                        <div class="col-6">
                            <label>nombre</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.nombre}}">
                        </div>
                        <div class="col-6"> 
                            <label>Id autor</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.id_autor}}">
                        </div>
                        <div class="col-6"> 
                            <label>Id categoria</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.id_categoria}}">
                        </div>
                        <div class="col-6"> 
                            <label>Descripcion </label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.descripcion}}">
                        </div>
                        <div class="col-6"> 
                            <label>Id editorial</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.id_editorial}}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6"> 
                            <label>Fecha de publicacion</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.fechapublicacion}}">
                        </div>

                        <div class="col-6">
                            <label>Paginas</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.Paginas}}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-3"><button type="button" class="btn btn-outline-success" ng-click="b1.guardar()">Guardar</button></div>
                <div class="col-3"><button type="button" class="btn btn-outline-primary" ng-click="b1.listar()">Consultar</button></div>
                <div class="col-3"><button type="button" class="btn btn-outline-warning" ng-click="b1.actualizar()">Actualizar</button></div>
                <div class="col-3"><button type="button" class="btn btn-outline-danger" ng-click="b1.eliminar()">Eliminar</button></div>
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">ISBN</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Id autor</th>
                                <th scope="col">Id categoria</th>
                                <th scope="col">Id editorial</th>
                                <th scope="col">Fecha de publicacion</th>
                                <th scope="col">Paginas</th>
                                <th scope="col">Descripcion</th>
                                <th scope="col">Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat=" n in b1.Libros">
                                <td>{{n.isbn}}</td>
                                <td>{{n.nombre}}</td>
                                <td>{{n.autor.nombre}}</td>
                                <td>{{n.categoria.nombre}}</td>
                                <td>{{n.editorial.nombre}}</td>
                                <td>{{n.fechapublicacion}}</td>
                                <td>{{n.Paginas}}</td>
                                <td>{{n.descripcion}}</td>
                                <td>
                                    <button type="button" class="btn btn-outline-info" ng-click="b1.editar(n.isbn)">Editar</button>
                                </td>
                            </tr>
                            </div>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script>
            var app = angular.module('demoB1', []);
            app.controller('b1Controller', ['$http', controladorB1]);
            function controladorB1($http) {
                var b1 = this;
                consultarCategorias = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Categorias = res.data.Categorias;
                    });
                };
                consultarAutores = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesAutor.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Autores = res.data.Autores;
                    });
                };
                consultarEditoriales = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesEditorial.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Editoriales = res.data.Editoriales;
                    });
                };
                consultarAutores();
                consultarCategorias();
                consultarEditoriales();
                b1.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Libros = res.data.Libros;
                    });
                };

                b1.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        isbn: b1.isbn,
                        nombre: b1.nombre,
                        id_autor: b1.id_autor,
                        id_categoria: b1.id_categoria,
                        id_editorial: b1.id_editorial,
                        fechapublicacion: b1.fechapublicacion,
                        Paginas: b1.Paginas,
                        descripcion: b1.descripcion

                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.guardar === true) {
                                alert('Guardó');
                            } else {
                                alert('No Guardó');
                            }

                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };

                b1.actualizar = function () {
                    var parametros = {
                        proceso: 'actualizar',
                        isbn: b1.isbn,
                        nombre: b1.nombre,
                        id_autor: b1.id_autor,
                        id_categoria: b1.id_categoria,
                        id_editorial: b1.id_editorial,
                        fechapublicacion: b1.fechapublicacion,
                        Paginas: b1.Paginas,
                        descripcion: b1.descripcion
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.actualizar === true) {
                                alert('Actualizó');
                            } else {
                                alert('No actualizo');
                            }

                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };
                b1.eliminar = function () {
                    var parametros = {
                        proceso: 'eliminar',
                        isbn: b1.isbn

                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.eliminar === true) {
                                alert('Elimino');
                            } else {
                                alert('No elimino');
                            }

                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };
                b1.editar = function (id) {
                    var parametros = {
                        proceso: 'listarporid',
                        isbn: id
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.isbn = res.data.Libro.isbn;
                        b1.nombre = res.data.Libro.nombre;
                        b1.id_autor = res.data.Libro.id_autor;
                        b1.id_categoria = res.data.Libro.id_categoria;
                        b1.id_editorial = res.data.Libro.id_editorial;
                        b1.fechapublicacion = res.data.Libro.fechapublicacion;
                        b1.Paginas = res.data.Libro.Paginas;
                        b1.descripcion = res.data.Libro.descripcion;

                    });
                };
                window.onload = b1.listar;
            };
        </script>
    </body>
</html>
