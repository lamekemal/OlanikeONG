using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Olanike.Models;
using System.Reflection.Emit;

namespace Olanike.Data
{
    public class ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : IdentityDbContext<ApplicationUser>(options)
    {
        public const string DefaultSchema = @"OLANIKE";
        public DbSet<Newsletter> Newsletters { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.HasDefaultSchema(DefaultSchema);
            base.OnModelCreating(builder);
            builder.Entity<IdentityRole>()
                .Property(b => b.ConcurrencyStamp)
                .IsETagConcurrency();
            builder.Entity<ApplicationUser>() // ApplicationUser mean the Identity user 'ApplicationUser : IdentityUser'
                .Property(b => b.ConcurrencyStamp)
                .IsETagConcurrency();

        }
    }
}
