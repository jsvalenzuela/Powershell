#############################################################################################
# PROGRAM-ID.  ejercicio3.ps1					                                            #
# OBJETIVO DEL PROGRAMA: Realiza un backup de su base de datos en un archivo de texto plano #
# TIPO DE PROGRAMA: .ps1                                                                    #
# ARCHIVOS DE SALIDA : .csv                                                                 #
# COMENTARIOS: Lee el archivo de backup y genere un archivo CSV. La primer fila del archivo #
# CSV contiener los nombres de los campos                                                   #
# ALUMNOS :                                                                                 #                                                                              
#           -Bogado, Sebastian                                                              #
#           -Camacho, Manfred                                                               #
#           -Gonzalez, Gustavo                                                              #
#           -Rey, Juan Cruz                                                                 #
#           -Valenzuela, Santiago                                                           #
# EjemploEj.:                                                                               #
# C:\PS> .\ejercicio3.ps1 -pathOrigen D:\Prueba.txt -pathDestino D:\Backup\Salida.csv       #
#############################################################################################

<#

.SYNOPSIS
Realiza un backup de su base de datos en un archivo de texto plano

.DESCRIPTION
Lee el archivo de backup y genere un archivo CSV. La primer fila del archivo CSV contiener los nombres de los campos 

.PARAMETER pathEntrada
Ruta archivo que se migrara al csv

.PARAMETER pathSalida
Ruta donde se exportara el archivo csv

.EXAMPLE
C:\PS> .\ejercicio3.ps1 -pathOrigen D:\Prueba.txt -pathDestino D:\Backup\Salida.csv       

#>
Param(
[Parameter(Position = 1, Mandatory = $true)][ValidateNotNullOrEmpty()][String]$pathEntrada,
[Parameter(Position = 2, Mandatory = $true)][ValidateNotNullOrEmpty()][String]$pathSalida
)
$cantPar = ($psboundparameters.Count + $args.Count)
if( $cantPar -ne 2 )
{
  Write-Output "La cantidad parametros fue distinta a 2!"
  exit
}

try{
    $linea = (Get-Content $pathEntrada)
}
catch{
    Write-Output "Error al leer el archivo"
    exit
}
$cont = 0

$registroArray =@() #inicializo array


foreach($aux in  $linea)
{
    if($aux -eq "***"){
        $cont = 0
    }
    else
    {
        if($aux.Contains('='))
        {
            $partes = $aux.Split('=')
        }
        else
        {
            Write-Output "Error en el fromato de archivo"
            exit
        }        
        if($cont -eq 0) 
        {
             $registro = new-object PSObject
             $registro | add-member -membertype NoteProperty -name $partes[0] -Value $partes[1]     
        }
        else
        {
            if ($cont -eq 1)
            {
                $registro | add-member -membertype NoteProperty -name $partes[0] -Value $partes[1]     
            }
            else
            {
                 $registro | add-member -membertype NoteProperty -name $partes[0] -Value $partes[1]     
            }
        }
        $cont++
        if($cont -eq 3)
        {
            $registroArray += $registro  
        }    
    }
   
}
try{
    $registroArray| Export-csv -Delimiter ";" $pathSalida -NoTypeInformation #el -notypeinformation sirve para que no grabe que tipo de objeto en el csv
}
catch
{
    Write-Output "Error al exportar archivo csv"
}


