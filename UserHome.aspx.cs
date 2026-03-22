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
    public partial class UserHome : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("UserLogin.aspx"); // redirect if not logged in
            }

            if (!IsPostBack)
            {
                // Show username
                lblUser.Text = Session["User"].ToString();

                // Load products
                LoadProducts();
                
            }

        }
        private void LoadProducts()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Products", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptProducts.DataSource = dt;
                rptProducts.DataBind();
            }
        }

        // Load sliding banner products
       

        protected void rptSlider_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
        protected void AddToCart_Click(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Write("<script>alert('Please login first');</script>");
                return;
            }

            Button btn = (Button)sender; // Or ImageButton if using ImageButton
            int productId = int.Parse(btn.CommandArgument.ToString());

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
                    // Optional: increment quantity
                    SqlCommand updateQty = new SqlCommand("UPDATE Cart SET Quantity = Quantity + 1 WHERE UserEmail=@u AND ProductId=@p", con);
                    updateQty.Parameters.AddWithValue("@u", Session["User"].ToString());
                    updateQty.Parameters.AddWithValue("@p", productId);
                    updateQty.ExecuteNonQuery();
                }
                else
                {
                    // Insert new row
                    SqlCommand cmd = new SqlCommand("INSERT INTO Cart(UserEmail, ProductId, Quantity) VALUES(@u,@p,@q)", con);
                    cmd.Parameters.AddWithValue("@u", Session["User"].ToString());
                    cmd.Parameters.AddWithValue("@p", productId);
                    cmd.Parameters.AddWithValue("@q", 1);
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("Cart.aspx"); // Redirect to see cart items
        
        }


        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void btnHome_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("UserHome.aspx");

        }

        protected void btnCart_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Cart.aspx");

        }


        protected void btnLogout_Click(object sender, ImageClickEventArgs e)
        {
           
            Response.Redirect("StartPage.aspx");

        }

        protected void btnAbout_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("About2.aspx");

        }
    }
}