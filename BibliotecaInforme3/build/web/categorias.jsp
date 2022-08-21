<%-- 
    Document   : categorias
    Created on : 21/08/2022, 2:27:27 p. m.
    Author     : Eduar Ortiz
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Categorias</title>
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
                            <label>Id Categoria</label>
                            <input type="text" class="form-control" placeholder="Id Categoria" ng-model="b1.id_categoria">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" placeholder="nombre" ng-model="b1.nombre">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12"><label>Descripcion</label>
                            <input type="text" class="form-control" placeholder="Descripcion" ng-model="b1.descripcion" >
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <h3>Seccion 2</h3>
                    <div class="row">
                        <div class="col-6"> 
                            <label>Id Categoria</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.id_categoria}}">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.nombre}}">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12"><label>Descripcion</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.descripcion}}">
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
                                <th scope="col">Id Categoria</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Descripcion</th>
                                 <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat=" c in b1.categorias">
                                <td>{{c.id_categoria}}</td>
                                <td>{{c.nombre}}</td>
                                <td>{{c.descripcion}}</td>
                                <td>
                                    <button type="button" class="btn btn-outline-info" ng-click="b1.editar(c.id_categoria)">Editar</button>
                                </td>
                            </tr>

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
                b1.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.categorias = res.data.Categorias;
                    });
                };
                b1.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        id_categoria: b1.id_categoria,
                        nombre: b1.nombre,
                        descripcion: b1.descripcion,
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
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
                        id_categoria: b1.id_categoria,
                        nombre: b1.nombre,
                        descripcion: b1.descripcion,
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
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
                        id_categoria: b1.id_categoria
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
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
                b1.editar=function(id){
                    var parametros={
                        proceso:'listarporid',
                        id_categoria:id
                    };
                    $http({
                        method:'POST',
                        url:'peticionesCategoria.jsp',
                        params:parametros
                    }).then(function(res){
                        b1.id_categoria=res.data.Categoria.id_categoria;
                        b1.nombre=res.data.Categoria.nombre;
                        b1.descripcion=res.data.Categoria.descripcion;
                    });
                };
                window.onload = b1.listar;
            };
        </script>
    </body>
</html>