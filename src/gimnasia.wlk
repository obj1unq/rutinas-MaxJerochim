class Rutina{

	method caloriasQueQuema(tiempo){
		return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
	}

	method descanso(tiempo)

	method intensidad()
}

class Running inherits Rutina{
    const intensidad

	override method intensidad(){
		return intensidad
	}

	override method descanso(tiempo){
		if(tiempo > 20){
			return 5
		} else {
			return 2
		}
	}
}

class Maraton inherits Running{
	override method caloriasQueQuema(tiempo){
		return super(tiempo) * 2
	}
}

class Remo inherits Rutina{
	override method intensidad(){
		return 1.3
	}

	override method descanso(tiempo){
		return tiempo / 5
	}
}

class RemoDeCompeticion inherits Remo{
	override method intensidad(){
		return 1.7
	}

	override method descanso(tiempo){
		return (super(tiempo) - 3).max(2)
	}
}

 /*==================================================*/

 class Persona{
	//Peso que pierde al hacer una rutina: 
	// calorias que baja la rutina en el tiempo que la practica / kilosPorCaloríaQuePierde
	var property peso

	method pesoQuePierde(rutina){
		return rutina.caloriasQueQuema(self.tiempoEjercitacion()) / self.kilosPorCaloria()
	}

	method kilosPorCaloria()

	method tiempoEjercitacion()

	method aplicaRutina(rutina){
		self.validarSiPuedeAplicarRutina(rutina)
		peso = peso - self.pesoQuePierde(rutina)
		
	}

	method validarSiPuedeAplicarRutina(rutina){
		if (not self.puedeRealizar(rutina)){
			self.error("No puede realizar rutina")
		}
	}

	method puedeRealizar(rutina)

	method caloriasQueGasta(rutina){
         return rutina.caloriasQueQuema(self.tiempoEjercitacion())
	}

 }

 class PersonaSedentaria inherits Persona{
	var property tiempoEjercitacion

	override method kilosPorCaloria(){
		return 7000
	}

	override method puedeRealizar(rutina){
		return self.peso() > 50
	}
    
 }

  class PersonaAtleta inherits Persona{
	override method pesoQuePierde(rutina){
		return super(rutina) - 1
	}

	override method kilosPorCaloria(){
		return 8000
	}

	override method tiempoEjercitacion(){
		return 90
	}

	override method puedeRealizar(rutina){
		return rutina.caloriasQueQuema(self.tiempoEjercitacion()) >= 10000
	}
 }


 /*==================================================*/

 class Club{
	const predios = #{}

	method mejorPredio(persona){
		return predios.max({ predio => predio.caloriasQueQuemaConRutinas(persona) })
	}

	method prediosTranqui(persona){
		return predios.filter({ predio => predio.esTranqui(persona) })
	}

	method rutinasMasExigentes(persona){
		return predios.map({ predio => predio.rutinaMasExigente(persona) }).asSet()
	}
 }

 class Predio{
    const rutinas = #{}

	method caloriasQueQuemaConRutinas(persona){
		return rutinas.sum({ rutina => persona.caloriasQueGasta(rutina) })
	}

	method esTranqui(persona){
		return rutinas.any({ rutina => persona.caloriasQueGasta(rutina) < 500 })
	}

	method rutinaMasExigente(persona){
		return rutinas.max({ rutina => persona.caloriasQueGasta(rutina) })
	}
    


 }