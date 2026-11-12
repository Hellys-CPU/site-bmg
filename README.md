# Site da BMG

Página única, pronta para celular, sem custo de hospedagem.

## O que preencher com a BMG

No fim do `index.html` tem um bloco só com os dados da BMG. É só preencher:

```js
const BMG = {
  whatsapp: '5511947478815',  // WhatsApp da BMG, com 55 e DDD
  email: 'transportebmg@outlook.com',
  endereco: { rua: 'Rua Romão Martins, 174', bairro: 'Jardim Santo Elias, Pirituba', cidade: 'São Paulo', uf: 'SP', cep: '05135-340' },
  regioes: [],   // ex.: ['Grande São Paulo', 'Interior de SP']
  veiculos: ['Fiorino', 'Truck'],  // tipos que a BMG tem: 'Fiorino', 'VUC', '3/4', 'Toco', 'Truck', 'Bitruck', 'Carreta'
  redes: [],     // endereços do Instagram, LinkedIn e Perfil no Google
  base: { cidade: 'São Paulo', lat: -23.496, lon: -46.748 },  // de onde os caminhões saem
  destinos: [   // km pela estrada saindo da base
    { cidade: 'Jundiaí', uf: 'SP', km: 46, lat: -23.1888, lon: -46.8845 },
    // ... Campinas, Santos, São José dos Campos, Jaú
  ]
};
```

Enquanto um dado estiver vazio, o site mostra o espaço marcado entre colchetes. Os veículos aparecem nos serviços, nas perguntas e nos formulários, a partir da lista `veiculos`.

### Mapa de cobertura

Em "Rotas a partir de São Paulo" tem um mapa com linhas saindo da base até cada cidade, com a distância pela estrada, e a placa verde com as mesmas cidades. Os dois se montam sozinhos a partir de `base` e `destinos`:

- `lat` e `lon`: no Google Maps, clique com o botão direito na cidade e copie os dois números (o primeiro é a latitude).
- `km`: a distância pela estrada, da base até a cidade (a rota do Google Maps serve). As de hoje saíram do OpenStreetMap, de Pirituba até o centro de cada cidade.
- O mapa calcula a direção de cada cidade pela latitude e longitude, desenha os anéis de distância e posiciona os nomes sem cobrir os pontos. Na placa, a seta de cada cidade aponta para a direção dela.
- Sempre aparece uma rota tracejada "Outros destinos · sob acordo", no maior espaço livre do mapa, e a última linha da placa leva para a cotação: a lista não é tudo o que a BMG faz.
- Os nomes das cidades também entram sozinhos na abertura, no texto do mapa e na pergunta "Para quais cidades vocês fazem frete?".

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

- Título, descrição e H1 com "Transportadora em São Paulo", o que as empresas digitam no Google, e as cidades das rotas na descrição.
- As cidades atendidas em texto de verdade (abertura, placa verde, perguntas), não só no desenho do mapa, para o Google ler "frete para Campinas", "transportadora Jundiaí" e parecidas.
- Endereço completo no rodapé e na pergunta "Onde fica a BMG?", com link para o Google Maps.
- Um único H1, títulos em ordem, textos alternativos nas imagens, versão para celular e imagem de compartilhamento.
- Ícone em arquivo (`favicon.svg` e `favicon-192.png`) e `robots.txt`.
- Dados estruturados montados a partir do bloco `BMG`: o nome do site (o que o Google mostra no resultado), a empresa local com endereço, coordenadas, link do mapa, serviços, veículos, contato, cidades atendidas, os perfis (`redes`) e as perguntas frequentes.
- O 3D do topo só carrega depois do resto da página, para o site abrir rápido no celular.

### Para a BMG ser fácil de achar

O site sozinho não basta. Em ordem de efeito:

1. **Domínio próprio e tirar o `noindex`** (próxima seção). Enquanto o site estiver na demonstração, o Google não mostra nada.
2. **Perfil da Empresa no Google** (Google Meu Negócio): é o que aparece em "transportadora perto de mim" e no Google Maps. Nome `BMG Transporte`, categoria de transportadora, o mesmo endereço e telefone do site, o link do site, fotos dos veículos e os posts do mês. A verificação é feita por alguém da BMG.
3. **Mesmo nome, endereço e telefone em todo lugar**: site, Perfil no Google, Instagram, LinkedIn e WhatsApp Business. O Google confia mais quando os dados batem.
4. **Avaliações no Google**: pedir para clientes satisfeitos avaliarem o Perfil da Empresa. Pesa muito na busca local.
5. **Bing Places e Apple Business Connect** (grátis): o Bing importa o perfil do Google, e o Apple Business Connect põe a BMG no Mapas do iPhone.
6. **Google Search Console** com o sitemap, no dia do domínio, para acompanhar por quais buscas o site aparece.
7. **Link do site** na bio do Instagram, no LinkedIn e no WhatsApp Business, e os endereços desses perfis em `redes`.

### No dia do domínio

Um comando faz tudo o que depende do domínio: tira o `noindex`, coloca o endereço oficial (canonical, `og:url` e imagem de compartilhamento), cria o `sitemap.xml` e o `CNAME` do GitHub Pages e liga o sitemap no `robots.txt`. O título já tem "Transportadora em São Paulo"; o `-Cidade` só serve se a cidade do título mudar.

```powershell
powershell -ExecutionPolicy Bypass -File .\ativar-dominio.ps1 -Dominio www.DOMINIO.com.br
```

No fim, ele mostra o que falta: enviar para o GitHub, criar os registros no Registro.br e cadastrar o site no Google Search Console. Depois, coloque o link do site no Perfil da Empresa no Google, no Instagram, no LinkedIn e no WhatsApp Business, e os endereços desses perfis em `redes`.

## Publicar no GitHub Pages (grátis)

1. Crie um repositório no GitHub (por exemplo, `site-bmg`) e envie o `index.html`.
2. No repositório, abra **Settings > Pages**, escolha a branch `main` e salve.
3. Para usar o domínio próprio (ex.: `www.bmg....com.br`), coloque o domínio em **Custom domain** e crie no Registro.br um registro CNAME apontando para `SEU-USUARIO.github.io`.
