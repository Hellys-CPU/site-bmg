# Site da BMG

Página única, pronta para celular, sem custo de hospedagem.

## O que preencher com a BMG

No fim do `index.html` tem um bloco só com os dados da BMG. É só preencher:

```js
const BMG = {
  whatsapp: '',  // número do robô, com 55 e DDD. Ex.: '5511999998888'
  email: '',
  endereco: '',
  regioes: [],   // ex.: ['Grande São Paulo', 'Interior de SP']
  veiculos: ['Fiorino', 'Truck'],  // tipos que a BMG tem: 'Fiorino', 'VUC', '3/4', 'Toco', 'Truck', 'Bitruck', 'Carreta'
  redes: [],     // endereços do Instagram, LinkedIn e Perfil no Google
  base: { cidade: '', lat: null, lon: null },  // de onde os caminhões saem
  destinos: []  // ex.: { cidade: 'Cidade', uf: 'SP', km: 95, lat: -22.90, lon: -47.06 }
};
```

Enquanto um dado estiver vazio, o site mostra o espaço marcado entre colchetes. Os veículos aparecem nos serviços, nas perguntas e nos formulários, a partir da lista `veiculos`.

### Mapa de cobertura

Em "Regiões atendidas" tem um mapa com linhas saindo da base até cada cidade, com a distância pela estrada. Ele se monta sozinho a partir de `base` e `destinos`:

- `lat` e `lon`: no Google Maps, clique com o botão direito na cidade e copie os dois números (o primeiro é a latitude).
- `km`: a distância pela estrada, da base até a cidade (a rota do Google Maps serve).
- O mapa calcula a direção de cada cidade pela latitude e longitude, desenha os anéis de distância e posiciona os nomes sem cobrir os pontos.

Enquanto `base` ou `destinos` estiverem vazios, o mapa mostra linhas de exemplo marcadas entre colchetes, sem nomes de cidade nem distâncias.

## Arquivos

| Arquivo | O que é |
|---|---|
| `index.html` | O site |
| `bmg-logo.jpg` | Logo da BMG (topo, rodapé e baú do caminhão) |
| `og-bmg.jpg` | Imagem que aparece quando o link é compartilhado no WhatsApp e nas redes |
| `apple-touch-icon.png` | Ícone quando o site é salvo na tela do celular |
| `favicon.svg`, `favicon-192.png` | Ícone da aba do navegador e dos resultados do Google |
| `robots.txt` | Libera o site para os buscadores (o sitemap entra no dia do domínio) |
| `ativar-dominio.ps1` | Liga o site ao domínio oficial (veja "No dia do domínio") |

Quando o domínio estiver no ar, troque `og-bmg.jpg` no `index.html` pelo endereço completo (`https://.../og-bmg.jpg`), para a imagem aparecer nos compartilhamentos.

## Como os formulários funcionam

Os dois formulários abrem o WhatsApp da BMG com a mensagem pronta. O robô já entende as duas:

- **Seja nosso agregado**: a mensagem começa com "Quero ser agregado da BMG". O robô responde ao motorista, avisa o gestor e o cadastro aparece no Painel de Rotas.
- **Pedir cotação**: a mensagem começa com "Pedido de cotação pelo site". O robô passa a conversa para o negociador.

## Demonstração

Esta versão é de demonstração e tem `<meta name="robots" content="noindex, nofollow">` no começo do `index.html`, para não aparecer no Google. Quando o site virar o oficial, apague essa linha.

## SEO

Já está no site:

- Título e descrição com "transportadora", o termo que as empresas procuram.
- Um único H1, títulos em ordem, textos alternativos nas imagens, versão para celular e imagem de compartilhamento.
- Ícone em arquivo (`favicon.svg` e `favicon-192.png`) e `robots.txt`.
- Dados estruturados montados a partir do bloco `BMG`: o nome do site (o que o Google mostra no resultado), a empresa com serviços, veículos, contato, regiões e cidades do mapa, os perfis (`redes`) e as perguntas frequentes.
- O 3D do topo só carrega depois do resto da página, para o site abrir rápido no celular.

### No dia do domínio

Um comando faz tudo o que depende do domínio: tira o `noindex`, coloca o endereço oficial (canonical, `og:url` e imagem de compartilhamento), põe a cidade no título, cria o `sitemap.xml` e o `CNAME` do GitHub Pages e liga o sitemap no `robots.txt`.

```powershell
powershell -ExecutionPolicy Bypass -File .\ativar-dominio.ps1 -Dominio www.DOMINIO.com.br -Cidade "Cidade/UF"
```

No fim, ele mostra o que falta: enviar para o GitHub, criar os registros no Registro.br e cadastrar o site no Google Search Console. Depois, coloque o link do site no Perfil da Empresa no Google, no Instagram, no LinkedIn e no WhatsApp Business, e os endereços desses perfis em `redes`.

## Publicar no GitHub Pages (grátis)

1. Crie um repositório no GitHub (por exemplo, `site-bmg`) e envie o `index.html`.
2. No repositório, abra **Settings > Pages**, escolha a branch `main` e salve.
3. Para usar o domínio próprio (ex.: `www.bmg....com.br`), coloque o domínio em **Custom domain** e crie no Registro.br um registro CNAME apontando para `SEU-USUARIO.github.io`.
