# Security Guidelines

## 1. Authentication & Authorization

- **Supabase Auth:** We do not roll our own crypto. User passwords and identity are managed entirely by Supabase.
- **Stateless API:** The Dart Frog backend is stateless. Every protected route requires a valid Bearer JWT.
- **Role-Based Access Control (RBAC):** The JWT custom claims or the database `users` table will define roles (`admin`, `user`, `business_owner`). Dart Frog middleware must verify these roles before allowing destructive actions (POST, PUT, DELETE).

## 2. Data Protection

- **Environment Variables:** Secrets (DB credentials, AWS Keys, Supabase Service Role Keys) must NEVER be committed. Use `.env` files locally and secure secret managers in CI/CD.
- **SQL Injection Prevention:** Never concatenate strings to build SQL queries. Always use parameterized queries provided by the ORM/SQL driver.

## 3. Asset Security

- **AWS S3:** S3 buckets must block public write access.
- **Upload Strategy:** Use pre-signed URLs with strict expiration times (e.g., 5 minutes) and strict file size/type constraints (e.g., `< 5MB`, `image/jpeg`, `image/png`).

## 4. Input Validation

- Never trust client data. All incoming payloads to the Dart Frog API must be validated against strict DTOs before processing.
