# Leve Sabor V2 — Healthy Food Platform

Uma plataforma completa para alimentação saudável, composta por um diretório de estabelecimentos e um blog de conteúdo especializado. O projeto utiliza uma arquitetura de **Monorepo** 100% Dart, compartilhando lógica de domínio entre frontend e backend.

## 📌 Visão Geral

O **Leve Sabor V2** moderniza a aplicação legada, migrando de uma estrutura desacoplada para um ecossistema unificado.

- **App Mobile:** Guia de restaurantes e busca geoespacial para usuários.
- **Admin Web (CMS):** Painel de gestão para moderação de conteúdo e estabelecimentos.
- **Backend API:** API de alta performance que centraliza as regras de negócio.

## 🛠 Tech Stack (V2.0)

- **Linguagem:** Dart (Full-stack)
- **Gerenciamento de Monorepo:** [Melos](https://melos.invertase.dev/)
- **Frontend (Mobile & Web):** Flutter 3.16.0+
- **Backend:** [Dart Frog](https://dartfrog.vgv.dev/)
- **Estado:** Riverpod (`riverpod_generator`)
- **Banco de Dados:** PostgreSQL + PostGIS
- **Auth & Identity:** Supabase Auth
- **Storage:** AWS S3 (via Pre-signed URLs)

## 📂 Estrutura do Projeto

O workspace é dividido entre aplicações (`apps/`) e módulos reutilizáveis (`packages/`):

```text
.
├── apps/
│   ├── app_mobile/          # App Flutter (Usuário final) com Clean Arch
│   ├── app_admin/           # Painel Web (CMS) em Flutter
│   └── backend_api/         # API REST em Dart Frog
│
├── packages/
│   ├── core_domain/         # Entidades puras e modelos (Freezed) - Sem dependência de Flutter
│   ├── design_system/       # UI Kit, cores, tipografia e componentes base
│   ├── auth_client/         # Wrapper do Supabase e providers de sessão
│   └── rest_client/         # Cliente Dio configurado com interceptors JWT
│
└── docs/                    # Documentação técnica e arquitetural
```

## 🏗 Arquitetura e Fluxo de Dados

O projeto segue os princípios de **Clean Architecture** e **Domain-Driven Design (DDD)**.

1.  **Compartilhamento de Código:** O pacote `core_domain` contém a "fonte da verdade" para modelos de dados, garantindo que o Backend e o Frontend usem as mesmas classes e validações.
2.  **Autenticação:** O cliente autentica-se via Supabase, recebe um JWT e o envia no header `Authorization`. O Backend (Dart Frog) valida este token via middleware.
3.  **Upload de Arquivos:** Para eficiência, o backend gera uma **URL pré-assinada (S3)**. O cliente faz o upload do binário diretamente para a AWS, reduzindo a carga no servidor.

## 🚀 Roadmap de Desenvolvimento

O projeto está organizado em 4 Sprints principais:

- **Sprint 1:** Estruturação do Monorepo, Setup Docker (Postgres/PostGIS) e Core Domain.
- **Sprint 2:** Backend API Core, Middleware JWT e integração com AWS S3.
- **Sprint 3:** Design System, Rest Client e lançamento do Admin Web.
- **Sprint 4:** Refatoração do App Mobile (migração de BLoC para Riverpod) e Busca Geoespacial.

## 🎨 Identidade Visual (Design System)

As diretrizes visuais estão centralizadas no pacote `design_system`:

- **Cores:** Dark Green (`#1B4506`), Light Green (`#E8EDED`), Accent (`#226103`).
- **Tipografia:** Fonte `TripSans`.
- **UX:** Tratamento obrigatório de estados via `AsyncValue` (Loading, Error, Data).

## 🔧 Como Iniciar

### Pré-requisitos

- Flutter SDK & Dart SDK
- Melos (`dart pub global activate melos`)
- Docker & Docker Compose

### Instalação

1.  **Bootstrap do Workspace:**
    ```bash
    melos bootstrap
    ```
2.  **Subir Infraestrutura Local:**
    ```bash
    docker-compose up -d
    ```
3.  **Gerar código (Freezed/Riverpod):**
    ```bash
    melos run build_runner
    ```

## 🔐 Segurança

- **Zero Trust:** O backend é stateless; toda rota protegida exige validação de JWT.
- **RBAC:** Controle de acesso baseado em roles (`admin`, `user`, `business_owner`) gerenciado via banco e claims.
- **Proteção de Dados:** Uso obrigatório de queries parametrizadas para evitar SQL Injection.

---

_Para detalhes específicos, consulte os arquivos em `/docs`._
