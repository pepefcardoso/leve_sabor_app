# Healthy Food App (Leve Sabor)

A Flutter-based mobile application for a healthy food platform featuring blog posts and business/restaurant directory with user authentication.

## Project Overview

**Leve Sabor** is a comprehensive Flutter application that provides users with:
- A blog platform for health-related content
- A directory of healthy food businesses and restaurants
- User authentication and profile management
- Favorites/bookmarks system for blog posts
- Advanced search and filtering capabilities

## Tech Stack

- **Framework**: Flutter 3.16.0+
- **State Management**: BLoC (Business Logic Component)
- **HTTP Client**: Dio
- **Dependency Injection**: Kiwi
- **Routing**: GoRouter
- **Local Storage**: SharedPreferences
- **Validation**: Email Validator, Brasil Fields
- **UI/UX**: Material Design

## Project Structure

```
lib/
├── app_initialization.dart          # App initialization and dependency setup
├── main.dart                        # Application entry point
├── bloc/                            # BLoC state management
│   ├── business_index/              # Business listing
│   ├── favorite_post_button/        # Blog post favorite toggle
│   ├── favorite_posts_index_page/   # Favorites listing
│   ├── home/                        # Home page state
│   ├── home_blog/                   # Blog home page
│   ├── login/                       # Authentication
│   ├── posts_filters/               # Blog post filters
│   ├── search_posts_page/           # Blog search
│   ├── signup/                      # User registration
│   └── view_blog_post/              # Single blog post view
├── components/                      # Reusable UI components
│   ├── blog_posts/                  # Blog-specific components
│   ├── custom_*.dart                # Custom widgets
│   ├── login_store.dart             # Auth token management
│   └── standard_app_bar.dart        # App header
├── enum/                            # Enumerations
│   ├── blog_post_status_enum.dart
│   └── default_bloc_status_enum.dart
├── errors_&_exceptions/
│   └── http_exception.dart          # HTTP error handling
├── models/                          # Data models
│   ├── blog_post.dart
│   ├── business.dart
│   ├── user.dart
│   └── ...other models
├── screens/                         # Full-page screens
│   ├── blog/
│   │   ├── home_blog_page.dart
│   │   ├── search_posts_page.dart
│   │   ├── favorites_index_page.dart
│   │   └── view_post_page.dart
│   ├── business/
│   │   ├── businesses_index.dart
│   │   └── visualizar_estabelecimento.dart
│   ├── home_page.dart
│   ├── login_page.dart
│   └── signup_page.dart
├── services/                        # API services
│   ├── blog_posts_service.dart
│   ├── blog_post_category_service.dart
│   ├── business_service.dart
│   ├── login_service.dart
│   └── user_service.dart
└── utils/                           # Utilities
    ├── api_config.dart              # API configuration
    ├── custom_colors.dart           # Color palette
    ├── http.dart                    # HTTP client wrapper
    ├── routes.dart                  # Route definitions
    └── tipografia.dart              # Typography definitions
```

## Key Features

### 1. Authentication System
- User login and registration
- JWT token-based authentication
- Persistent login using SharedPreferences
- Automatic token refresh on app startup

### 2. Blog Management
- View all published blog posts
- Search blog posts by title
- Filter posts by categories
- View detailed blog post with author info
- Favorite/bookmark posts
- View favorite posts collection
- Categories include: Technology, Health, Education, Finance, Sports, Entertainment

### 3. Business Directory
- Browse healthy food businesses/restaurants
- Search and filter businesses
- View detailed business information including:
  - Opening hours
  - Diets offered
  - Cooking styles
  - Contact information
  - Customer ratings and reviews
  - Location/address

### 4. User Profile
- User registration with email validation
- Profile with avatar/image
- User information management
- Login persistence

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_bloc | ^8.1.3 | State management |
| bloc | ^8.1.2 | Business Logic Component |
| dio | ^5.4.0 | HTTP client |
| go_router | ^11.1.4 | Navigation/routing |
| kiwi | ^5.0.0 | Service locator/DI |
| shared_preferences | ^2.2.2 | Local storage |
| email_validator | ^2.1.17 | Email validation |
| brasil_fields | ^1.14.2 | Brazilian field formatting |
| intl | ^0.19.0 | Internationalization |
| flutter_svg | ^2.0.7 | SVG support |
| provider | ^6.1.1 | State management |

## API Configuration

The app connects to a backend API. Configure the API host in `lib/utils/api_config.dart`:

