# Backlog — Leve Sabor (v2.0 Monorepo)

> **Formato:** User Story + Tarefas técnicas granulares.
> Cada tarefa deve caber em **1 dia de trabalho de 1 desenvolvedor**.
> **Legenda de status:** ✅ Implementado · ⬜ Pendente · ⚠️ Parcial

---

## Resumo por Sprint (Ativas)

| Sprint                 | Foco Principal                                  | Tarefas     | Esforço | Status      | Critérios de "Pronto" (Done)                                                                                                              |
| ---------------------- | ----------------------------------------------- | ----------- | ------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Sprint 1 (Sem 1–2)** | v2.0 — Infraestrutura, Monorepo e Core Domain   | T-01 a T-04 | ~4d dev | ⚠️ Parcial  | Workspace Melos configurado; DB PostgreSQL + PostGIS rodando via Docker; modelos centrais criados; Supabase integrado.                    |
| **Sprint 2 (Sem 3–4)** | v2.0 — Backend API Core (Dart Frog) e Upload S3 | T-05 a T-09 | ~5d dev | ⬜ Pendente | Endpoints REST criados com acesso validado via JWT (Supabase); geração de Pre-signed URLs do AWS S3 operante.                             |
| **Sprint 3 (Sem 5–6)** | v2.0 — Shared Packages & App Admin Web (CMS)    | T-10 a T-14 | ~5d dev | ⬜ Pendente | Pacote de Design System consolidado; Admin web logando via RBAC e gerenciando (CRUD) Estabelecimentos e Posts do Blog.                    |
| **Sprint 4 (Sem 7–8)** | v2.0 — App Mobile (Busca Geoespacial e Blog)    | T-15 a T-18 | ~5d dev | ⬜ Pendente | App mobile compilando; busca de estabelecimentos "próximos a mim" via PostGIS funcionando; leitura de blog e marcação de favoritos ativa. |

---

## Épico 1 — Infraestrutura Monorepo e Core Domain

**Como** arquiteto de software, **quero** estabelecer a base do monorepo em Dart e modelar os dados centrais de forma agnóstica, **para** que o frontend e o backend possam compartilhar 100% da lógica de entidades e DTOs sem duplicação de código.

### US-01 — Setup do Workspace e Bancos de Dados

| ID       | Tarefa Técnica                                                                                                                                                                           | Esforço | Sprint | Status |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-01** | Inicialização do monorepo via `melos`: criação do `melos.yaml`, scripts de bootstrap, formatação e testes em lote. Estruturação das pastas `apps/` e `packages/`.                        | 0.5d    | S1     | ✅     |
| **T-02** | Setup do `docker-compose.yaml` local: provisionamento de container PostgreSQL com extensão PostGIS habilitada e pgAdmin/Adminer para interface de gerência.                              | 0.5d    | S1     | ✅     |
| **T-03** | Pacote `core_domain`: criação de entidades puras em Dart (Business, BlogPost, User, Category) usando `freezed` e `json_serializable` para garantir tipagem e serialização entre camadas. | 1d      | S1     | ⚠️     |

### US-02 — Identidade e Acesso (Supabase Auth)

| ID       | Tarefa Técnica                                                                                                                                                                                      | Esforço | Sprint | Status |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-04** | Pacote `auth_client`: integração do SDK do Supabase Flutter. Implementar singleton/providers do Riverpod para gerenciar estado de sessão (signIn, signUp, signOut, getSession) independente do app. | 1d      | S1     | ⬜     |

---

## Épico 2 — Backend API Core (Dart Frog)

**Como** desenvolvedor frontend, **quero** consumir uma API REST rápida, segura e tipada, **para** renderizar as listas de estabelecimentos e artigos do blog sem me preocupar com acesso direto ao banco ou integrações de terceiros.

### US-03 — CRUD Base e Middlewares de Segurança

