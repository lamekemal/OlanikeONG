using Microsoft.WindowsAzure.Storage.Table;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.Numerics;

namespace Olanike.Models
{
    public class Newsletter : TableEntity
    {
        [Required]
        [JsonProperty("id")]
        public int Id { get; set; }
        public string Tokens { get; set; } = Guid.NewGuid().ToString();

        public string Name { get; set; } = null!;

        public string Phone { get; set; } = null!;

        [Required]
        public string? Mail { get; set; }

        public string Message { get; set; } = null!;

        [Required]
        public DateTime ProductionDate { get; set; } = DateTime.Now;    
    }
}
