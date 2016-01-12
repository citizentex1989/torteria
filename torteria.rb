$tiempo = 0
$id = 1

#CLASE CREADA Y FUNCIONANDO
class Torta
  attr_accessor :tipo
  attr_reader :id_torta, :tiempo_horneado, :estado

  def initialize(tipo)
    tortas = ["Cubana","Clasica","Vegetariana","Hawaiana"]
    @tipo = tortas[tipo-1]
    @id_torta = "#{$id} - #{@tipo} "
    $id += 1
    atributos()
  end

  def id_torta
    @id_torta
  end

  def atributos
    tipos_tortas = {"Cubana" => 20, "Clasica" => 12, "Vegetariana" => 4, "Hawaiana" => 16}
    @tiempo_horneado = tipos_tortas[@tipo]
    @estado = "crudo"
  end

  def cambiar_estado(tiempo)
    puts "Cambiando estado"
    estados = ["crudo","casi listo","listo","quemado"]
    if tiempo <= (@tiempo_horneado*0.25)
      puts "crudo"
      @estado = estados[0]
    elsif tiempo > (@tiempo_horneado*0.25) && tiempo <= (@tiempo_horneado*0.5)
      puts "casi listo"
      @estado = estados[1]
    elsif tiempo > (@tiempo_horneado*0.5) && tiempo <= (@tiempo_horneado*0.75)
      puts "listo"
      @estado = estados[2]
    elsif tiempo > (@tiempo_horneado*0.75)
      puts "crudo"
      @estado = estados[3]
    end
  end

end



class Torteria < Torta

  attr_reader :id_torta

  def initialize
    @linea = "-----------------------------------"
    @tortas_sin_hornear = []
    @tortas_horneadas = []
    desplegar()
  end

  def desplegar
    puts @linea
    puts "Software torteria, eliga una opción"
    puts @linea
    puts "(1) Tomar Orden"
    puts "(2) Preparar Tortas"
    puts "(3) Revisar Horno"
    puts "(4) Revisar Barra"
    puts "(5) Cerrar programa"
    puts @linea
    print "Opcion: "
    opcion = gets.chomp
    proceso(opcion)
  end

  def proceso(opcion)
    case opcion.to_i
      when 1
        tomar_orden()
      when 2
        preparar_tortas()
      when 3
        revisar_horno()
      when 4
        revisar_barra()
      when 5
        salir()
      else
        puts "\n\n" + @linea
        puts "SELECCIONE NUMEROS DEL 1 AL 5"
        desplegar()
    end
  end

  def tomar_orden
    puts
    puts @linea
    puts "Seleccione tipo de torta:"
    puts @linea
    puts "(1) Cubana"
    puts "(2) Clasica"
    puts "(3) Vegetariana"
    puts "(4) Hawaiana"
    @linea
    print "Tipo: "
    tipo = gets.to_i
    if tipo.between?(1, 4)
      @tortas_sin_hornear << Torta.new(tipo)
      puts @linea
      puts
      puts "Torta agregada #{@tortas_sin_hornear[$id-2].id_torta}"
    else
      puts @linea
      puts
      puts "Tipo de torta no encontrado".upcase
      tomar_orden()
    end
    desplegar()
  end

end

torteria = Torteria.new
#torta = Torta.new("Cubana")
#torta.cambiar_estado(15)
#puts torta.inspect



