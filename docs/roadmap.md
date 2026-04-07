# Project Roadmap: Leve Sabor V2

## Phase 1: Infrastructure & Foundation

- [ ] Initialize Git repository and Melos workspace.
- [ ] Setup `docker-compose.yml` for PostgreSQL.
- [ ] Setup Supabase Project (Auth).
- [ ] Create `core_domain` package and port legacy models (Business, BlogPost, User).

## Phase 2: Backend API (Dart Frog)

- [ ] Initialize `apps/backend_api`.
- [ ] Setup Database connection & Repository layer.
- [ ] Implement JWT Validation Middleware.
- [ ] Create core CRUD endpoints (`/businesses`, `/blog-posts`).
- [ ] Implement AWS S3 pre-signed URL generation endpoint.
- [ ] Write unit tests for API routes.

## Phase 3: Shared Packages

- [ ] Create `packages/design_system` (Port colors, typography, and widgets).
- [ ] Create `packages/rest_client` (Dio setup, interceptors).
- [ ] Create `packages/auth_client` (Supabase SDK integration).

## Phase 4: Admin Panel (Flutter Web)

- [ ] Initialize `apps/app_admin`.
- [ ] Setup Riverpod and routing (GoRouter).
- [ ] Build Login screen (Admin only).
- [ ] Build Data Management grids (CRUD for Blogs and Businesses).
- [ ] Implement direct-to-S3 image uploads.

## Phase 5: Mobile App (Flutter Mobile)

- [ ] Initialize `apps/app_mobile`.
- [ ] Rebuild Home and Authentication flow.
- [ ] Implement Business Directory and filtering.
- [ ] Implement Blog viewer and favorites functionality.

## Phase 6: Polish & Advanced Features (V2 Exclusives)

- [ ] Implement PostGIS for location-based business search.
- [ ] Add caching mechanisms.
- [ ] Setup CI/CD pipelines (GitHub Actions).
