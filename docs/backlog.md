# Backlog — Leve Sabor (v2.0 Monorepo)

> **Formato:** User Story + Tarefas técnicas granulares.
> Cada tarefa deve caber em **1 dia de trabalho de 1 desenvolvedor**.
> **Legenda de status:** ✅ Implementado · ⬜ Pendente · ⚠️ Parcial

---

## Resumo por Sprint (Ativas)

| Sprint                 | Foco Principal                                       | Tarefas     | Esforço | Status      | Critérios de "Pronto" (Done)                                                                                                            |
| ---------------------- | ---------------------------------------------------- | ----------- | ------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Sprint 1 (Sem 1–2)** | v2.0 — Reestruturação do Repo, Infra e Core Domain   | T-01 a T-04 | ~4d dev | ⚠️ Pendente | Repositório atual convertido para workspace Melos; DB PostgreSQL rodando via Docker; modelos centrais criados; Supabase integrado.      |
| **Sprint 2 (Sem 3–4)** | v2.0 — Backend API Core (Dart Frog) e Upload S3      | T-05 a T-09 | ~5d dev | ⬜ Pendente | Endpoints REST criados com acesso validado via JWT (Supabase); geração de Pre-signed URLs do AWS S3 operante.                           |
| **Sprint 3 (Sem 5–6)** | v2.0 — Shared Packages & App Admin Web (CMS)         | T-10 a T-14 | ~5d dev | ⬜ Pendente | Pacotes de Design e Network consolidados; Admin web logando via RBAC e gerenciando (CRUD) Estabelecimentos e Posts do Blog.             |
| **Sprint 4 (Sem 7–8)** | v2.0 — Migração do App Mobile (Clean Arch + PostGIS) | T-15 a T-18 | ~5d dev | ⬜ Pendente | Código legado refatorado para consumir os novos pacotes; busca geoespacial funcionando; leitura de blog e favoritos ativa via Riverpod. |

---

## Épico 01 — Infraestrutura Monorepo e Core Domain

**Como** arquiteto de software, **quero** reestruturar o repositório atual para um monorepo e modelar os dados centrais de forma agnóstica, **para** que o frontend e o backend possam compartilhar 100% da lógica de entidades e DTOs sem duplicação de código.

### US-01 — Setup do Workspace Melos e Bancos de Dados

| ID       | Tarefa Técnica                                                                                                                                                                                                                       | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | ------ | ------ |
| **T-01** | Reestruturação do Repositório: mover o código Flutter atual para `apps/app_mobile_legacy`. Criar o arquivo `melos.yaml` na raiz, configurar scripts de bootstrap, formatação e estruturar as pastas base (`apps/` e `packages/`).    | 0.5d    | S1     | ⚠️     |
| **T-02** | Setup do `docker-compose.yaml` local na raiz do repositório: provisionamento de container PostgreSQL (idealmente com PostGIS habilitado) e pgAdmin/Adminer para interface de gerência.                                               | 0.5d    | S1     | ✅     |
| **T-03** | Criar pacote `core_domain`: extrair modelos antigos (`Business`, `BlogPost`, `User`, `Category`) e reescrevê-los como entidades puras em Dart usando `freezed` e `json_serializable` para garantir tipagem estrita entre as camadas. | 1d      | S1     | ⚠️     |

### US-02 — Identidade e Acesso (Supabase Auth)

| ID       | Tarefa Técnica                                                                                                                                                                                                                      | Esforço | Sprint | Status |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-04** | Criar pacote `auth_client`: integração do SDK do Supabase Flutter. Implementar providers do Riverpod para gerenciar estado de sessão (signIn, signUp, signOut, getSession) que poderão ser consumidos por qualquer app no monorepo. | 1d      | S1     | ⚠️     |

---

## Épico 02 — Backend API Core (Dart Frog)

**Como** desenvolvedor frontend, **quero** consumir uma API REST rápida, segura e tipada escrita em Dart, **para** abandonar a API antiga e unificar o ecossistema tecnológico do projeto.

### US-03 — CRUD Base e Middlewares de Segurança

