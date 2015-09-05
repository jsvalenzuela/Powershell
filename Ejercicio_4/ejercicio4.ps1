
  param
  (
    [Parameter(ValueFromPipeline=$true, mandatory = $true)]
    $path
  )
 
   $linea = (Get-Content $path)
   $palabras = @{}
   
   
    foreach($auxLinea in $linea)
    {
       
        $camposLinea = $auxLinea.split(' ')
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
    }
    $palabras | Format-Table
    
  