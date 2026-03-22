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
    public partial class ViewOrders : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin session protection
            if (Session["User"] == null)
                Response.Redirect("UserLogin.aspx");

            if (!IsPostBack)
                LoadOrders();
        }

        private void LoadOrders()
        {
            string userEmail = Session["User"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT o.OrderId, p.ProductName, p.ImagePath, o.Quantity, o.Price, (o.Price*o.Quantity) AS TotalPrice, o.OrderDate
                FROM Orders o
                INNER JOIN Products p ON o.ProductId = p.ProductId
                WHERE o.UserEmail=@u
                ORDER BY o.OrderId DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@u", userEmail);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptOrders.DataSource = dt;
                rptOrders.DataBind();
            }
        }
    }

}