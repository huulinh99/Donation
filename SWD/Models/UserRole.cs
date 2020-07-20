using System;
using System.Collections.Generic;

namespace SWD.Models
{
    public partial class UserRole
    {
        public UserRole()
        {
            User = new HashSet<User>();
        }

        public int Id { get; set; }
        public string RoleName { get; set; }

        public ICollection<User> User { get; set; }
    }
}
