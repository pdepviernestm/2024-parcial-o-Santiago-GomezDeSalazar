class Persona{
    var edad
    var emociones = []
    var property intensidadElevada = 300

    method esAdolescente() = (edad > 12) && (edad < 19)

    method nuevaEmocion(emocion){
        emociones.add(emocion)
    }

    method puedeExplotarEmocionalmente() = emociones.all({emocion => emocion.puedeLiberarse()})

    method modificarIntensidadElevada(nuevaIntensidad){
        intensidadElevada = nuevaIntensidad
    }

    method vivirEvento(unEvento){
        emociones.forEach{emocion => emocion.liberarse(unEvento,self)}
    }
}

class Evento{
    var property impacto
    const property descripcion = []
}

class Emocion{
    var property cantidadEventos
    var property intensidad 
    var property volverALiberarse = true

    method liberarse(evento,persona){
        if(self.puedeLiberarse(persona) && volverALiberarse)
        {
        intensidad -= evento.impacto()
        volverALiberarse = false
        }
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

    override method liberarse(evento,persona){
        if(self.puedeLiberarse(persona) && volverALiberarse){
        super(evento,persona)
        self.olvidarPalabrota(palabrotas.first())
        }
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
    var causa = "melancolia"

    override method liberarse(evento,persona){
        if(self.puedeLiberarse(persona) && volverALiberarse){
        super(evento,persona)
        causa = evento.descripcion()
        }
    }
}

class Desagrado inherits Emocion{
    override method puedeLiberarse(persona) = super(persona) && cantidadEventos > intensidad
}

class Temor inherits Desagrado{

}

class Ansiedad inherits Emocion{
    var nivelDeAnsiedad

    override method puedeLiberarse(persona) = super(persona) && nivelDeAnsiedad/2 > cantidadEventos

    override method liberarse(evento,persona){
        if(self.puedeLiberarse(persona) && volverALiberarse){
        super(evento,persona)
        nivelDeAnsiedad = 0
        }

    }
}

// El concepto de herencia fue útil para no repetir código, que tiene como ventaja el ahorro de tiempo y hacerlo más entendible.
// El concepto de polimorfismo fue útil para referirse al mismo método en distintas clases (con sus respectivos cambios acorde a cada clase), lo que
// hace que cada efecto o "return" sea particular de cada uno, además de no estar cambiando el nombre del método en cada clase.


class GrupoPersonas{
    var personas = []

    method agregarPersona(unaPersona){
        personas.add(unaPersona)
    }

    method vivirTodosUnEvento(evento){
        personas.forEach{persona => persona.vivirEvento(evento)}
    }
}
    
