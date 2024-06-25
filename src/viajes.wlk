import socios.*

class Actividad{
	const property idiomas = #{}
	
	method esInteresante() = idiomas.size() > 1 
	method sirveParaBroncear()
	method implicaEsfuerzo()
	method diasActividad()
	method esRecomendadaPara(socio){
		return self.esInteresante() and socio.leAtrae(self) 
		       and not socio.realizoActividad(self)
	}  
}

class ViajeDePlaya inherits Actividad{
	var largoPlaya
	
	override method sirveParaBroncear() = true
	
	override method implicaEsfuerzo(){
		return largoPlaya > 1200
	}
	
	override method diasActividad(){
		return largoPlaya/500
	}
}

class ExcursionACiudad inherits Actividad{
	var cantAtracciones
	
	override method esInteresante(){
		return super() or cantAtracciones == 5  
	}
	
	override method sirveParaBroncear(){
		return false
	}
	
	override method implicaEsfuerzo(){
		return cantAtracciones.between(5,8)
	}
	
	override method diasActividad(){
		return cantAtracciones/2
	}
}

class ExcursionCiudadTropical inherits ExcursionACiudad{
	
	override method diasActividad(){
		return super()+1
	}
	
	override method sirveParaBroncear(){
		return true
	}
}

class SalidaTrekking inherits Actividad{
	var kilometros
	var diasDeSol
	
	override method esInteresante(){
		return super() and diasDeSol > 140
	}
	
	override method sirveParaBroncear(){
		return (diasDeSol > 200) or 
			   (diasDeSol.between(100,200) and kilometros > 120)
	}
	
	override method implicaEsfuerzo(){
		return kilometros > 80
	}
	
	override method diasActividad(){
		return kilometros/50
	}
}

class ClasesGimnasia inherits Actividad{
	
	method initialize(){
		if(idiomas != #{"español"})
			self.error("solo se permite clase de gimnasias en español")
	}
	
	override method sirveParaBroncear(){
		return false
	}
	
	override method implicaEsfuerzo(){
		return true
	}
	
	override method diasActividad(){
		return 1
	}
	
	override method esRecomendadaPara(socio){
		return socio.edad().between(20,30)
	}
}

class TallerLiterario{
	const libros = #{}
	
	method idiomas(){
		return libros.map({i=>i.idiomasUsados()}).asSet()
	}
	
	method diasActividad(){
		return libros.size() + 1
	}
	
	method implicaEsfuerzo(){
		return libros.any({l=>l.cantPaginas()>500}) or 
			   (self.mismoAutor() and libros.size()>1)	
	}
	
	method autoresDeLibros() = libros.map({l=>l.autor()}).asSet()
	method mismoAutor() = self.autoresDeLibros().size() == 1
	
	 method sirveParaBroncear(){
		return false
	}
	
	method esRecomendadaPara(socio){
		return socio.coleccionIdiomas().size() > 1
	}
}

class Libros{
	const property idiomasUsados = []
	const property cantPaginas 
	const property autor
}