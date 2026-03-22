using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace B_G_Patel_Tea_Shop
{
    public partial class UserLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT * FROM Users WHERE Email=@Email AND Password=@Password";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        dr.Read();
                        Session["User"] = dr["Email"].ToString(); // store user in session
                        Response.Redirect("UserHome.aspx"); // redirect to user home page
                    }
                    else
                    {
                        lblMsg.Text = "Invalid Email or Password!";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (SqlException ex)
            {
                lblMsg.Text = "Database error: " + ex.Message;
            }

        }

    }
}
