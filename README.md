# Site da BMG

Página única, pronta para celular, sem custo de hospedagem.

## O que preencher com a BMG

No fim do `index.html` tem um bloco só com os dados da BMG. É só preencher:

```js
const BMG = {
  whatsapp: '',  // número do robô, com 55 e DDD. Ex.: '5511999998888'
  email: '',
  endereco: '',
  regioes: []    // ex.: ['Grande São Paulo', 'Interior de SP']
};
```

Enquanto um dado estiver vazio, o site mostra o espaço marcado entre colchetes. Logo e fotos entram quando a BMG mandar.

## Como os formulários funcionam

Os dois formulários abrem o WhatsApp da BMG com a mensagem pronta. O robô já entende as duas:

- **Seja nosso agregado**: a mensagem começa com "Quero ser agregado da BMG". O robô responde ao motorista, avisa o gestor e o cadastro aparece no Painel de Rotas.
- **Pedir cotação**: a mensagem começa com "Pedido de cotação pelo site". O robô passa a conversa para o negociador.

## Demonstração

Esta versão é de demonstração e tem `<meta name="robots" content="noindex, nofollow">` no começo do `index.html`, para não aparecer no Google. Quando o site virar o oficial, apague essa linha.

## Publicar no GitHub Pages (grátis)

1. Crie um repositório no GitHub (por exemplo, `site-bmg`) e envie o `index.html`.
2. No repositório, abra **Settings > Pages**, escolha a branch `main` e salve.
3. Para usar o domínio próprio (ex.: `www.bmg....com.br`), coloque o domínio em **Custom domain** e crie no Registro.br um registro CNAME apontando para `SEU-USUARIO.github.io`.