| ID       | Tarefa Técnica                                                                                                                                                                          | Esforço | Sprint | Status |
| -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-05** | Inicialização `apps/backend_api` (Dart Frog): setup da injeção de dependência via contexto para os Repositórios de Banco de Dados. Conexão com Postgres usando pacote `postgres`.       | 1d      | S2     | ⬜     |
| **T-06** | Middleware de Autenticação JWT: validar token Bearer recebido contra o secret do Supabase. Injetar o `User` decodificado no `RequestContext` do Dart Frog. Rotas públicas x protegidas. | 1d      | S2     | ⬜     |
| **T-07** | Rotas CRUD para `businesses` e `blog-posts` (`GET`, `POST`, `PUT`, `DELETE`). Validação de payload usando os DTOs do pacote `core_domain`.                                              | 1d      | S2     | ⬜     |

### US-04 — Arquitetura de Upload AWS S3

| ID       | Tarefa Técnica                                                                                                                                                                                       | Esforço | Sprint | Status |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-08** | Integração AWS S3 no Backend: Rota `POST /upload/presigned-url` que aceita content-type e tamanho do arquivo, retornando uma URL temporária (Pre-signed) para upload direto, expirando em 5 minutos. | 1d      | S2     | ⬜     |
| **T-09** | Tabela de Imagens: vincular URLs finais aos registros (ex: `logo_url` na tabela `business`, `thumbnail_url` no `blog_post`).                                                                         | 0.5d    | S2     | ⬜     |

---

## Épico 3 — App Admin Web (CMS)

**Como** gestor de conteúdo (Admin), **quero** uma interface web responsiva, **para** aprovar cadastros de restaurantes, criar postagens no blog e atualizar o catálogo sem precisar editar o banco de dados.

### US-05 — Shared Packages (Design & Network)

| ID       | Tarefa Técnica                                                                                                                                                            | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-10** | Pacote `design_system`: migrar `custom_colors.dart`, `tipografia.dart` (TripSans) e componentes reutilizáveis (Botões, Inputs, Tags, Cards) para um package independente. | 1d      | S3     | ⬜     |
| **T-11** | Pacote `rest_client`: configurar Dio com Interceptors para injetar automaticamente o token JWT (obtido do `auth_client`) em todas as requisições para a API Dart Frog.    | 0.5d    | S3     | ⬜     |

### US-06 — Gestão de Conteúdo e Formulários

| ID       | Tarefa Técnica                                                                                                                                                           | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | ------ | ------ |
| **T-12** | Setup do `apps/app_admin` (Flutter Web): layout base (Sidebar + Topbar), roteamento via `go_router`, e tela de Login para Admins consumindo `auth_client`.               | 1d      | S3     | ⬜     |
| **T-13** | Formulário de Criação/Edição de Estabelecimentos: campos textuais + upload de logo (requisitando a pre-signed URL ao backend e enviando via PUT diretamente pro AWS S3). | 1d      | S3     | ⬜     |
| **T-14** | Editor de Blog Posts: tela com grid de posts, formulário de cadastro, integração com editor de Rich Text e filtro por categoria.                                         | 1d      | S3     | ⬜     |

---

## Épico 4 — App Mobile (UX e Localização)

**Como** usuário final focado em saúde, **quero** abrir o app no meu celular e ver restaurantes saudáveis perto de mim e ler as últimas postagens do blog, **para** manter meu estilo de vida sustentável.

### US-07 — Busca Geoespacial e Diretório

| ID       | Tarefa Técnica                                                                                                                                                                       | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------- | ------ | ------ |
| **T-15** | Setup do `apps/app_mobile` (iOS/Android): consumir `design_system`, fluxo de login/cadastro de usuários (RBAC: User) e tela Home. Refatorar State Management para Riverpod.          | 1d      | S4     | ⬜     |
| **T-16** | Query PostGIS no Dart Frog: rota `GET /businesses/nearby?lat=X&lng=Y&radius=Z` utilizando a função `ST_DWithin` do PostGIS para retornar resultados ordenados por proximidade.       | 1d      | S4     | ⬜     |
| **T-17** | UI do Diretório (App): permissão de GPS no Flutter, listagem com filtros avançados (Dieta, Estilo de Cozinha, Aberto Agora) consumindo a nova rota `nearby`. Exibir badges e rating. | 1d      | S4     | ⬜     |

