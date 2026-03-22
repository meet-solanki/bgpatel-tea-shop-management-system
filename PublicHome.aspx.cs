using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B_G_Patel_Tea_Shop
{
    public partial class Home : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        // =========================
        // LOAD PRODUCTS (PUBLIC)
        // =========================
        private void LoadProducts()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ProductId, ProductName, Price, ImagePath FROM Products";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptProducts.DataSource = dt;
                rptProducts.DataBind();
            }
        }
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                lblMsg.Text = "Please login first to add products!";
                return;
            }

            Button btn = (Button)sender;
            int productId = int.Parse(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Check if item already in cart
                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Cart WHERE UserEmail=@u AND ProductId=@p", con);
                check.Parameters.AddWithValue("@u", Session["User"].ToString());
                check.Parameters.AddWithValue("@p", productId);

                int exists = (int)check.ExecuteScalar();
                if (exists > 0)
                {
                    // Increment quantity
                    SqlCommand updateQty = new SqlCommand("UPDATE Cart SET Quantity = Quantity + 1 WHERE UserEmail=@u AND ProductId=@p", con);
                    updateQty.Parameters.AddWithValue("@u", Session["User"].ToString());
                    updateQty.Parameters.AddWithValue("@p", productId);
                    updateQty.ExecuteNonQuery();
                }
                else
                {
                    // Insert new item
                    SqlCommand cmd = new SqlCommand("INSERT INTO Cart(UserEmail, ProductId, Quantity) VALUES(@u,@p,@q)", con);
                    cmd.Parameters.AddWithValue("@u", Session["User"].ToString());
                    cmd.Parameters.AddWithValue("@p", productId);
                    cmd.Parameters.AddWithValue("@q", 1);
                    cmd.ExecuteNonQuery();
                }
            }

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Product added to cart successfully!";
        }



        protected void imgHome_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("PublicHome.aspx");

        }

        protected void imgLogin_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("StartPage.aspx");
        }

        protected void imgCart_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Cart.aspx");

        }

        protected void imgAbout_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("About.aspx");

        }

        protected void AddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Write("<script>alert('First you need to login');</script>");
            }
            else
            {
                Response.Write("<script>alert('Product added to cart');</script>");
                // later we will insert into Cart table
            }

        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

     
    }
    
}