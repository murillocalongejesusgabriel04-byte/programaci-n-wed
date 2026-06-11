class Ruta {
    constructor(data) {
        this.id = data ? (data.id || 0) : 0;
        this.nombre = data ? (data.nombre || "") : "";
        this.descripcion = data ? (data.descripcion || "") : "";
        this.ciudad = data ? (data.ciudad || null) : null;
        this.tipo = data ? (data.tipo || null) : null;
    }
}
