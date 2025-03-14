﻿namespace StudentManagement.Models
{
    public class Instructor
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public DateTime HireDate { get; set; }

        // Navigation property
        public ICollection<Course> Courses { get; set; }
        public ICollection<Department> HeadOfDepartments { get; set; }
    }
}