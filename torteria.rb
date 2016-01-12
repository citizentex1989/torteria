$id = 1
$tortas_entregadas = 0
$tortas_quemadas = 0

#CLASE CREADA Y FUNCIONANDO
class Torta
  attr_accessor :tipo
  attr_reader :id_torta, :tiempo_maximo, :estado, :tiempo_en_horno

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

  def estado
    @estado
  end

  def tiempo_horno













  end

  def atributos
    tipos_tortas = {"Cubana" => 20, "Clasica" => 12, "Vegetariana" => 8, "Hawaiana" => 16}
    @tiempo_maximo = tipos_tortas[@tipo]
    @estado = "crudo"
  end

  def cambiar_estado(tiempo)
    puts "Cambiando estado"
    estados = ["crudo","casi listo","listo","quemado"]
    if tiempo <= (@tiempo_maximo*0.25)
      puts "crudo"
      @estado = estados[0]
    elsif tiempo > (@tiempo_maximo*0.25) && tiempo <= (@tiempo_maximo*0.5)
      puts "casi listo"
      @estado = estados[1]
    elsif tiempo > (@tiempo_maximo*0.5) && tiempo <= (@tiempo_maximo*0.75)
      puts "listo"
      @estado = estados[2]
    elsif tiempo > (@tiempo_maximo*0.75)
      puts "crudo"
      @estado = estados[3]
    end
  end

end

class Horno < Torta

  attr_reader :capacidad

  def initialize
    @horno_espacio = []
    @tortas_listas = []
  end

  def tiempo!
    @horno_espacio.each do |torta|
      torta.cambiar_estado(tiempo)

    end












    
  end

  def hornear_torta(id,torta)
    if @horno_espacio.length < 5
      @horno_espacio << torta.dup
      puts "Torta agregada"
      true
    else
      puts "No hay espacio, revise el horno"
      false
    end
  end

  def horno_espacio
    @horno_espacio.each do |torta|
      puts "#{torta.id_torta} estado: #{torta.estado}"
    end
  end

  def sacar_torta(id)
    i = 0
    @horno_espacio.each do |torta|
      id_torta = torta.id_torta
      id_torta = id_torta.gsub(/[^0-9]/,'')
      id_torta = id_torta.to_i
      if id_torta == id
        @tortas_listas << @horno_espacio[i]
        @horno_espacio.delete_at(i)
        i += 1
      else
        i += 1
      end
    end
  end

end


class Torteria < Torta

  attr_reader :id_torta

  def initialize
    @linea = "-----------------------------------"
    @tortas_sin_hornear = []
    @tortas_horneadas = []
    @horno = Horno.new
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
    horno.tiempo!()
    checar_horno()
    if checar_horno == true
      "RECOMENDAMOS CHECAR EL HORNO"
      proceso(opcion)
    else
      proceso(opcion)
    end
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
      when 6
        $tiempo += 2
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

  def preparar_tortas
    puts
    puts @linea
    puts "Tortas sin preparar:"
    @tortas_sin_hornear.each do |torta|
      if torta != "PREPARADA"
        puts "#{torta.id_torta}"
      end
    end
    puts @linea
    puts "Selecciona numero de torta para preparar"
    seleccion = gets.to_i

    if (seleccion <= @tortas_sin_hornear.length) && (seleccion != 0)
      check = @horno.hornear_torta(seleccion,@tortas_sin_hornear[seleccion-1])
      if check == true
        @tortas_sin_hornear[seleccion-1] = "PREPARADA"
      end
    else
      puts "DATO INCORRECTO, INTENTE DE NUEVO"
      preparar_tortas()
    end
    desplegar()
  end

  def revisar_horno
    @horno.horno_espacio()
    puts @linea
    print "Selecciona una torta para sacar: "
    sacar = gets.to_i
    if sacar != 0
      puts "TORTA A SACAR: #{sacar}"
      @horno.sacar_torta(sacar)
    end
    desplegar()
  end

end

torteria = Torteria.new
#torta = Torta.new("Cubana")
#torta.cambiar_estado(15)
#puts torta.inspect



