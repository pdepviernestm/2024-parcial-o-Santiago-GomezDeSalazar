class Persona{
    var edad
    var emociones = []
    // VER LO DEL EVENTO

    method esAdolescente() = (edad > 12) && (edad < 19)

    method nuevaEmocion(emocion){
        emociones.add(emocion)
    }
}

class Emocion{
    var cantidadEventos
    var property intensidad
}

class Furia inherits Emocion{

    
}
