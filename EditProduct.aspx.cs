using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B_G_Patel_Tea_Shop
{
    public partial class EditProduct : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        int productId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
                Response.Redirect("AdminLogin.aspx");

            if (Request.QueryString["id"] == null)
                Response.Redirect("AdminDashboard.aspx");

            productId = Convert.ToInt32(Request.QueryString["id"]);

            if (!IsPostBack)
                LoadProduct();
        }

        void LoadProduct()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT ProductName, Price, ImagePath FROM Products WHERE ProductId=@id", con);
                cmd.Parameters.AddWithValue("@id", productId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtName.Text = dr["ProductName"].ToString();
                    txtPrice.Text = dr["Price"].ToString();
                    imgProduct.ImageUrl = dr["ImagePath"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string imagePath = imgProduct.ImageUrl;

            // If new image selected
            if (fuImage.HasFile)
            {
                string ext = Path.GetExtension(fuImage.FileName);
                string fileName = Guid.NewGuid() + ext;
                string folder = Server.MapPath("~/Product images/");

                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                fuImage.SaveAs(folder + fileName);
                imagePath = "~/Product images/" + fileName;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    @"UPDATE Products 
                      SET ProductName=@n, Price=@p, ImagePath=@img 
                      WHERE ProductId=@id", con);

                cmd.Parameters.AddWithValue("@n", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@p", decimal.Parse(txtPrice.Text.Trim()));
                cmd.Parameters.AddWithValue("@img", imagePath);
                cmd.Parameters.AddWithValue("@id", productId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "Product updated successfully ✔";
            lblMsg.ForeColor = System.Drawing.Color.Green;

            // Optional auto redirect
            Response.AddHeader("REFRESH", "2;URL=AdminDashboard.aspx");
        }
    }
}
    
