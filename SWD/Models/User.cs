using System;
using System.Collections.Generic;

namespace SWD.Models
{
    public partial class User
    {
        public User()
        {
            Campaign = new HashSet<Campaign>();
            DonateDetail = new HashSet<DonateDetail>();
            LikeDetail = new HashSet<LikeDetail>();
        }

        public string Password { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public int RoleId { get; set; }
        public double Balance { get; set; }
        public int? LoginMethodId { get; set; }
        public int Id { get; set; }
        public string Uid { get; set; }
        public int? Count { get; set; }

        public UserRole Role { get; set; }
        public ICollection<Campaign> Campaign { get; set; }
        public ICollection<DonateDetail> DonateDetail { get; set; }
        public ICollection<LikeDetail> LikeDetail { get; set; }
    }
}
