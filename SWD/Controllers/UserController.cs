using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SWD.Models;

namespace SWD.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly SWD391Context _context;

        public UserController(SWD391Context context)
        {
            _context = context;
        }

        // GET: api/User
        [HttpGet("[action]")]
        public ActionResult UserMostFavourite()
        {
            var user = _context.User
                       .OrderByDescending(c => c.Count)
                       .Include(s => s.Campaign)
                       .Select(c => new
                       {
                           userId = c.Id,
                           firstName = c.FirstName,
                           lastName = c.LastName,
                           careless = c.Count,
                           totalCampaign = c.Campaign.Where(s => s.UserId == c.Id).Count(),
                       }).Take(1)
                       .ToList();
            return Ok(user);
        }

        // GET: api/Users/5
        [HttpGet("[action]/{userId}")]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers(string userId)
        {
            var users = _context.User.Where(u => u.Id.Equals(userId)).ToList();
            return users;
        }

        [HttpGet]
        public async Task<ActionResult> GetUserByName([FromQuery]String FilterUserName)
        {
            var author = _context.User.AsQueryable();

            if (!String.IsNullOrWhiteSpace(FilterUserName))
            {
                author = author.Where(x => x.FirstName.Contains(FilterUserName) || x.LastName.Contains(FilterUserName));
            }
            return Ok(author);
        }

        // PUT: api/Users/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        //[HttpPut("{id}")]
        //public async Task<IActionResult> PutUsers(string id, User user)
        //{
        //    if (id != users.UserId)
        //    {
        //        return BadRequest();
        //    }

        //    _context.Entry(users).State = EntityState.Modified;

        //    try
        //    {
        //        await _context.SaveChangesAsync();
        //    }
        //    catch (DbUpdateConcurrencyException)
        //    {
        //        if (!UsersExists(id))
        //        {
        //            return NotFound();
        //        }
        //        else
        //        {
        //            throw;
        //        }
        //    }

        //    return NoContent();
        //}

        // POST: api/Users
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        //[HttpPost]
        //public async Task<ActionResult<User>> PostUsers(User users)
        //{

        //}

        // DELETE: api/Users/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<User>> DeleteUsers(string id)
        {
            var users = await _context.User.FindAsync(id);
            if (users == null)
            {
                return NotFound();
            }

            _context.User.Remove(users);
            await _context.SaveChangesAsync();

            return users;
        }

        private bool UserExists(int id)
        {
            return _context.User.Any(e => e.Id == id);
        }
    }
}