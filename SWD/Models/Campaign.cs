using System;
using System.Collections.Generic;

namespace SWD.Models
{
    public partial class Campaign
    {
        public Campaign()
        {
            DonateDetail = new HashSet<DonateDetail>();
            LikeDetail = new HashSet<LikeDetail>();
        }

        public string CampaignName { get; set; }
        public double Amount { get; set; }
        public double CurrentlyMoney { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Description { get; set; }
        public bool Approved { get; set; }
        public bool? IsDeleted { get; set; }
        public int? CategoryId { get; set; }
        public int? UserId { get; set; }
        public int Id { get; set; }
        public int? Popular { get; set; }
        public string Image { get; set; }

        public Category Category { get; set; }
        public User User { get; set; }
        public ICollection<DonateDetail> DonateDetail { get; set; }
        public ICollection<LikeDetail> LikeDetail { get; set; }
    }
}
