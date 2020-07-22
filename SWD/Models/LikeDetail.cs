using System;
using System.Collections.Generic;

namespace SWD.Models
{
    public partial class LikeDetail
    {
        public int Id { get; set; }
        public int? UserId { get; set; }
        public int? CampaignId { get; set; }

        public Campaign Campaign { get; set; }
        public User User { get; set; }
    }
}
