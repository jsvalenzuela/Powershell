#############################################################################################
# PROGRAM-ID.  ejercicio5.ps1					                                            #
# OBJETIVO DEL PROGRAMA: Realiza backup de archivos                                         #
# TIPO DE PROGRAMA: .ps1                                                                    #
# ARCHIVOS DE SALIDA : El backup tiene que ser la fecha del backup YYYYMMDD.zip             #
# COMENTARIOS:                                                                              # 
# ALUMNOS :                                                                                 #
#           -Gustavo Gonzalez                                                               #
# Ejemplo Ej.:                                                                              #
# C:\PS> .\ejercicio1.ps1 -pathOrigen d:\Archivos -pathDestino d:\Backup                    #
#############################################################################################

<#

.SYNOPSIS
TP2 - PowerShell


.DESCRIPTION
Realiza un backup de un directorio especificado por parámetro
Se recibe por parámetro el directorio que contiene los archivos subidos por los usuarios
Se recibe por parámetro el directorio en donde se guardará el backup.
El nombre del backup tiene el siguiente formato YYYYMMDD.zip

.PARAMETER computername

.PARAMETER filePath

.EXAMPLE
    C:\PS> .\ejercicio1.ps1 -pathOrigen d:\Archivos -pathDestino d:\Backup

.NOTES
    Si hay más de 3 archivos .zip en el directorio del backup se borra el más antiguo

.LINK
N/A

#>
param(
    [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string] $pathOrigen,
    [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()][string] $pathDestino
)

$cantPar = ($psboundparameters.Count + $args.Count)

if( $cantPar -ne 2 )
{
  echo "La cantidad parametros fue distinta a 2!"
  exit
}

try
{
    if(test-path -Path $pathOrigen)
    {
        if(test-path -Path $pathDestino)
        {
            #Archivos .zip ordenados ascendentemente por fecha de creacion (primero el mas antiguo), se guardan en un array
            $Archivos = ls -LiteralPath $pathOrigen -File *.zip| Sort-Object -Property CreationTime
            #Si hay mas de 3 archivos .zip
            if ($Archivos.Length -gt 3)
            {
                #con -First n indico que seleccione los n primeros registros                    
                $aux = $Archivos | select -First 1
                #elimina un directorio o archivo, en este caso le pasamos la ruta absoluta del .zip a borrar
                Remove-Item $pathDestino"\"$aux            
            }     
            #Agrego la libreria necesaria para comprimir archivos                           
            Add-Type -Assembly "System.IO.Compression.FileSystem" 
            $instancia = [System.IO.Compression.ZipFile]
            try
            {
                #Guardo la fecha actual para el nombre del backup
                $Filename= get-date -Format yyyMMdd
                $pathDestino = $pathDestino.Insert($pathDestino.Length,"\"+ $filename +".zip")
                $instancia::CreateFromDirectory($pathOrigen,$pathDestino)
                echo "Backup creado correctamente"
            }
            Catch [System.IO.IOException]
            {
                echo "El archivo ya existe."
            }
            Catch
            {
                echo "Error al crear el archivo comprimido."   
            }
         }
         else
         {
            echo "$($pathDestino) Path de salida no valido"
            exit 1
         }
     }
     else
     {
        echo "$($pathOrigen) Path de origen no valido"
        exit 1;
     }
}
catch
{
    echo "Error al ejecutar el script"
}
