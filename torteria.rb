class Menu

  @opcion

  def initialize
    deplegar()
  end

  def desplegar
    puts "Software torteria, eliga una opción"
    puts "(1) Tomar Orden"
    puts "(2) Preparar Tortas"
    puts "(3) Revisar Horno"
    puts "(4) Revisar Barra"
    puts "(5) Cerrar programa"
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
        puts "Seleccione numeros del 1 al 5"
        desplegar()
    end
  end



