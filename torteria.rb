$id = 1
$tortas_quemadas = 0

#CLASE CREADA Y FUNCIONANDO
class Torta
  attr_accessor :tipo, :tiempo_en_horno
  attr_reader :id_torta, :tiempo_maximo, :estado

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

  def tiempo_maximo
    @tiempo_maximo
  end

  def tiempo_en_horno
    @tiempo_en_horno
  end

  def tiempo_en_horno=(value)
    @tiempo_en_horno = value
  end

  def atributos
    tipos_tortas = {"Cubana" => 20, "Clasica" => 12, "Vegetariana" => 12, "Hawaiana" => 16}
    @tiempo_maximo = tipos_tortas[@tipo]
    @tiempo_en_horno = 0
    @estado = "crudo"
  end

  def cambiar_estado(tiempo)
    estados = ["crudo","casi listo","listo","quemado"]
    if tiempo <= (@tiempo_maximo*0.25)
      @estado = estados[0]
    elsif tiempo > (@tiempo_maximo*0.25) && tiempo <= (@tiempo_maximo*0.5)
      @estado = estados[1]
    elsif tiempo > (@tiempo_maximo*0.5) && tiempo <= (@tiempo_maximo*0.75)
      @estado = estados[2]
    elsif tiempo > (@tiempo_maximo*0.75)
      @estado = estados[3]
      $tortas_quemadas += 1
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
      tiempo_torta = torta.tiempo_en_horno
      tiempo_torta += 1
      torta.tiempo_en_horno=(tiempo_torta)
      torta.cambiar_estado(tiempo_torta)
    end
  end

  def checar_horno
    @horno_espacio.each do |torta|
      torta_sacar = torta.estado()
      if torta_sacar == "listo"
        puts "La torta #{torta.id_torta} está lista"
      end
    end
  end

  def hornear_torta(id,torta)
    if @horno_espacio.length < 5
      @horno_espacio << torta.dup
      puts "Torta agregada #{torta.id_torta}"
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
    @horno = Horno.new
    desplegar()
  end

  def desplegar
    puts "\n"*3
    puts @linea
    puts "Software torteria, eliga una opción"
    puts @linea
    puts "(1) Tomar Orden"
    puts "(2) Preparar Tortas"
    puts "(3) Revisar Horno"
    puts "(4) Cerrar programa"
    puts @linea
    print "Opcion: "
    opcion = gets.chomp
    @horno.tiempo!()
    @horno.checar_horno()
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
    print "Selecciona numero de torta para preparar: "
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
    print "Selecciona una torta para sacar o 0 para salir: "
    sacar = gets.to_i
    if sacar != 0
      @horno.sacar_torta(sacar)
    else
      desplegar()
    end
    desplegar()
  end

  def salir
    tortas_vendidas = $id - $tortas_quemadas
    puts "Total de tortas vendidas: "
    puts "Total de tortas quemadas: #{$tortas_quemadas}"
    exit
  end

end

torteria = Torteria.new




