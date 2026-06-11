class Parada {
    constructor(data) {
        this.id = data ? (data.id || 0) : 0;
        this.nombre = data ? (data.nombre || "") : "";
        this.orden = data ? (data.orden || 1) : 1;
        this.ruta = data ? (data.ruta || null) : null;
        this.latitud = data ? (data.latitud || 0) : 0;
        this.longitud = data ? (data.longitud || 0) : 0;
        this.tiempo = data ? (data.tiempo || null) : null;
        this.descripcion = data ? (data.descripcion || "") : "";
    }
}
