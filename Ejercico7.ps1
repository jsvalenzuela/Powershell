Param
(
    [parameter(Position=0)]
    [String[]]
    [ValidateNotNullOrEmpty()]
    $Path,
    [parameter(Position=1)]
    [char]
    [ValidateNotNullOrEmpty()]
    $delim
)



#####      Validaciones:
    #write-host $args.legth
    #write-host $args[1]
    #verifico cantidad de parametros
    <#
    if( $args.length -ne 0)
    {
        write-host "Numero de parametros incorrecto"
        return
    }



        #>
##### Fin de validaciones





function Cargar_Matriz_De_Archivo([String]$file,[char]$Delimitador)
{
  $f = get-content $file
  [int]$filas = $f.Length 
  $columnas = $f[0].split($Delimitador).Length 

  [double[][]] $resultado = new-object double[][] $filas
  for ($i = 0; $i -lt $resultado.Length; $i++) {
    $resultado[$i] = new-object double[] $columnas
  }

  $i = 0
  foreach ($linea in $f) {
    $tokens = $linea.split($Delimitador)
    for ($j = 0; $j -lt $tokens.Length; $j++) {
      $resultado[$i][$j] = $tokens[$j].trim()
    }
    $i++
  }
  return $resultado
}


function Mostrar_Matriz([double[][]] $m)
{
    write-host "Mostrando Matriz:"
  #Recorre las filas una por una
  for ($i = 0; $i -lt $m.Length; $i++) {
    #Recorre las columnas una por una
    for ($j = 0; $j -lt $m[$i].Length; $j++) {
      $x = $m[$i][$j]
      write-host -nonewline $x " "
    }
    write-host ""
  }
}

function Verificar_Tipo_Matriz([double[][]] $matriz)
{    
    #Cantidad de filas
    $cant_filas = $matriz.Length
    #Cantidad de columnas
    $cant_columnas = $matriz[0].Length
    
    if($cant_filas -eq $cant_columnas)
    {
        write-host "Matriz Cuadrada"
    }
    
    if($cant_filas -eq 1)
    {
        write-host "Matriz Fila"
    }
    
    
    if($cant_columnas -eq 1)
    {
        write-host "Matriz Columna"
    }
    
    if($cant_columnas -ne $cant_filas)
    {
        write-host "Matriz Rectangular"
    }
    
    $es_matriz_nula=$TRUE
    $es_matriz_identidad=$TRUE
    #Recorre las filas una por una
    for($i = 0; $i -lt $matriz.Length; $i++) 
    {
        #Recorre las columnas una por una
        for ($j = 0; $j -lt $matriz[$i].Length; $j++) 
        {
            if($matriz[$i][$j] -ne 0)
            {
                $es_matriz_nula = $FALSE
            }
        }
        if($matriz[$i][$i] -ne 1)
        {
            $es_matriz_identidad = $FALSE
        }
    }
    if($es_matriz_nula -eq $TRUE)
    {
        write-host "Matriz Nula"
    }
    
    if($es_matriz_identidad -eq $TRUE)
    {
        write-host "Matriz identidad"
    }
}


#$file = ‘C:\matriz.txt’
#$delim = ‘&’
$matriz = Cargar_Matriz_De_Archivo $Path $delim
Verificar_Tipo_Matriz $matriz
Mostrar_Matriz $matriz



            <#
            .SYNOPSIS 
            Analiza la estructura de la Matriz cargada en un archivo y determina el tipo al que corresponde.

            .DESCRIPTION
            Lee y analiza la estructura de una Matriz cargarda en un Archivo separada por un caracter que llega de parametro y filas por salto de linea.

            .PARAMETER Path
            Especifica el path del archivo que contiene la matriz.

            .PARAMETER Char
            Especifica el caracter separador de las columnas.

            .INPUTS
            Ninguna. No se pueden canalizar objetos a Add-Extension.

            .OUTPUTS
            System.String. Add-Extension devuelve una cadena con la 
            extensión o el nombre del archivo.

            .EXAMPLE
            Ejemplo1, lo subo para cuando estemos en sistemas

            .EXAMPLE
            C:\PS> 5 8 c:\test.txt
            Ejemplo2, lo subo para cuando estemos en sistemas
            .LINK
            Codigo fuente de la version: http://pastebin.com/BtR14H5Q

            .LINK
            Set-Item
            #>
