# Student Management

This assignment outlines the implementation of database schema changes for the Student Management System using both Change-Based (EF Code-First) and State-Based migration approaches. 

Change-Based is focuses on incremental changes to the database schema. State-Based is focuses on the complete desired state of the database at each version. Both approaches were implemented for each schema change to demonstrate their differences, benefits, and challenges.

# Schema changes

### 1. Initial Schema - Martin

**Models**:
- `Student.cs` (`Id`, `FirstName`, `LastName`, `Email`, `EnrollmentDate`)
- `Course.cs` (`Id`, `Title`, `Credits`)
- `Enrollment.cs` (`Id`, `StudentId`, `CourseId`, `Grade`)

**Implementation**:
- **EF Code-First**: Created model classes and `SchoolContext.cs`, generated initial migration

  ```bash
  dotnet ef migrations add InitialCreate
  dotnet ef migrations script 0 InitialCreate -o Migrations/SQL/V1__InitialCreate.sql
  ```

  *Note: Every migration is applied like this although won't be mentioned in the following steps:*

  ```bash
  dotnet ef database update
  ```

- **State-Based**: Created SQL script defining all tables with primary and foreign keys

The initial schema establishes core entities with appropriate relationships. Auto-incrementing primary keys and foreign key constraints ensure data integrity. This was the initial commit of the github repository.

### 2. Add MiddleName to Student - Daniela

**Implementation**:
- **EF Code-First**: Added the new database entry to `Sctudent.cs`, then generated the new migration from the InitialCreate.

  ```csharp
  // Added to Student model
  public string? MiddleName { get; set; }
  ```
  ```bash
  dotnet ef migrations add AddMiddleNameToStudent
  dotnet ef migrations script InitialCreate AddMiddleNameToStudent -o Migrations/SQL/V2__AddMiddleNameToStudent.sql
  ```
- **State-Based**: Created new SQL script with complete schema including the MiddleName column

Made `MiddleName` nullable to accommodate students without middle names. EF generated a non-destructive ALTER TABLE statement, while the state-based approach recreated the table with the new column. These changes were merged in pull requests #1 and #2.

### 3. Add DateOfBirth to Student - Martin

**Implementation**:
- **EF Code-First**: Added the new database entry to `Sctudent.cs`, then generated the new migration from the previous AddMiddleNameToStudent migration.

  ```csharp
  // Added to Student model
  public DateTime? DateOfBirth { get; set; }
  ```
  ```bash
  dotnet ef migrations add AddDateOfBirthToStudent
  dotnet ef migrations script AddMiddleNameToStudent AddDateOfBirthToStudent -o Migrations/SQL/V3__AddDateOfBirthToStudent.sql
  ```
- **State-Based**: Created new SQL script with complete schema including both MiddleName and DateOfBirth

Similar to the previous step, we made `DateOfBirth` nullable to allow for cases where birth date is unknown. Another non-destructive change that preserves existing data. These changes were merged in pull requests #3 and #5.

*Note: Pull request #4 included the previous migrations that weren't pushed and merged in the earlier pull requests.*

### 4. Add Instructor Relation - Daniela

**Implementation**:
- **EF Code-First**: Added the following changes to entries before creating the migrations.
  - Created new `Instructor.cs` model with `Id`, `FirstName`, `LastName`, `Email`, `HireDate`
  - Added `InstructorId` foreign key to `Course.cs` model
  - Updated `SchoolContext.cs` to configure the relationship
    
  ```bash
  dotnet ef migrations add AddInstructorRelation
  dotnet ef migrations script AddDateOfBirthToStudent AddInstructorRelation -o Migrations/SQL/V4__AddInstructorRelation.sql
  ```
- **State-Based**: Created new SQL script with complete schema including the new Instructors table and relationship

Made `InstructorId` nullable in the `Course` model to allow for courses without assigned instructors. This adds flexibility during data entry and organizational transitions. These changes were merged in pull requests #6 and #7.

### 5. Rename Grade to FinalGrade in Enrollment - Martin

**Implementation**:
- **EF Code-First**: Altered the Grade entry in the `Enrollment.cs` initial model, then generated the new migrations accordingly.

  ```csharp
  // Changed in Enrollment model
  public string FinalGrade { get; set; } // Renamed from Grade
  ```
  ```bash
  dotnet ef migrations add RenameGradeToFinalGrade
  dotnet ef migrations script AddInstructorRelation RenameGradeToFinalGrade -o Migrations/SQL/V5__RenameGradeToFinalGrade.sql
  ```
- **State-Based**: Used a non-destructive method by utilizing `sp_rename` to rename the column and perserve any existing data instead of recreating the entire schema.

We prioritized the non-destructive option for this specific change, since grade data is critical and should not be lost. The changes in this step were merged in pull requests #8 and #9.

### 6. Add Department Relation - Daniela

**Implementation**: 
- **EF Code-First**: Added the following changes to entries before creating the migrations.
  - Created new `Department.cs` model with `Id`, `Name`, `Budget`, `StartDate`, `DepartmentHeadId`
  - Added `DepartmentId` to the `Course.cs` model
  - Updated navigation properties and configured relationships

  ```bash
  dotnet ef migrations add AddDepartmentRelation
  dotnet ef migrations script RenameGradeToFinalGrade AddDepartmentRelation -o Migrations/SQL/V6__AddDepartmentRelation.sql
  ```
- **State-Based**: Created SQL script with complete schema including the new Department table and relationships

This introduced a complex relationship where departments have department heads (instructors) and courses belong to departments. We made the relevant foreign keys nullable to allow for flexible data entry. These implementations were merged in pull requests #11 and #12.

*Note: Pull request #10 was a fix of files that were reverted accidentally between pull requests.*

### 7. Modify Course Credits Type - Martin

**Implementation**:
- **EF Code-First**: Modified the Credits entry in the `Course.cs` initial model and configured the decimal precision, then generated the new migrations accordingly.
  ```csharp
  // Changed in Course model
  public decimal Credits { get; set; } // Changed from int
  
  // In OnModelCreating
  modelBuilder.Entity<Course>()
      .Property(c => c.Credits)
      .HasColumnType("decimal(5,2)");
  ```
  ```bash
  dotnet ef migrations add ChangeCreditsTypeToDecimal
  dotnet ef migrations script AddDepartmentRelation ChangeCreditsTypeToDecimal -o Migrations/SQL/V7__ChangeCreditsTypeToDecimal.sql
  ```
- **State-Based**: Used a non-destructive approach once again as we created temporary column, copied data, dropped the old column and renamed the new column.

The non-destructive approach preserves all data and is safer in real case scenario production environments. The alternative destructive approach would involve recreating the entire schema, which in turn risks data loss. These changes were merged in pull request #13 and #14.

## Version Control Strategy

Each schema change was implemented on separate feature branches and merged through pull requests that were noted under each step for easier tracking in our git commit history:

1. **EF Code-First branches**:
   - `feat/initial-schema-ef`
   - `feat/add-middle-name-ef`
   - `feat/add-date-of-birth-ef`
   - etc.

2. **State-Based branches**:
   - `feat/initial-schema-state`
   - `feat/add-middle-name-state`
   - `feat/add-date-of-birth-state`
   - etc.

This approach allows us for isolated development of each schema change and provides a clear history of changes in the repository. 

*Note: We did run into some issues due to using different IDEs, as well as mirgation errors.*
