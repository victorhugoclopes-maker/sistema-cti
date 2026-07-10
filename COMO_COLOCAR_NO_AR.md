# Como colocar o Sistema CTI no ar

Sistema simples em HTML/JS puro — sem necessidade de instalar nada no computador. Funciona com **Supabase** (banco de dados + login) e **Vercel** (hospedagem).

## Passo 1 — Criar conta no Supabase (banco de dados)

1. Acesse https://supabase.com e crie uma conta gratuita (pode usar o Google)
2. Clique em "New Project"
3. Dê um nome (ex: `cti-maquinas`), crie uma senha forte para o banco (guarde ela) e escolha a região mais próxima (ex: São Paulo)
4. Aguarde uns 2 minutos até o projeto ficar pronto

## Passo 2 — Criar as tabelas

1. No painel do Supabase, vá em **SQL Editor** (menu lateral) > **New query**
2. Abra o arquivo `schema.sql` que veio junto com este projeto, copie todo o conteúdo e cole no editor
3. Clique em **Run** — isso cria as tabelas de clientes, equipamentos e ordens de serviço
4. Repita o mesmo processo com o arquivo `schema_estoque.sql` (New query > colar > Run) — isso adiciona as tabelas de estoque de peças
5. Repita novamente com o arquivo `schema_vendas.sql` — isso adiciona as tabelas de vendas
6. Repita com o arquivo `schema_orcamento.sql` — adiciona os campos de orçamento automático

## Passo 3 — Pegar as chaves de acesso

1. No painel do Supabase, vá em **Project Settings** (ícone de engrenagem) > **API**
2. Copie a **Project URL** e a chave **anon public**
3. Abra o arquivo `js/config.js` deste projeto e cole nos campos:
   ```
   const SUPABASE_URL = 'cole aqui a Project URL';
   const SUPABASE_ANON_KEY = 'cole aqui a anon public key';
   ```

## Passo 4 — Criar seu usuário de login

1. No Supabase, vá em **Authentication** > **Users** > **Add user**
2. Cadastre seu e-mail e uma senha — repita para os outros membros da família que vão usar o sistema
3. Esse será o login usado na tela inicial do sistema

## Passo 5 — Colocar o site no ar (Vercel)

**Opção mais simples (arrastar e soltar):**
1. Acesse https://vercel.com e crie uma conta gratuita
2. No painel, clique em **Add New** > **Project**
3. Escolha a opção de importar uma pasta / fazer upload direto, e envie a pasta `sistema-cti` completa (já com o `config.js` preenchido)
4. Clique em **Deploy**

Em menos de 1 minuto o Vercel te dá um link (tipo `cti-maquinas.vercel.app`) que funciona de qualquer lugar — celular, notebook, etc.

## Passo 6 — Instalar como "app" no celular

1. Abra o link do sistema no navegador do celular (Chrome/Safari)
2. Toque no menu (⋮ ou ícone de compartilhar) > **Adicionar à tela inicial**
3. Vai aparecer um ícone igual um app — abre em tela cheia

---

## Se precisar de ajuda

Qualquer erro no console do navegador (F12 > Console) geralmente indica se é problema de chave do Supabase ou de permissão (RLS). Me manda o print do erro que eu te ajudo a resolver.
