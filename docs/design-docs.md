# System Design Document: Leve Sabor V2

## 1. Overview

Leve Sabor V2 is a modernization of the legacy monolithic application. It transitions from a decoupled Laravel/Flutter stack to a unified, 100% Dart Monorepo. The platform serves as a directory for healthy food businesses and a blog for health-related content.

## 2. Goals

- **Single Language Ecosystem:** Share DTOs, models, and validation logic between the backend and frontend.
- **Maintainability:** Implement Clean Architecture to ensure the codebase remains scalable and testable.
- **Modern Auth:** Offload identity management to Supabase.

## 3. System Architecture

- **Frontend:** Flutter (Mobile for users, Web for Admin CMS).
- **Backend:** Dart Frog REST API.
- **Database:** PostgreSQL (Containerized via Docker).
- **Identity Provider:** Supabase Auth.
- **Blob Storage:** AWS S3 (Images, Logos, Thumbnails).

## 4. Data Flow & Communication

- **Client to Server:** REST over HTTPS. Mobile/Web clients authenticate with Supabase, receive a JWT, and pass this JWT in the `Authorization` header to the Dart Frog API.
- **Server to DB:** Dart Frog validates the JWT. If valid, it executes queries against the PostgreSQL database.
- **File Uploads:** The client requests a pre-signed S3 URL from Dart Frog, then uploads the binary directly to S3, bypassing the backend to save bandwidth.
