# Architecture Guidelines

## 1. Core Philosophy

Leve Sabor V2 follows a strict **Clean Architecture** and **Domain-Driven Design (DDD)** approach within a Dart Monorepo. The primary goal is to decouple the business rules (Domain) from the frameworks (Flutter, Dart Frog) and external agents (Supabase, PostgreSQL).

## 2. Monorepo Structure (Melos)

We utilize `melos` to manage our workspace, strictly separating applications from shared packages to enforce dependency rules:

- **`apps/`**: Contains deployable targets (`backend_api`, `app_mobile`, `app_admin`). Apps can depend on packages, but NEVER on other apps.
- **`packages/`**: Contains isolated feature or utility modules.
  - `core_domain`: The absolute center. Contains pure Dart Models, Entities, and Interfaces. **Cannot depend on Flutter or Dart Frog.**
  - `rest_client`: Dio wrappers and DTOs.
  - `auth_client`: Supabase wrappers.

## 3. Frontend Architecture (Flutter)

We utilize a feature-first folder structure combined with layered architecture:

- **Presentation Layer:** Managed by **Riverpod** (`riverpod_generator`). UI components only consume `Providers` and dispatch actions. No business logic in widgets.
- **Domain Layer:** Use Cases and abstract Repository interfaces.
- **Data Layer:** Concrete Repository implementations calling the `rest_client`.

## 4. Backend Architecture (Dart Frog)

- **Routing:** Keep routes thin. A route should only parse the request, pass it to a controller/service, and format the response.
- **Database Access:** Use the Repository pattern to wrap the ORM/SQL driver. This allows us to mock the database in unit tests.
- **Shared Context:** Use Dart Frog's dependency injection (`request.context`) to pass Repositories and Supabase clients down to the routes.