| ID       | Tarefa Técnica                                                                                                                                                                                             | Esforço | Sprint | Status |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-05** | Inicialização `apps/backend_api` (Dart Frog): setup da injeção de dependência via `request.context` para os Repositórios de DB. Conexão com Postgres usando o pacote `postgres` ou Prisma ORM.             | 1d      | S2     | ⬜     |
| **T-06** | Middleware de Autenticação JWT: validar token Bearer recebido contra o JWT Secret do Supabase. Injetar o `User` validado no contexto da requisição. Bloquear acesso a rotas protegidas (401 Unauthorized). | 1d      | S2     | ⬜     |
| **T-07** | Rotas CRUD para `businesses` e `blog-posts` (`GET`, `POST`, `PUT`, `DELETE`). Interceptar e validar o payload de entrada usando os DTOs do pacote compartilhado `core_domain`.                             | 1d      | S2     | ⬜     |

### US-04 — Arquitetura de Upload Direto para S3

| ID       | Tarefa Técnica                                                                                                                                                                                                          | Esforço | Sprint | Status |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-08** | Integração AWS S3 no Backend: Criar rota `POST /upload/presigned-url` que aceita content-type e tamanho do arquivo, retornando uma URL temporária (Pre-signed) do S3 para upload direto pelo cliente (expira em 5 min). | 1d      | S2     | ⬜     |
| **T-09** | Schema de Imagens no DB: vincular URLs do S3 aos registros. Criar a estrutura para salvar a referência da imagem (ex: `logo_url` em `business`, `thumbnail_url` em `blog_post`).                                        | 0.5d    | S2     | ⬜     |

---

## Épico 03 — App Admin Web (CMS) e Pacotes Compartilhados

**Como** gestor de conteúdo (Admin), **quero** uma interface web responsiva, **para** aprovar cadastros de restaurantes, criar postagens no blog e atualizar o catálogo.

### US-05 — Extração de Componentes (Shared Packages)

| ID       | Tarefa Técnica                                                                                                                                                                                                     | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | ------ | ------ |
| **T-10** | Criar pacote `design_system`: extrair os arquivos legados (`custom_colors.dart`, `tipografia.dart` e componentes UI como Botões, Inputs e Cards) para este pacote, tornando-os independentes de lógica de negócio. | 1d      | S3     | ⬜     |
| **T-11** | Criar pacote `rest_client`: configurar Dio com Interceptors globais para injetar automaticamente o token JWT (obtido do `auth_client`) em todas as requisições, e criar as classes de abstração da API.            | 0.5d    | S3     | ⬜     |

### US-06 — Construção do Painel Admin (Flutter Web)

| ID        | Tarefa Técnica                                                                                                                                                                            | Esforço | Sprint | Status |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-12**  | Setup do `apps/app_admin` (Flutter Web): layout base com navegação lateral (Sidebar) roteado via `go_router`. Criar tela de Login restrita para Admins consumindo o `auth_client`.        | 1d      | S3     | ⬜     |
| **T-13**  | Formulário de Estabelecimentos: campos de dados do negócio + upload de logo (requisitando a pre-signed URL ao backend e enviando a imagem via `PUT` diretamente pro AWS S3 pelo browser). | 1d      | S3     | ⬜     |
| **T-14**  | Editor de Blog Posts: tela com grid de gerenciamento (DataTables), formulário de cadastro com editor de Rich Text e vinculação de categorias.                                             | 1d      | S3     | ⬜     |
| **T-14b** | Gerenciamento de Usuários (Admin): Tela com grid para listar usuários, inativar contas e editar perfis/roles (Admin, User, Business_Owner) consumindo APIs administrativas do Supabase.   | 1d      | S3     | ⬜     |

---

## Épico 04 — Refatoração do App Mobile

**Como** usuário final, **quero** utilizar um aplicativo otimizado e moderno, **para** encontrar restaurantes saudáveis perto de mim e consumir conteúdo do blog com alta performance.

### US-07 — Busca Geoespacial e Refatoração do Diretório

| ID       | Tarefa Técnica                                                                                                                                                                                                           | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | ------ | ------ |
| **T-15** | Inicializar `apps/app_mobile` (Clean Architecture): portar as telas legadas de autenticação e navegação base. Substituir a injeção do Kiwi/BLoC legado por Riverpod para gerência de estado das listas.                  | 1d      | S4     | ⬜     |
| **T-16** | Query PostGIS no Dart Frog (Backend): criar rota `GET /businesses/nearby?lat=X&lng=Y&radius=Z` utilizando a função `ST_DWithin` do PostgreSQL/PostGIS para retornar resultados baseados na localização atual do usuário. | 1d      | S4     | ⬜     |
| **T-17** | Refatorar UI do Diretório: Integrar permissão de GPS nativa. Consumir a rota `nearby`, aplicar filtros avançados, implementar visualização em Mapa interativo e criar tela isolada de Detalhes do Estabelecimento.       | 1.5d    | S4     | ⬜     |

