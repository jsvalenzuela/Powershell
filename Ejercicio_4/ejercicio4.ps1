#############################################################################################
# PROGRAM-ID.  ejercicio4.ps1					                                            #
# OBJETIVO DEL PROGRAMA: Cuenta las ocurrencias de una palabra en un archivo o              #
# lo ingresado por teclado                                                                  #
# TIPO DE PROGRAMA: .ps1                                                                    #
# ARCHIVOS DE SALIDA :                                                                      #
# COMENTARIOS:                                                                              #
# ALUMNOS :                                                                                 #                                                                              
#           -Bogado, Sebastian                                                              #
#           -Camacho, Manfred                                                               #
#           -Gonzalez, Gustavo                                                              #
#           -Rey, Juan Cruz                                                                 #
#           -Valenzuela, Santiago                                                           #
# EjemploEj.:                                                                               #
# C:\PS> .\ejercicio4.ps1                                                                   #
#############################################################################################

<#
.SYNOPSIS
Cuenta las ocurrencias de una palabra en un archivo o lo ingresado por teclado.
.DESCRIPTION
Cuenta las ocurrencias de una palabra en un archivo o lo ingresado por teclado.                                                     
    
.EXAMPLE
    C:\PS> .\ejercicio4.ps1 -path c:\miArchivo.txt
.EXAMPLE
    C:\PS> .\ejercicio5.ps1 "hola mundo, esto es un mundo de holas"

#>
  
  param
  (
    [Parameter(ValueFromPipeline=$true, mandatory = $false)][ValidateNotNullOrEmpty()][string]
    $path
  )
   
   
    Function contarPalabras([String]$texto)
    {
        $palabras = @{}
        $cont = 0
        #dejo 1 solo espacio de separacion entre palabras
        $linea = $texto -replace '\s+', ' '
        #remplazo los caracteres que no forman palabras con vacio
        $regex = $linea -replace '[^\sa-zA-Z0-9]', ''
        $camposLinea = $regex.Split(" ")
        foreach($auxCampos in $camposLinea)
        {             
                $marca = 0
                #recorro el hashtable para ver si existe la palabra de la linea en el 
                foreach($auxPalabras in $palabras.Keys)
                {                
                    if($auxPalabras -eq $auxCampos)
                    {
                   
                        $palabras[$auxPalabras]++
                        $marca = 1
                        break
                    }
                }   
                if($marca -eq 0)
                {
                    $palabras.Add($auxCampos,1)
                }
         }        
          $palabras |  Format-Table -hideTableHeaders  
    } 
   
   
  $cantPar = ($psboundparameters.Count + $args.Count)

  #VALIDACION 
  if($cantPar -ne 1 -and !$input)
  {
    echo "Llamada invalida"
    exit
  }
   if($input)
   {
       contarPalabras $input
       exit
   }
   else
   {
       try{
           $cadena = (Get-Content $path -Delimiter "\n")
           contarPalabras $cadena
           exit
       }
       catch
       {
           Write-Output "Error al leer archivo"
       }
   }
   
  