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
    public partial class cart : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
                Response.Redirect("UserLogin.aspx");

            if (!IsPostBack)
                LoadCart();
        }

        private void LoadCart()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT c.CartId, p.ProductName, p.Price, p.ImagePath, c.Quantity, (p.Price*c.Quantity) AS TotalPrice
                                 FROM Cart c
                                 INNER JOIN Products p ON c.ProductId=p.ProductId
                                 WHERE c.UserEmail=@u";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@u", Session["User"].ToString());
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptCart.DataSource = dt;
                rptCart.DataBind();

                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                    total += Convert.ToDecimal(row["TotalPrice"]);
                lblTotal.Text = total.ToString("0.00");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            TextBox txtQty = (TextBox)item.FindControl("txtQty");
            int qty = int.Parse(txtQty.Text);
            int cartId = int.Parse(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Cart SET Quantity=@q WHERE CartId=@id", con);
                cmd.Parameters.AddWithValue("@q", qty);
                cmd.Parameters.AddWithValue("@id", cartId);
                con.Open(); cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "Quantity updated ✔";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            LoadCart();
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int cartId = int.Parse(btn.CommandArgument);
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE CartId=@id", con);
                cmd.Parameters.AddWithValue("@id", cartId);
                con.Open(); cmd.ExecuteNonQuery();
            }
            lblMsg.Text = "Product removed ✔";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            string userEmail = Session["User"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1️⃣ Insert FIRST product to generate OrderId
                SqlCommand cmdFirst = new SqlCommand(@"
            INSERT INTO Orders(UserEmail, ProductId, Quantity, Price)
            SELECT TOP 1 UserEmail, ProductId, Quantity, Price
            FROM Cart
            WHERE UserEmail=@u;
            SELECT SCOPE_IDENTITY();", con);

                cmdFirst.Parameters.AddWithValue("@u", userEmail);
                int orderId = Convert.ToInt32(cmdFirst.ExecuteScalar());

                // 2️⃣ Insert remaining cart items using SAME OrderId
                SqlCommand cmdRest = new SqlCommand(@"
            INSERT INTO Orders(UserEmail, ProductId, Quantity, Price, OrderDate)
            SELECT UserEmail, ProductId, Quantity, Price, GETDATE()
            FROM Cart
            WHERE UserEmail=@u
            AND CartId NOT IN (
                SELECT TOP 1 CartId FROM Cart WHERE UserEmail=@u ORDER BY CartId
            )", con);

                cmdRest.Parameters.AddWithValue("@u", userEmail);
                cmdRest.ExecuteNonQuery();

                // 3️⃣ Clear Cart
                SqlCommand cmdClear = new SqlCommand(
                    "DELETE FROM Cart WHERE UserEmail=@u", con);
                cmdClear.Parameters.AddWithValue("@u", userEmail);
                cmdClear.ExecuteNonQuery();

                // 4️⃣ Redirect to Print Bill
                Response.Redirect("PrintBill.aspx?OrderId=" + orderId);
            }
        }



        protected void rptCart_ItemCommand2(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}