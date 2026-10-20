# Liga o site ao dominio oficial da BMG. Rode uma vez, no dia em que o dominio estiver registrado.
# Uso, dentro da pasta site-bmg:
#   powershell -ExecutionPolicy Bypass -File .\ativar-dominio.ps1 -Dominio www.dominio.com.br -Cidade "Cidade/UF"
# O que faz: tira o noindex, coloca o endereco oficial (canonical, og:url e imagem de compartilhamento),
# poe a cidade no titulo (se -Cidade vier), cria o sitemap.xml e o CNAME do GitHub Pages e liga o sitemap no robots.txt.
# Pode rodar de novo sem estragar nada.
param(
  [Parameter(Mandatory = $true)][string]$Dominio,
  [string]$Cidade = ''
)
$ErrorActionPreference = 'Stop'
$pasta = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dominio = ($Dominio.Trim() -replace '^https?://', '').Trim('/').ToLower()
if ($Dominio -notmatch '^[a-z0-9-]+(\.[a-z0-9-]+)+$') { Write-Host "Dominio invalido: $Dominio"; exit 1 }
$base = "https://$Dominio/"
$utf8 = New-Object System.Text.UTF8Encoding $false
$arq = Join-Path $pasta 'index.html'
$html = [IO.File]::ReadAllText($arq, [Text.Encoding]::UTF8)
$nl = if ($html.Contains("`r`n")) { "`r`n" } else { "`n" }

# 1. O Google passa a ver o site: saem o noindex e os dois avisos de demonstracao
$html = [regex]::Replace($html, '<!-- Vers[^\r\n]*-->\r?\n', '')
$html = [regex]::Replace($html, '<meta name="robots" content="noindex, nofollow">\r?\n', '')
$html = [regex]::Replace($html, '<!-- Quando o dom[^\r\n]*-->\r?\n', '')

# 2. Endereco oficial, logo depois da descricao
$html = [regex]::Replace($html, '<link rel="canonical"[^>]*>\r?\n', '')
$html = [regex]::Replace($html, '<meta property="og:url"[^>]*>\r?\n', '')
$html = [regex]::Replace($html, '(<meta name="description"[^>]*>)', "`$1$nl<link rel=""canonical"" href=""$base"">$nl<meta property=""og:url"" content=""$base"">")
$html = [regex]::Replace($html, '<meta property="og:image" content="[^"]*og-bmg\.jpg">', "<meta property=""og:image"" content=""${base}og-bmg.jpg"">")

# 3. Cidade no titulo: e o que mais pesa na busca local
if ($Cidade) {
  $titulo = "BMG Transporte $([char]0x00B7) Transportadora em $($Cidade.Trim())"
  $html = [regex]::Replace($html, '<title>[^<]*</title>', "<title>$titulo</title>")
  $html = [regex]::Replace($html, '<meta property="og:title" content="[^"]*">', "<meta property=""og:title"" content=""$titulo"">")
}
[IO.File]::WriteAllText($arq, $html, $utf8)

# 4. Sitemap, robots.txt e CNAME (o CNAME diz ao GitHub Pages qual e o dominio)
$hoje = (Get-Date).ToString('yyyy-MM-dd')
$sitemap = "<?xml version=""1.0"" encoding=""UTF-8""?>$nl<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">$nl  <url><loc>$base</loc><lastmod>$hoje</lastmod></url>$nl</urlset>$nl"
[IO.File]::WriteAllText((Join-Path $pasta 'sitemap.xml'), $sitemap, $utf8)
[IO.File]::WriteAllText((Join-Path $pasta 'robots.txt'), "User-agent: *${nl}Allow: /${nl}${nl}Sitemap: ${base}sitemap.xml${nl}", $utf8)
[IO.File]::WriteAllText((Join-Path $pasta 'CNAME'), "$Dominio$nl", $utf8)

# Para onde o dominio aponta: a conta do GitHub dona do repositorio
$conta = '<sua-conta>'
try { $origem = git -C $pasta remote get-url origin 2>$null; if ($origem -match 'github\.com[:/]([^/]+)/') { $conta = $Matches[1].ToLower() } } catch {}
$raiz = $Dominio -replace '^www\.', ''

Write-Host "Site preparado para $base"
Write-Host ""
Write-Host "Falta:"
Write-Host "1. Enviar: git add -A, git commit -m ""Site no dominio oficial"" e git push"
Write-Host "2. No Registro.br, na zona DNS de $raiz :"
Write-Host "   - CNAME de www apontando para $conta.github.io"
Write-Host "   - Quatro registros A em $raiz : 185.199.108.153, 185.199.109.153, 185.199.110.153 e 185.199.111.153"
Write-Host "3. No GitHub: Settings > Pages > marcar 'Enforce HTTPS' quando a opcao liberar."
Write-Host "4. Google Search Console: adicionar $raiz, confirmar pelo registro TXT no Registro.br e enviar ${base}sitemap.xml"
