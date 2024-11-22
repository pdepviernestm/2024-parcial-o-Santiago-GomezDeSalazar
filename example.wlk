class Persona{
    var edad
    var emociones = []
    var intensidadElevada = 300
    // VER LO DEL EVENTO

    method esAdolescente() = (edad > 12) && (edad < 19)

    //PUNTO 2
    method nuevaEmocion(emocion){
        emociones.add(emocion)
    }

    method puedeExplotarEmocionalmente() = emociones.all({emocion => emocion.puedeLiberarse()})

    method modificarIntensidadElevada(nuevaIntensidad){
        intensidadElevada = nuevaIntensidad
    }

    method vivirEvento(unEvento){
        
    }
}

class Evento{
    var impacto
    const descripcion = []
}

class Emocion{
    var cantidadEventos
    var property intensidad 

    method liberarse(evento){
        intensidad -= evento.impacto()
    }

    method puedeLiberarse(persona) = (persona.intensidadElevada() <= intensidad)
}

class Furia inherits Emocion{
    var palabrotas = []

    override method intensidad() = 100

    method nuevaPalabrota(palabrota){
        palabrotas.add(palabrota)
    }
    
    method olvidarPalabrota(palabrota){
        palabrotas.remove(palabrota)
    }

    override method puedeLiberarse(persona) = super(persona) && palabrotas.any{palabrota => palabrota.size() > 7}

    override method liberarse(evento){
        super(evento)
        self.olvidarPalabrota(palabrotas.first())
    }
}

class Alegria inherits Emocion{

    method darValorIntensidad(valor){
        const valorAbs = valor.abs()
        intensidad = valorAbs
    }

    override method puedeLiberarse(persona) = super(persona) && cantidadEventos.even()
}

class Tristeza inherits Emocion{
    var causa = []
    override method puedeLiberarse(persona) = super(persona) // VER LO DE MELANCOLIA
}

class Desagrado inherits Emocion{
    override method puedeLiberarse(persona) = super(persona) && cantidadEventos > intensidad
}

class Temor inherits Desagrado{

}
