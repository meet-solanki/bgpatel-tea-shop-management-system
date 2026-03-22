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
    public partial class PrintBill : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
                Response.Redirect("UserLogin.aspx");

            if (!IsPostBack)
            {
                LoadLatestBill();
            }
        }

        private void LoadLatestBill()
        {
            string userEmail = Session["User"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 1️⃣ Get latest order date for this user
                SqlCommand cmdDate = new SqlCommand(@"
                    SELECT MAX(OrderDate)
                    FROM Orders
                    WHERE UserEmail=@u", con);
                cmdDate.Parameters.AddWithValue("@u", userEmail);

                object dateObj = cmdDate.ExecuteScalar();
                if (dateObj == DBNull.Value || dateObj == null)
                {
                    lblOrderInfo.Text = "No orders found.";
                    return;
                }

                DateTime latestDate = Convert.ToDateTime(dateObj);

                // 2️⃣ Get all products from that order date
                SqlDataAdapter da = new SqlDataAdapter(@"
    SELECT 
        p.ProductName,
        p.ImagePath,
        p.Price AS Price,
        ISNULL(o.Quantity,1) AS Quantity,
        p.Price * ISNULL(o.Quantity,1) AS TotalPrice
    FROM Orders o
    INNER JOIN Products p ON o.ProductId = p.ProductId
    WHERE o.UserEmail=@u
    AND o.OrderDate=@d", con);

                da.SelectCommand.Parameters.AddWithValue("@u", userEmail);
                da.SelectCommand.Parameters.AddWithValue("@d", latestDate);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptBill.DataSource = dt;
                rptBill.DataBind();

                // 3️⃣ Grand total
                decimal grandTotal = 0;
                foreach (DataRow row in dt.Rows)
                    grandTotal += Convert.ToDecimal(row["TotalPrice"]);

                // 4️⃣ Set footer label (inside Repeater)
                if (rptBill.Controls.Count > 0)
                {
                    Control footer = rptBill.Controls[rptBill.Controls.Count - 1];
                    Label lblGrand = footer.FindControl("lblGrandTotal") as Label;
                    if (lblGrand != null)
                        lblGrand.Text = grandTotal.ToString("0.00");
                }

                lblOrderInfo.Text =
                    $"<b>Customer:</b> {userEmail} &nbsp;&nbsp; " +
                    $"<b>Date:</b> {latestDate:dd/MM/yyyy HH:mm}";
            }
        }
    

protected void rptBill_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}