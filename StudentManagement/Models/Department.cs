﻿namespace StudentManagement.Models
{
    public class Department
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public decimal Budget { get; set; }
        public DateTime StartDate { get; set; }
        public int? DepartmentHeadId { get; set; }

        // Navigation properties
        public Instructor DepartmentHead { get; set; }
        public ICollection<Course> Courses { get; set; }
    }
}