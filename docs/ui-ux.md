# UI/UX & Design System Guidelines

## 1. The Design System Package

All reusable visual components live in the `packages/design_system` module. This ensures 100% visual consistency between the Mobile App and the Web Admin panel.

## 2. Core Identity

- **Typography:** `TripSans` is the primary font.
- **Color Palette:** \* Primary: Dark Green (`#1B4506`)
  - Secondary: Light Green (`#E8EDED`)
  - Accent: Medium Green (`#226103`)

## 3. State Handling (The Riverpod Way)

Every asynchronous UI element must gracefully handle the three states of data fetching using Riverpod's `AsyncValue`:

1. **Loading:** Show a skeleton loader or `CircularProgressIndicator` themed with `CustomColors.verde3`.
2. **Error:** Provide clear, localized error messages with a "Retry" button. Never show raw exception strings to the user.
3. **Data:** Render the component.

## 4. Responsive Design

- **Mobile (User App):** Bottom Navigation, swipe gestures, stacked cards.
- **Web (Admin CMS):** Sidebar navigation, wide data tables, modal dialogs for forms. Use `LayoutBuilder` to handle breakpoints if the Admin panel is opened on a tablet.

## 5. Accessibility (a11y)

- Ensure high contrast ratios between text and background (e.g., White text on Primary Green).
- Provide `Semantics` labels for icon-only buttons (e.g., Favorite, Share).
