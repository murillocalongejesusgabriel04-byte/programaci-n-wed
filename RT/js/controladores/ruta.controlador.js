app.controller("RutaControlador", function ($scope, CiudadServicio, RutaServicio, ParadaServicio, TipoServicio) {

    $scope.ciudades = [];
    $scope.ciudadSeleccionada = null;

    $scope.rutas = [];
    $scope.rutaSeleccionada = null;
    $scope.formRuta = {};
    $scope.mostrarFormRuta = false;

    $scope.paradas = [];
    $scope.formParada = {};
    $scope.paradaEnEdicion = null;
    $scope.tipos = [];

    $scope.inicializar = () => {
        CiudadServicio.listar().then(data => {
            $scope.ciudades = data.map(c => new Ciudad(c));
        });
        TipoServicio.listar().then(data => {
            $scope.tipos = data.map(t => new Tipo(t));
        });
    };

    // --- Ciudades ---

    $scope.seleccionarCiudad = (ciudad) => {
        $scope.ciudadSeleccionada = ciudad;
        $scope.rutaSeleccionada = null;
        $scope.paradas = [];
        $scope.mostrarFormRuta = false;
        $scope.formRuta = {};
        $scope.paradaEnEdicion = null;
        RutaServicio.listarPorCiudad(ciudad.id).then(data => {
            $scope.rutas = data.map(r => new Ruta(r));
        });
    };

    // --- Rutas ---

    $scope.cargarRutasDeCiudad = () => {
        RutaServicio.listarPorCiudad($scope.ciudadSeleccionada.id).then(data => {
            $scope.rutas = data.map(r => new Ruta(r));
        });
    };

    $scope.mostrarAgregarRuta = () => {
        $scope.formRuta = { ciudad: { id: $scope.ciudadSeleccionada.id }, tipo: { id: 0 } };
        $scope.mostrarFormRuta = true;
    };

    $scope.editarRuta = (ruta) => {
        $scope.formRuta = {
            id: ruta.id,
            nombre: ruta.nombre,
            descripcion: ruta.descripcion,
            ciudad: { id: ruta.ciudad.id },
            tipo: { id: ruta.tipo.id }
        };
        $scope.mostrarFormRuta = true;
    };

    $scope.guardarRuta = () => {
        if ($scope.formRuta.id) {
            RutaServicio.modificar($scope.formRuta).then(() => {
                $scope.cargarRutasDeCiudad();
                $scope.cancelarFormRuta();
            });
        } else {
            RutaServicio.agregar($scope.formRuta).then(() => {
                $scope.cargarRutasDeCiudad();
                $scope.cancelarFormRuta();
            });
        }
    };

    $scope.cancelarFormRuta = () => {
        $scope.formRuta = {};
        $scope.mostrarFormRuta = false;
    };

    $scope.eliminarRuta = (id) => {
        if (confirm("¿Deseas eliminar esta ruta?")) {
            RutaServicio.eliminar(id).then(respuesta => {
                if (respuesta) {
                    if ($scope.rutaSeleccionada && $scope.rutaSeleccionada.id === id) {
                        $scope.rutaSeleccionada = null;
                        $scope.paradas = [];
                    }
                    $scope.cargarRutasDeCiudad();
                } else {
                    alert("No se pudo eliminar la ruta.");
                }
            });
        }
    };

    // --- Paradas ---

    $scope.seleccionarRuta = (ruta) => {
        $scope.rutaSeleccionada = ruta;
        $scope.paradaEnEdicion = null;
        $scope.formParada = {};
        $scope.cargarParadasDeRuta(ruta.id);
    };

    $scope.cargarParadasDeRuta = (idRuta) => {
        ParadaServicio.listarPorRuta(idRuta).then(data => {
            $scope.paradas = data.map(p => new Parada(p));
        });
    };

    $scope.mostrarFormParadaNueva = () => {
        $scope.paradaEnEdicion = -1;
        $scope.formParada = { ruta: { id: $scope.rutaSeleccionada.id }, orden: $scope.paradas.length + 1 };
    };

    $scope.editarParada = (parada) => {
        $scope.paradaEnEdicion = parada.id;
        $scope.formParada = {
            id: parada.id,
            nombre: parada.nombre,
            orden: parada.orden,
            latitud: parada.latitud,
            longitud: parada.longitud,
            tiempo: parada.tiempo,
            descripcion: parada.descripcion,
            ruta: { id: $scope.rutaSeleccionada.id }
        };
    };

    $scope.guardarParada = () => {
        if ($scope.formParada.id) {
            ParadaServicio.modificar($scope.formParada).then(() => {
                $scope.paradaEnEdicion = null;
                $scope.cargarParadasDeRuta($scope.rutaSeleccionada.id);
            });
        } else {
            ParadaServicio.agregar($scope.formParada).then(() => {
                $scope.paradaEnEdicion = null;
                $scope.formParada = {};
                $scope.cargarParadasDeRuta($scope.rutaSeleccionada.id);
            });
        }
    };

    $scope.cancelarParada = () => {
        $scope.paradaEnEdicion = null;
        $scope.formParada = {};
    };

    $scope.eliminarParada = (id) => {
        if (confirm("¿Deseas eliminar esta parada?")) {
            ParadaServicio.eliminar(id).then(respuesta => {
                if (respuesta) {
                    $scope.cargarParadasDeRuta($scope.rutaSeleccionada.id);
                } else {
                    alert("No se pudo eliminar la parada.");
                }
            });
        }
    };

    $scope.inicializar();
});
