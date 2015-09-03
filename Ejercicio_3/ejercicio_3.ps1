Param(
[Parameter(Position = 1, Mandatory = $true)][String]$pathEntrada,
[Parameter(Position = 1, Mandatory = $true)][String]$pathSalida
)
$linea = (Get-Content $pathEntrada)
$cont = 0

$registroArray =@() #inicializo array


foreach($aux in  $linea)
{
    if($aux -eq "***"){
        $cont = 0
    }
    else
    {
        
        $partes = $aux.Split('=')
        
        if($cont -eq 0) 
        {
             $registro = new-object PSObject
             $registro | add-member -membertype NoteProperty -name "campo1" -Value $partes[1]     
        }
        else
        {
            if ($cont -eq 1)
            {
                $registro | add-member -membertype NoteProperty -name "campo2" -Value $partes[1]     
            }
            else
            {
                 $registro | add-member -membertype NoteProperty -name "campo3" -Value $partes[1]     
            }
        }
        $cont++
        if($cont -eq 3)
        {
            $registroArray += $registro  
        }    
    }
   
}
$registroArray| Export-csv $pathSalida -notypeinformation #el -notypeinformation sirve para que no grabe que tipo de objeto en el csv


