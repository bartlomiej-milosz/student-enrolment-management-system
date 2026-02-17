# Student Enrolment Management System

A robust and scalable Spring Boot application designed to manage students, books, and library rentals. This project demonstrates modern Java development practices, including domain-driven design, containerization with Docker, and comprehensive testing.

---

## Technology Stack

- **Core Backend**: Java 21, Spring Boot 3.4.1
- **Database**: PostgreSQL (Production), H2 (Testing)
- **Containerization**: Docker, Docker Compose
- **Object Mapping**: MapStruct 1.6.3
- **Utilities**: Lombok 1.18.40
- **Build Tool**: Maven

---

## Key Features

- **Student Management**: Full CRUD operations for student records.
- **Book Inventory**: Manage a catalogue of books.
- **Rental System**: Complete logic for renting and returning books, linking students to library resources.
- **RESTful API**: Clean and consistent API design following best practices.
- **Pagination**: Efficient data retrieval for large datasets.
- **Error Handling**: Global exception handling for consistent error responses.

---

## Getting Started

### Prerequisites

- **Java 21+** installed
- **Docker** & **Docker Compose** installed
- **Maven** installed

### Option 1: Run with Docker (Recommended)

The easiest way to run the application is using Docker Compose, which sets up both the application and the PostgreSQL database.

```bash
docker compose up --build
```

The application will start at `http://localhost:8080`.

### Option 2: Run Locally

1.  **Database Setup**: Ensure you have a PostgreSQL instance running on port `5432` with a database named `student-enrolment-management-system-db`, user `postgres`, and password `root` (or update `application.properties`).
2.  **Build the Project**:
    ```bash
    mvn clean install
    ```
3.  **Run the Application**:
    ```bash
    mvn spring-boot:run
    ```

---

## API Documentation

Base URI: `http://localhost:8080`

### Students (`/students`)

| Method | Endpoint         | Description                              |
| :----- | :--------------- | :--------------------------------------- |
| GET    | `/students`      | Retrieve a paginated list of students    |
| GET    | `/students/{id}` | Get details of a specific student        |
| POST   | `/students`      | Register a new student                   |
| PUT    | `/students/{id}` | Update an existing student's information |
| PATCH  | `/students/{id}` | Partially update a student's information |
| DELETE | `/students/{id}` | Remove a student from the system         |

### Books (`/books`)

| Method | Endpoint      | Description                           |
| :----- | :------------ | :------------------------------------ |
| GET    | `/books`      | Retrieve a paginated list of books    |
| GET    | `/books/{id}` | Get details of a specific book        |
| POST   | `/books`      | Add a new book to the catalogue       |
| PUT    | `/books/{id}` | Update an existing book's information |
| DELETE | `/books/{id}` | Remove a book from the catalogue      |

### Rentals (`/rentals`)

| Method | Endpoint        | Description              |
| :----- | :-------------- | :----------------------- |
| POST   | `/rentals`      | Rent a book to a student |
| PUT    | `/rentals/{id}` | Process a book return    |

### Example: Create a Student

**Request** `POST /students`
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@university.com",
  "age": 21
}
```

**Response** `201 Created`
```json
{
  "id": 1,
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@university.com",
  "age": 21,
  "studentIdCardResponse": null,
  "bookResponseList": []
}
```

---

## Architecture

The project follows a **Domain-Driven Design (DDD)** inspired, layered architecture:

- **Controller** layer exposes RESTful endpoints and handles HTTP request/response mapping
- **Service** layer contains business logic (e.g., rental stock management, student registration)
- **Repository** layer manages data persistence via Spring Data JPA
- **DTO pattern** with MapStruct separates API models from domain entities, keeping layers decoupled
- **Domain-scoped exception handling** — each domain (Book, Student, Rental) defines its own exceptions and `@ControllerAdvice` handlers, with a global fallback for common errors

---

## Testing

The project includes **68 tests** covering both unit and integration layers:

- **Unit tests** use Mockito to isolate service logic from database dependencies
- **Integration tests** use an embedded H2 database and Spring's `@SpringBootTest` to verify full request flows — from controller through service to repository
- Tests cover all three domains: Students, Books, and Rentals

```bash
mvn test
```

---

## Project Structure

```
src/main/java/io/bartmilo/student/enrolment/app/
├── domain/
│   ├── book/           # Controller, Service, Repository, Model, Mapper, Exception
│   ├── rental/         # Rental domain with book stock management logic
│   └── student/        # Student domain with ID card generation
└── handler/advice/     # Global exception handling
```

---

## Design Decisions

- **MapStruct over ModelMapper** — compile-time code generation means zero reflection overhead at runtime and type-safe mappings caught at build time
- **DDD-inspired package structure** — each domain is self-contained with its own controller, service, repository, models, and exception handlers, making it easy to navigate and extend
- **H2 for testing** — eliminates the need for Docker during CI/CD test runs while keeping the same JPA/Hibernate behavior as the PostgreSQL production database
- **Record-based DTOs** — Java records provide immutability and reduce boilerplate compared to traditional POJOs

---
