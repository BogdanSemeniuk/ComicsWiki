# ComicsWiki

An iOS application demonstrating advanced **SwiftUI** patterns and **The Composable Architecture (TCA)**.

## 🚀 Overview
ComicsWiki is a portfolio project that showcases a complex multi-step authentication flow. It serves as a blueprint for building scalable, testable, and maintainable iOS applications using modern industry standards.

## 🏗 Architecture & Engineering Decisions

### **The Composable Architecture (TCA)**
The app is built on TCA to ensure a **unidirectional data flow** and a "single source of truth." This choice was driven by the need for:
*   **Tree-Based Navigation**: Leveraging `@Presents` and `ifLet` to manage navigation state. This ensures that the app's routing is strictly tied to its state, making deep-linking and state restoration trivial.
*   **Exhaustive Testing**: By isolating side effects in `Dependencies`, the business logic remains pure and easy to verify via `TestStore`.
*   **State Observation**: Utilizing the latest `@ObservableState` (Swift 5.9+) to minimize view invalidations and optimize rendering performance.

### **Technical Highlights**
*   **Modular Networking Layer**: Implemented a custom `HTTPClient` with a robust mocking system using `MockURLProtocol`. This enables **Mock-First Development**, allowing the entire UI and logic to be built and tested independently of a live backend.
*   **Decoupled Dependency Injection**: Services like `AuthManager` and `InputValidator` are injected via TCA's `@Dependency` system, facilitating clean separation of concerns and easy mocking for unit tests.
*   **Advanced Form Validation**: A centralized validation engine manages complex rules (regex-based email validation, password strength, and matching) with real-time feedback and type-safe error handling.
*   **Atomic UI Components**: A custom design system was established in the `Subviews` directory, promoting code reuse and visual consistency across the application.

## 🛠 Tech Stack
*   **Language**: Swift 6.0 (Concurrency-safe)
*   **Framework**: SwiftUI
*   **State Management**: The Composable Architecture (TCA)
*   **Persistence**: Secure token storage via `UserDefaults` with TCA integration.
*   **Networking**: `URLSession` with custom middleware for mocking and decoding.
*   **Localization**: Modern `.xcstrings` for dynamic internationalization.

## 📂 Project Structure
```text
ComicsWiki/
├── Core/               # Infrastructure & Cross-cutting concerns
│   ├── Auth/           # Token lifecycle & Session management
│   ├── Networking/     # Protocol-based API client & Mocking engine
│   └── Validation/     # Business rules for data integrity
├── Modules/            # Feature-driven architecture
│   ├── App/            # Root Coordinator & App-level State
│   ├── Auth/           # Composition of SignIn, Registration, & Account logic
│   └── Home/           # Post-auth dashboard features
├── Subviews/           # Atomic Design System components
└── Resources/          # Design tokens (Colors, Assets) & Localization
```

## 👨‍💻 Author
**Богдан Семенюк**
*iOS Engineer*

