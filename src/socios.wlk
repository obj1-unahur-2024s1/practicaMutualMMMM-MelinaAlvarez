import viajes.*

class Socio{
	const property actividadesRealizadas = []
	const property coleccionIdiomas = #{}
	const property edad
	var maximoActividades
	
	
	
	method esAdoradorDelSol(){
		return actividadesRealizadas.all({a=>a.sirveParaBroncear()})
	}
	
	method actividadesForzosas(){
		return actividadesRealizadas.filter({a=>a.implicaEsfuerzo()})
	}
	
	method registarActividad(actividad){
		if(actividadesRealizadas.size()==maximoActividades){
			self.error("se alcanzo el maximo de actividades")
		}
			actividadesRealizadas.add(actividad)
	}
	
	method realizoActividad(actividad){
		return actividadesRealizadas.contains(actividad)	
	}
	
	method leAtrae(actividad)
}

class SocioTranquilo inherits Socio{
	override method leAtrae(actividad){
		return actividad.diasActividad() >= 4
	}
}

class SocioCoherente inherits Socio{
	override method leAtrae(actividad){
		return if(self.esAdoradorDelSol()) actividad.sirveParaBroncear() else actividad.implicaEsfuerzo()
	}
}

class SocioRelajado inherits Socio{
	override method leAtrae(actividad){
		return coleccionIdiomas.any({i=>actividad.idiomas().any({a=>a == i})})
		//not coleccionIdiomas.intersection(actividad.idiomas()).isEmpty()
	}
}