### US-08 — Experiência do Blog

| ID       | Tarefa Técnica                                                                                                                                                                                     | Esforço | Sprint | Status |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-18** | Refatorar visualizador de Blog: Implementar listagem com barra de busca e filtros de categoria. Criar tela de Detalhes do Post (viewer) e atualizar lógica de favoritos interagindo com o backend. | 1d      | S4     | ⬜     |

---

## Tarefas Técnicas Transversais (QA & CI/CD)

> Infraestrutura que viabiliza a manutenção a longo prazo do monorepo e portfólio.

| ID       | Tarefa Técnica                                                                                                                                                                                            | Esforço | Sprint | Status |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-19** | Configurar GitHub Actions (CI): pipeline rodando `melos run format`, `melos run analyze` e `melos run test` sempre que houver PR para a branch principal.                                                 | 0.5d    | S2     | ⬜     |
| **T-20** | Testes Unitários de Backend: criar suíte de testes usando `mocktail` para mockar o banco de dados e garantir funcionamento adequado dos endpoints críticos no Dart Frog.                                  | 1d      | S4     | ⬜     |
| **T-21** | Tela de Perfil: Criar interface para edição de dados pessoais (nome, bio), upload de avatar (via AWS S3) e gerenciamento de conta (logout, excluir conta). Sincronizar dados via Supabase Auth e backend. | 1d      | S4     | ⬜     |

---

## Plano de Execução Recomendado (Ordem Lógica)

> A lista abaixo ordena a execução por **dependências arquiteturais**, mitigando riscos de bloqueios.

### Sprint 2 (Backend & Serviços de Nuvem)

**Fase 1: Motor da API**

1. `T-05` — Setup Dart Frog e Repositórios SQL.
2. `T-06` — JWT Middleware no Dart Frog.
3. `T-07` — Rotas CRUD de Blog e Business.

**Fase 2: Arquivos e Nuvem** 4. `T-08` — AWS S3 Pre-signed URL Endpoint. 5. `T-09` — Integração das imagens no Banco. 6. `T-19` — Configurar pipeline CI (Para já garantir qualidade nos próximos commits).

### Sprint 3 (Pacotes Compartilhados & Admin CMS)

**Fase 1: Camada de Componentes (Bloqueadores para UI)**

1. `T-10` — Extrair pacote Design System do legado.
2. `T-11` — Pacote Rest Client (Dio configurado).

**Fase 2: Aplicação Web** 3. `T-12` — Estrutura e Auth no Admin Web. 4. `T-13` — CRUD de Estabelecimentos na Web (Consome o T-08 para upload). 5. `T-14` — Editor de Posts do Blog Web. 6. `T-14b` — Gerenciamento de Usuários (Admin) consumindo a Service Role do Supabase via backend ou API dedicada.

### Sprint 4 (Mobile Cleanup & Funcionalidades Novas)

**Fase 1: Dados Complexos**

1. `T-16` — Backend: Query Geoespacial (Necessário para o app mobile real-time).

**Fase 2: App User-Facing** 2. `T-15` — Estrutura Base Mobile refatorada para usar Riverpod + Pacotes. 3. `T-17` — Mobile: Atualizar tela de Diretório + GPS (Consome o T-16). 4. `T-18` — Mobile: Refatorar Blog Viewer e Favoritos. 4. `T-21` Mobile: Perfil do Usuário (Edição de dados, Upload de Avatar via S3 e Gestão da Conta).

**Fase 3: Qualidade Final** 5. `T-20` — Testes Unitários de Backend para fechar a estabilidade da API.

<!-- TODO -->
<!-- Run dart pub global activate melos -->
<!-- Run melos bootstrap -->

<!-- cd packages/auth_client
dart run build_runner build -d
run melos bootstrap from the root
flutter test -->

<!-- cd packages/core_domain
dart run build_runner build -d
run melos bootstrap from the root
flutter test -->