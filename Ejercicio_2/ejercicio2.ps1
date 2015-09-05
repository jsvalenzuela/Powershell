#############################################################################################
# PROGRAM-ID.  ejercicio2.ps1					                                            #
# OBJETIVO DEL PROGRAMA: Copia archivos de un directorio a otro                             #
# TIPO DE PROGRAMA: .ps1                                                                    #
# ARCHIVOS DE SALIDA : Log                                                                  #
# COMENTARIOS: El script Copia a un directorio todos los archivos de texto que contengan    #
# una cadena determinada. Debe recibir por parámetro la cadena a buscar, el directorio      #
# de origen  y el de destino.                                                               #
# directorio. Ambos directorios deben ser pasados por parámetro                             #
# ALUMNOS :                                                                                 #
#           - 
#           -Gustavo Gonzalez                                                               #
# EjemploEj.:                                                                               #
# PS D:\tp> .\Ejercicio2.ps1 -pathOrigen 'E:\DC COMICS' -pathDestino E:\tp  -cadena Prueba  #
#############################################################################################
<#
.SYNOPSIS

El script Copia a un directorio todos los archivos de texto que contengan una cadena determinada
.DESCRIPTION

El script Copia a un directorio todos los archivos de texto que contengan una cadena determinada
Debe recibir por parámetro la cadena a buscar, el directorio de origen y el de destino.
Al finalizar la copia, se debe crear un archivo de log en donde se indique el directorio de origen, 
el tamaño y la fecha de modificación de cada uno de los archivos copiados.
.PARAMETER computername

.PARAMETER filePath

.EXAMPLE

./ejercicio2.ps1 d:\Origen e:\destino Prueba
.EXAMPLE
./ejercicio2.ps1 .\Origen d:\Documentos a
#>

Param
(
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string] $pathOrigen,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string] $pathDestino,
[Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string] $cadena
)
if( $cantPar -ne 3 )
{
  Write-Output "La cantidad parametros fue distinta a 3!"
  exit
}
$pathValidDest = Test-Path $pathDestino;
$pathValidOrigen = Test-Path $pathOrigen;
if($pathValidDest -eq $false)
{
    echo "Path de destino no valido";
    exit;
}
if($pathValidOrigen -eq $false)
{
    echo "Path de origen no valido";
    exit;

}
if($pathDestino -eq $pathOrigen)
{
    echo "Path de origen y de destino no peden ser el mismo";
    exit;
}
if($pathValidOrigen -eq $true -and $pathValidDest -eq $true )
{try{
    $archivos = ls -Path $pathOrigen -Recurse -Include "*.txt" | Where-Object {$_.Name -match "$cadena"};           
}
Catch [UnauthorizedAccessException],[DirUnauthorizedAccessError]{
    Write-Output "No tiene permisos"
}
Catch{
    Write-Output "Error al copiar archivos"
}
foreach($item in $archivos)
{   
    cp $archivos $pathDestino;
    $archivos| Format-List -Property Directory,Length,LastWriteTime > .\Log.txt
}
}