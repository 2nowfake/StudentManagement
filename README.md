# Student Management - Database Migration Approaches Assignment

This assignment outlines the implementation of database schema changes for the Student Management System using both Change-Based (EF Code-First) and State-Based migration approaches. 

Change-Based is focuses on incremental changes to the database schema. State-Based is focuses on the complete desired state of the database at each version. Both approaches were implemented for each schema change to demonstrate their differences, benefits, and challenges.

# Schema changes - WIP

## 1. Initial schema - Martin

### Models:
- Student (Id, FirstName, LastName, Email, EnrollmentDate)
- Course (Id, Title, Credits)
- Enrollment (Id, StudentId, CourseId, Grade)

### Implementation:
EF Code-First: Created model classes and SchoolContext, generated initial migration.
```
dotnet ef migrations add InitialCreate
dotnet ef migrations script 0 InitialCreate -o Migrations/SQL/V1__InitialCreate.sql
```
State-Based: Created SQL script defining all tables with primary and foreign keys. The initial schema establishes core entities with appropriate relationships. Auto-incrementing primary keys and foreign key constraints ensure data integrity.


## 2. Add MiddleName to Student - Daniela

## 3. Add DateOfBirth to Student - Martin

## 4. Add Instructor relation - Daniela

## 5. Rename Grade attribute to FinalGrade in Enrollment - Martin

## 6. Add Department relation - Daniela

## 7. Modify the Course Credits relation - Martin