```dart
class ApiConfig {
  static const String host = 'http://10.0.2.2:8000'; // Android Emulator
  // static const String host = 'http://192.168.0.1:8000'; // Linux
  // static const String host = 'http://192.168.200.201:8080'; // External Device
}
```

### Main API Endpoints

- `POST /api/login` - User authentication
- `POST /api/register` - User registration
- `GET /api/users/me` - Get current user
- `POST /api/users/logout` - Logout
- `GET /api/blog-posts` - List all blog posts
- `GET /api/blog-posts/{id}` - Get single blog post
- `POST /api/blog-posts/favorites/{id}` - Favorite a post
- `DELETE /api/blog-posts/favorites/{id}` - Unfavorite a post
- `GET /api/blog-posts/favorites` - Get user's favorites
- `GET /api/blog-post-category` - Get post categories
- `GET /api/businesses` - List businesses
- `GET /api/businesses/{id}` - Get business details

## State Management (BLoC)

The app uses BLoC pattern for state management:

- **LoginBloc**: Handles authentication flows
- **HomeBlogPageBloc**: Manages blog posts listing
- **SearchPostsPageBloc**: Handles post search
- **FavoritePostsIndexPageBloc**: Manages favorites listing
- **FavoritePostButtonBloc**: Handles favorite toggle
- **ViewBlogPostBloc**: Manages single post view
- **BusinessIndexBloc**: Manages business listings
- **PostsFiltersBloc**: Manages category filters

## Routing

Navigation is handled by GoRouter with nested routes:

```
/ (Home)
├── /login
├── /signup
├── /blog-posts (Blog Home)
│   ├── /:index (View Post)
│   ├── /search (Search Posts)
│   │   └── /:index (View Post from Search)
│   └── /favorites (Favorite Posts)
│       └── /:index (View Post from Favorites)
└── /businesses (Businesses)
    └── /:index (View Business)
```

## Design System

### Colors
- **Primary**: `#1B4506` (Verde 1 - Dark Green)
- **Secondary**: `#E8EDED` (Verde 2 - Light Green)
- **Accent**: `#226103` (Verde 3 - Medium Green)
- **Light**: `#ECE8EF`
- **Dark**: `#252D1C`

### Typography
- **Titulo 1**: 40sp, Ultra Bold (FontWeight.w800)
- **Titulo 2**: 18sp, Bold (FontWeight.w600)
- **Titulo 3**: 24sp, Bold
- **Titulo 4**: 24sp, Ultra Bold
- **Corpo 1**: 18sp, Medium (FontWeight.w400)
- **Corpo 2**: 16sp, Regular (FontWeight.w200)
- **Corpo 2 Bold**: 16sp, Bold

Font: TripSans (custom font family)

## Getting Started

### Prerequisites
- Flutter 3.16.0 or higher
- Dart 3.1.0 or higher
- A running backend API server

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd my_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API endpoint**
   Update `lib/utils/api_config.dart` with your backend API URL

4. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

```bash
# Get dependencies
flutter pub get

# Run code generation (if needed)
flutter pub run build_runner build

# Run the app in debug mode
flutter run -v

# Run tests
flutter test

# Build APK
flutter build apk --release

# Build for iOS
flutter build ios --release
```

## Features Breakdown

### Authentication Flow
1. User registers with email, phone, and password
2. Login with email and password
3. Token is stored locally in SharedPreferences
4. On app startup, stored token is validated
5. User is logged in if token is still valid
6. Logout clears token and returns to login screen

### Blog Post Features
- List all published posts with pagination
- Search by title in real-time
- Filter by multiple categories
- View post with full content, author info, and creation date
- Like/favorite posts with visual feedback
- View dedicated favorites collection

### Business Features
- Browse businesses with images and ratings
- View business status (Open/Closed)
- Check opening hours
- See available diets and cooking styles
- View customer ratings and review count
- Access contact information

## Code Quality

- Clean Architecture principles
- BLoC pattern for state management
- Service layer for API communication
- Reusable component library
- Error handling with custom exceptions
- Type-safe navigation with GoRouter
- Dependency injection with Kiwi

## Error Handling

The app implements comprehensive error handling:
- HTTP exceptions with specific status codes (400, 401, 403, 404, 422)
- User-friendly error messages in Portuguese
- Validation error collection for forms
- Loading and error states in UI

## Localization

The app is built with Portuguese language support for:
- UI text and labels
- Form validation messages
- Error messages
- Navigation labels
