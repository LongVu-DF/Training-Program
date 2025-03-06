# Clean Architecture Principles

Before diving into the implementation, let’s understand why clean architecture is beneficial:

- **Separation of Concerns:** Clean architecture divides the codebase into distinct layers, each with a specific responsibility. This separation makes it easier to manage and reason about the code.
- **Testability:** Since each layer is independent, it’s easier to write unit tests for each component, making the codebase more robust and less prone to bugs.
- **Scalability:** Clean architecture allows developers to scale the application by adding new features or modifying existing ones without impacting unrelated parts of the codebase.
- **Maintainability:** With a clear structure, maintaining and updating the codebase becomes simpler, especially in large teams or long-term projects.

###  Clean Architecture Layers
The clean architecture pattern typically consists of the following layers:

- **Presentation Layer**
- **Domain Layer**
- **Data Layer**

Each layer has its own role and communicates with adjacent layers through interfaces or data transfer objects (DTOs). Let’s break down each layer in detail.

**1. Presentation Layer**
The presentation layer is responsible for the user interface (UI) and handling user interactions. In Flutter, this layer consists of widgets, state management, and controllers.

- **Widgets:** Represent the UI components.
- **State Management:** Manages the state of the application. You can use state management solutions like `provider`, `bloc`, or `riverpod` depending on the complexity of the project.
- **Controllers/ViewModels:** Acts as a bridge between the UI and the domain layer, handling input validation and calling use cases from the domain layer.

Example Structure:
```
lib/
├── presentation/
│   ├── pages/
│   ├── widgets/
│   ├── controllers/
│   └── state/
```

**2. Domain Layer**
The domain layer is the core of the application and contains the business logic. It’s independent of any external libraries or frameworks, making it reusable and testable.

- **Entities:** Represent core business models, containing properties and basic validations.
- **Use Cases (Interactors):** Contain the business rules and application-specific logic. Each use case is a single unit of functionality, such as fetching data or validating a form.
- **Repositories (Interfaces):** Define the contract for data retrieval and storage. These interfaces are implemented in the data layer.

Example Structure:
```
lib/
├── domain/
│   ├── entities/
│   ├── usecases/
│   └── repositories/
```
**3. Data Layer**
The data layer handles data retrieval, storage, and network communication. It contains the implementation of repositories, data sources, and data transfer objects (DTOs).

- **Data Sources:** Manage data from different sources such as APIs, local databases, or third-party services. The data source is divided into remote and local data sources.
- **Repository Implementations:** Implement the repository interfaces defined in the domain layer.
- **Models/DTOs:** Represent the structure of the data being transferred between layers. They typically include conversion methods (e.g., `toEntity`, `fromEntity`) to map between the data and domain layers.

Example Structure:
```
lib/
├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   └── local/
│   ├── models/
│   └── repositories/
```

### Structure for project
```
lib/
├── core/                 
│   ├── utils/
│   ├── network/
│   ├── theme/
│   ├── widgets/
│   ├── error/
└── features/
    ├── authentication/   # folder for (login, logout, register)
    │   ├── data/
    │   ├── domain/
    │   ├── presentation/
    │   ├── authentication.dart # this call entry point
    ├── users/            # combine CRUD into users
    │   ├── data/
    │   ├── domain/
    │   │   ├── usecases/
    │   │   │   ├── get_users.dart
    │   │   │   ├── add_user.dart
    │   │   │   ├── update_user.dart
    │   │   │   ├── delete_user.dart
    │   ├── presentation/
    │   ├── users.dart # this call entry point
```

Entry Point example:
```
library authentication;

// Export domain layer
export 'domain/entities/user.dart';
export 'domain/repositories/auth_repository.dart';
export 'domain/usecases/login.dart';
export 'domain/usecases/logout.dart';
export 'domain/usecases/register.dart';

// Export data layer
export 'data/models/user_model.dart';
export 'data/repositories/auth_repository_impl.dart';
export 'data/data_sources/auth_remote_data_source.dart';

// Export presentation layer
export 'presentation/pages/login_page.dart';
export 'presentation/pages/register_page.dart';
export 'presentation/bloc/auth_bloc.dart';

```
Import Entry Point example:
```
// dont have entry point
import 'package:your_app/features/authentication/domain/usecases/login.dart';
import 'package:your_app/features/authentication/domain/entities/user.dart';
import 'package:your_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:your_app/features/authentication/presentation/pages/login_page.dart';

// have entry point
import 'package:your_app/features/authentication/authentication.dart';
```
