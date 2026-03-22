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
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        protected void btnSendOtp_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT UserId FROM Users WHERE Email=@e", con);
                cmd.Parameters.AddWithValue("@e", txtEmail.Text);

                con.Open();
                object user = cmd.ExecuteScalar();

                if (user != null)
                {
                    Random r = new Random();
                    int otp = r.Next(100000, 999999);

                    Session["OTP"] = otp;
                    Session["Email"] = txtEmail.Text;

                    lblOtp.Text = "Your OTP is: " + otp;
                    txtOtp.Visible = true;
                    btnVerify.Visible = true;

                    lblMsg.Text = "OTP Generated";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblMsg.Text = "Email not registered!";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }

        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (Session["OTP"] != null &&
               txtOtp.Text == Session["OTP"].ToString())
            {
                lblMsg.Text = "OTP Verified Successfully";
                lblMsg.ForeColor = System.Drawing.Color.Green;

                pnlReset.Visible = true;
            }
            else
            {
                lblMsg.Text = "Invalid OTP";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (txtNewPwd.Text != txtConfirmPwd.Text)
            {
                lblMsg.Text = "Passwords do not match";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Users SET Password=@p WHERE Email=@e", con);
                cmd.Parameters.AddWithValue("@p", txtNewPwd.Text);
                cmd.Parameters.AddWithValue("@e", Session["Email"]);

                con.Open();
                cmd.ExecuteNonQuery();

                lblMsg.Text = "Password Reset Successfully ✅";
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
        }

    }

}
