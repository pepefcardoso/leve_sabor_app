# Project Roadmap: Leve Sabor V2

## Phase 1: Infrastructure, Restructuring & Foundation

- [ ] Restructure existing repository: move legacy Flutter code to `apps/app_mobile_legacy`.
- [ ] Initialize Melos workspace (`melos.yaml`) at the repository root.
- [ ] Setup `docker-compose.yml` for PostgreSQL (with PostGIS).
- [ ] Setup Supabase Project (Auth).
- [ ] Create `core_domain` package and port legacy models (Business, BlogPost, User) into pure Dart entities.

## Phase 2: Backend API (Dart Frog)

- [ ] Initialize `apps/backend_api`.
- [ ] Setup Database connection & Repository layer.
- [ ] Implement JWT Validation Middleware (Supabase).
- [ ] Create core CRUD endpoints (`/businesses`, `/blog-posts`).
- [ ] Implement AWS S3 pre-signed URL generation endpoint.
- [ ] Write unit tests for API routes.

## Phase 3: Shared Packages

- [ ] Create `packages/design_system` (Extract colors, typography, and widgets from the legacy code).
- [ ] Create `packages/rest_client` (Dio setup, interceptors for JWT injection).
- [ ] Create `packages/auth_client` (Supabase SDK integration & Session Providers).

## Phase 4: Admin Panel (Flutter Web)

- [ ] Initialize `apps/app_admin`.
- [ ] Setup Riverpod and routing (GoRouter).
- [ ] Build Login screen (Admin only).
- [ ] Build Data Management grids (CRUD for Users, Blogs, and Businesses).
- [ ] Implement direct-to-S3 image uploads from the browser.

## Phase 5: Mobile App Refactoring (Flutter Mobile)

- [ ] Initialize `apps/app_mobile` applying Clean Architecture.
- [ ] Port and refactor legacy Authentication (Login/Signup) adopting Riverpod and `auth_client`.
- [ ] Implement User Profile screen (update data, manage account).
- [ ] Refactor Business Directory UI (List, Map View, Search/Filters, and Business Details screen).
- [ ] Refactor Blog functionality (List with search/filters, Post Details viewer, and favorites).
- [ ] Deprecate and remove `apps/app_mobile_legacy` once feature parity is reached.

## Phase 6: Polish & Advanced Features (V2 Exclusives)

- [ ] Implement PostGIS for location-based business search (Nearby query).
- [ ] Add caching mechanisms for offline-like resilience.
- [ ] Setup CI/CD pipelines (GitHub Actions: Melos format, analyze, and test).
