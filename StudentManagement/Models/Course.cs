using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentManagement.Models
{
    public class Course
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int Credits { get; set; }
        public int? InstructorId { get; set; }

        // Navigation property
        public ICollection<Enrollment> Enrollments { get; set; }
        public Instructor Instructor { get; set; }
    }
}
