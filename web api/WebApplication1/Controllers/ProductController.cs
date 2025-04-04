using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {

        private static List<string> products = new List<string> { "Laptop", "Phone", "Tablet" };

        [HttpGet]
        public IActionResult GetProducts()
        {
            return Ok(products);
        }


        [HttpPost]
        public IActionResult AddProduct([FromBody] string product)
        {
            products.Add(product);
            // return Created("", product);
            return Ok("New Product is added to Server");
        }


    }
}