### US-08 — Experiência do Blog

| ID       | Tarefa Técnica                                                                                                                                                                   | Esforço | Sprint | Status |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-18** | Refatorar visualizador de Blog (`ViewPostPage` e `HomeBlogPage`): carregamento lazy via Riverpod `AsyncValue`, funcionalidade de marcar como Favorito e pesquisa via `debounce`. | 1d      | S4     | ⬜     |

---

## Tarefas Técnicas Transversais (QA & CI/CD)

> Infraestrutura e qualidade que viabiliza a manutenção a longo prazo do monorepo.

| ID       | Tarefa Técnica                                                                                                                                                                        | Esforço | Sprint | Status |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- | ------ | ------ |
| **T-19** | GitHub Actions (CI): pipeline rodando `melos run format`, `melos run analyze` e `melos run test` sempre que houver PR para a branch `main`.                                           | 0.5d    | S2     | ⬜     |
| **T-20** | Testes Unitários de Backend: escrever suíte de testes em Dart usando `mocktail` para mockar os repositórios do banco de dados e garantir 80% de cobertura nos endpoints do Dart Frog. | 1d      | S4     | ⬜     |

---

## Plano de Execução Recomendado (Ordem Lógica)

> A lista abaixo ordena a execução por **dependências arquiteturais** (Infraestrutura > Pacotes > Backend > App Admin > App Mobile).

### Sprint 1 (Infraestrutura & Domínio)

**Fase 1: Configuração do Chassi (Bloqueadores)**

1. `T-01` — Melos Workspace (Sem isso, o código não tem onde morar).
2. `T-02` — Docker (PostgreSQL + PostGIS).
3. `T-04` — Pacote Auth Client (Supabase base).

**Fase 2: Regras de Negócio** 4. `T-03` — Modelos Puros (`core_domain`) — Precisam existir antes de construir a API ou as interfaces.

### Sprint 2 (Backend & Serviços de Nuvem)

**Fase 1: Motor da API**

1. `T-05` — Setup Dart Frog e Repositórios SQL.
2. `T-06` — JWT Middleware no Dart Frog (Depende do `auth_client`).
3. `T-07` — Rotas CRUD de Blog e Business.

**Fase 2: Arquivos e Nuvem** 4. `T-08` — AWS S3 Pre-signed URL Endpoint. 5. `T-09` — Tabela de Imagens (Ajuste no schema DB). 6. `T-19` — Configurar CI (Garante código limpo daqui pra frente).

### Sprint 3 (Pacotes Compartilhados & Admin CMS)

**Fase 1: Camada de Componentes (Bloqueadores para UI)**

1. `T-10` — Pacote Design System (Todos os apps dependerão disso).
2. `T-11` — Pacote Rest Client (Dio configurado).

**Fase 2: Aplicação Web** 3. `T-12` — Estrutura e Auth no Admin Web. 4. `T-13` — CRUD de Estabelecimentos na Web (Consome o T-08 para S3). 5. `T-14` — Editor de Posts do Blog.

### Sprint 4 (App Mobile & Busca Avançada)

**Fase 1: Dados Complexos**

1. `T-16` — Backend: Query PostGIS `ST_DWithin` (Necessário para a home do app).

**Fase 2: App User-Facing** 2. `T-15` — Estrutura Base Mobile + Riverpod. 3. `T-17` — Mobile: Tela do Diretório + Filtros (Consome o T-16). 4. `T-18` — Mobile: Blog Viewer e Favoritos.

**Fase 3: Qualidade Final** 5. `T-20` — Testes Unitários de Backend.
