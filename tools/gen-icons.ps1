# Genera el logo de STICK LIFE y todos sus iconos dibujandolos vectorialmente a cada tamano.
# La marca: una cuadricula de habitos de 3x3 en la que las casillas cumplidas suben en escalera
# hacia la derecha (constancia que crece). Casilla cumplida = solida; pendiente = solo contorno.
# Misma estetica de la STICK SUITE: glifo blanco plano, esquinas redondeadas, sobre #1E1F1F.
# Uso: powershell -ExecutionPolicy Bypass -File tools\gen-icons.ps1   (desde la raiz del proyecto)
Add-Type -AssemblyName System.Drawing

$OUT = Split-Path -Parent $PSScriptRoot
$FG  = [System.Drawing.Color]::FromArgb(255, 255, 255) # #FFFFFF
$BG  = [System.Drawing.Color]::FromArgb(30, 31, 31)    # #1E1F1F

# Proporciones relativas a la casilla (c = 1)
$GAP    = 0.28   # separacion entre casillas
$RADIO  = 0.30   # radio de esquina
$TRAZO  = 0.16   # grosor del contorno de una casilla pendiente
$TOTAL  = 3 + 2*$GAP
# 1 = cumplida (solida), 0 = pendiente (contorno). Fila 0 = arriba.
$MAPA = @(
  @(0, 0, 1),
  @(0, 1, 1),
  @(1, 1, 1)
)

function Get-Redondeado([float]$x, [float]$y, [float]$w, [float]$r) {
  $p = New-Object System.Drawing.Drawing2D.GraphicsPath
  $d = 2*$r
  $p.AddArc($x, $y, $d, $d, 180, 90)
  $p.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
  $p.AddArc($x + $w - $d, $y + $w - $d, $d, $d, 0, 90)
  $p.AddArc($x, $y + $w - $d, $d, $d, 90, 90)
  $p.CloseFigure()
  return $p
}

function New-Icon($size, $coverage, $path) {
  $bmp = New-Object System.Drawing.Bitmap $size, $size
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
  $g.Clear($BG)

  $c  = ($size * $coverage) / $TOTAL      # lado de una casilla en pixeles
  $x0 = ($size - $TOTAL*$c) / 2.0
  $y0 = ($size - $TOTAL*$c) / 2.0
  $brush = New-Object System.Drawing.SolidBrush $FG
  $t = $TRAZO * $c
  $pen = New-Object System.Drawing.Pen $FG, ([float]$t)

  for ($fila = 0; $fila -lt 3; $fila++) {
    for ($col = 0; $col -lt 3; $col++) {
      $x = $x0 + $col*$c*(1 + $GAP)
      $y = $y0 + $fila*$c*(1 + $GAP)
      if ($MAPA[$fila][$col] -eq 1) {
        $p = Get-Redondeado $x $y $c ($RADIO*$c)
        $g.FillPath($brush, $p)
      } else {
        # El contorno se dibuja hacia adentro: el borde exterior coincide con el de una solida
        $p = Get-Redondeado ($x + $t/2) ($y + $t/2) ($c - $t) ([Math]::Max(0.5, $RADIO*$c - $t/2))
        $g.DrawPath($pen, $p)
      }
      $p.Dispose()
    }
  }

  $pen.Dispose(); $brush.Dispose(); $g.Dispose()
  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  "{0}  ->  {1}px (cobertura {2})" -f (Split-Path $path -Leaf), $size, $coverage
}

New-Icon 2000 0.50  (Join-Path $OUT "LOGO.png")
New-Icon 512  0.56  (Join-Path $OUT "icon-512.png")
New-Icon 192  0.56  (Join-Path $OUT "icon-192.png")
New-Icon 180  0.60  (Join-Path $OUT "apple-touch-icon.png")
New-Icon 64   0.82  (Join-Path $OUT "favicon.png")
