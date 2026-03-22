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
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;
        bool isViewProducts = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
                Response.Redirect("AdminLogin.aspx");

            if (ViewState["ViewProducts"] != null)
            {
                isViewProducts = (bool)ViewState["ViewProducts"];
            }

            if (isViewProducts)
            {
                LoadProductsTable(); // 🔥 recreate table on postback
            }



        }

        protected void btnLogout_Click(object sender, ImageClickEventArgs e)
        {
            Session.Clear();
            Response.Redirect("StartPage.aspx");

        }

        protected void btnHome_Click(object sender, ImageClickEventArgs e)
        {
            Session.Clear();
            Response.Redirect("PubliHome.aspx");
        }

        protected void btnAddProducts_Click(object sender, EventArgs e)
        {
            pnlContent.Controls.Clear();
            pnlAddProduct.Visible = true;
            lblMsg.Text = "";
        }

        protected void btnViewProducts_Click(object sender, EventArgs e)
        {
            ViewState["ViewProducts"] = true;
            LoadProductsTable();
        }

        private void LoadProductsTable()
        {
            pnlContent.Controls.Clear();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ProductId, ProductName, Price, ImagePath FROM Products";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlContent.Controls.Add(new Literal { Text = "<b>No products found.</b>" });
                    return;
                }

                Table tbl = new Table { Width = 900 };

                // ===== HEADER =====
                TableHeaderRow hr = new TableHeaderRow();
                hr.Cells.Add(new TableHeaderCell { Text = "ID" });
                hr.Cells.Add(new TableHeaderCell { Text = "Name" });
                hr.Cells.Add(new TableHeaderCell { Text = "Price" });
                hr.Cells.Add(new TableHeaderCell { Text = "Image" });
                hr.Cells.Add(new TableHeaderCell { Text = "Edit" });
                hr.Cells.Add(new TableHeaderCell { Text = "Delete" });
                tbl.Rows.Add(hr);

                // ===== ROWS =====
                foreach (DataRow row in dt.Rows)
                {
                    int pid = Convert.ToInt32(row["ProductId"]);
                    TableRow tr = new TableRow();

                    tr.Cells.Add(new TableCell { Text = pid.ToString() });
                    tr.Cells.Add(new TableCell { Text = row["ProductName"].ToString() });
                    tr.Cells.Add(new TableCell { Text = "₹ " + row["Price"].ToString() });

                    Image img = new Image
                    {
                        ImageUrl = row["ImagePath"].ToString(),
                        Width = 60,
                        Height = 60
                    };
                    TableCell imgCell = new TableCell();
                    imgCell.Controls.Add(img);
                    tr.Cells.Add(imgCell);

                    // ===== EDIT =====
                    LinkButton btnEdit = new LinkButton
                    {
                        Text = "✏ Edit",
                        CssClass = "btn-edit",
                        PostBackUrl = "EditProduct.aspx?id=" + pid
                    };
                    TableCell editCell = new TableCell();
                    editCell.Controls.Add(btnEdit);
                    tr.Cells.Add(editCell);

                    // ===== DELETE (WORKING) =====
                    LinkButton btnDelete = new LinkButton
                    {
                        Text = "🗑 Delete",
                        CssClass = "btn-delete",
                        CommandArgument = pid.ToString(),
                        OnClientClick = "return confirm('Are you sure you want to delete this product?');"
                    };
                    btnDelete.Click += BtnDelete_Click;

                    TableCell delCell = new TableCell();
                    delCell.Controls.Add(btnDelete);
                    tr.Cells.Add(delCell);

                    tbl.Rows.Add(tr);
                }

                pnlContent.Controls.Add(tbl);
            }
        }

        // =========================
        // DELETE EVENT (FINAL)
        // =========================
        protected void BtnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Products WHERE ProductId=@id", con);
                cmd.Parameters.AddWithValue("@id", productId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Refresh list
            LoadProductsTable();
        }
    

        protected void btnViewOrders_Click(object sender, EventArgs e)
        {
            pnlContent.Controls.Clear();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT o.OrderId, u.Email AS UserEmail, p.ProductName, o.Quantity, o.Price, (o.Price*o.Quantity) AS TotalPrice, o.OrderDate
                FROM Orders o
                INNER JOIN Products p ON o.ProductId = p.ProductId
                INNER JOIN Users u ON o.UserEmail = u.Email
                ORDER BY o.OrderId DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    Table tbl = new Table { Width = 900 };
                    TableHeaderRow header = new TableHeaderRow();
                    header.Cells.Add(new TableHeaderCell { Text = "Order ID" });
                    header.Cells.Add(new TableHeaderCell { Text = "User Email" });
                    header.Cells.Add(new TableHeaderCell { Text = "Product" });
                    header.Cells.Add(new TableHeaderCell { Text = "Qty" });
                    header.Cells.Add(new TableHeaderCell { Text = "Price" });
                    header.Cells.Add(new TableHeaderCell { Text = "Total" });
                    header.Cells.Add(new TableHeaderCell { Text = "Date" });
                    tbl.Rows.Add(header);

                    foreach (DataRow row in dt.Rows)
                    {
                        TableRow tr = new TableRow();
                        tr.Cells.Add(new TableCell { Text = row["OrderId"].ToString() });
                        tr.Cells.Add(new TableCell { Text = row["UserEmail"].ToString() });
                        tr.Cells.Add(new TableCell { Text = row["ProductName"].ToString() });
                        tr.Cells.Add(new TableCell { Text = row["Quantity"].ToString() });
                        tr.Cells.Add(new TableCell { Text = "₹ " + row["Price"].ToString() });
                        tr.Cells.Add(new TableCell { Text = "₹ " + row["TotalPrice"].ToString() });
                        tr.Cells.Add(new TableCell { Text = Convert.ToDateTime(row["OrderDate"]).ToString("dd/MM/yyyy HH:mm") });
                        tbl.Rows.Add(tr);
                    }

                    pnlContent.Controls.Add(tbl);
                }
                else
                {
                    pnlContent.Controls.Add(new Literal { Text = "<b>No orders found.</b>" });
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;

            if (txtName.Text.Trim() == "" || txtPrice.Text.Trim() == "")
            {
                lblMsg.Text = "❌ Please fill all fields";
                return;
            }

            if (!fuImg.HasFile)
            {
                lblMsg.Text = "❌ Please choose product image";
                return;
            }

            decimal price;
            if (!decimal.TryParse(txtPrice.Text.Trim(), out price))
            {
                lblMsg.Text = "❌ Invalid price";
                return;
            }

            // ===== SAVE IMAGE =====
            string ext = System.IO.Path.GetExtension(fuImg.FileName);
            string fileName = Guid.NewGuid().ToString() + ext;
            string folder = Server.MapPath("~/Images/");

            if (!System.IO.Directory.Exists(folder))
                System.IO.Directory.CreateDirectory(folder);

            fuImg.SaveAs(folder + fileName);
            string imagePath = "~/Images/" + fileName;

            // ===== INSERT DB =====
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Products(ProductName, Price, ImagePath) VALUES(@n,@p,@img)", con);

                cmd.Parameters.AddWithValue("@n", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@p", price);
                cmd.Parameters.AddWithValue("@img", imagePath);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "✅ Product added successfully";

            txtName.Text = "";
            txtPrice.Text = "";
        }
    
    }
    
}

