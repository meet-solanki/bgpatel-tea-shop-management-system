<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="B_G_Patel_Tea_Shop.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Reset Password</title>

    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: Segoe UI, sans-serif;
            background-image: url('Images/BG Image.jpeg'); /* Set your background image here */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        /* Dark overlay to make form readable */
        body::before {
            content: "";
            position: absolute;
            top:0; left:0; right:0; bottom:0;
            background: rgba(0,0,0,0.35);
            z-index: 1;
        }

        .box {
            position: relative;
            z-index: 2; /* ensures box is above overlay */
            width: 400px;
            background: rgba(255,255,255,0.95); /* slightly transparent for effect */
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.35);
            animation: fade 1s ease;
        }

        h2 {
            text-align: center;
            color: #065f46;
            margin-bottom: 20px;
        }

        .input {
            margin-top: 15px;
        }

        .input input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 30px;
            background: linear-gradient(135deg, #16a34a, #22c55e);
            color: white;
            font-size: 16px;
            font-weight: bold;
            margin-top: 15px;
            cursor: pointer;
        }

        .btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.3);
        }

        .otp {
            text-align: center;
            margin-top: 10px;
            font-size: 18px;
            color: #16a34a;
            font-weight: bold;
        }

        .msg {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }

        @keyframes fade {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
<form runat="server">

<div class="box">
    <h2>Reset Password</h2>

    <!-- EMAIL -->
    <div class="input">
        <asp:TextBox ID="txtEmail" runat="server"
            Placeholder="Enter Registered Email" />
    </div>

    <asp:Button ID="btnSendOtp" runat="server"
        Text="Generate OTP"
        CssClass="btn"
        OnClick="btnSendOtp_Click" />

    <!-- SHOW OTP -->
    <asp:Label ID="lblOtp" runat="server" CssClass="otp" />

    <!-- OTP INPUT -->
    <div class="input">
        <asp:TextBox ID="txtOtp" runat="server"
            Placeholder="Enter OTP"
            Visible="false" />
    </div>

    <asp:Button ID="btnVerify" runat="server"
        Text="Verify OTP"
        CssClass="btn"
        Visible="false"
        OnClick="btnVerify_Click" />

    <!-- RESET PASSWORD PANEL -->
    <asp:Panel ID="pnlReset" runat="server" Visible="false">

        <div class="input">
            <asp:TextBox ID="txtNewPwd" runat="server"
                Placeholder="New Password"
                TextMode="Password" />
        </div>

        <div class="input">
            <asp:TextBox ID="txtConfirmPwd" runat="server"
                Placeholder="Confirm Password"
                TextMode="Password" />
        </div>

        <asp:Button ID="btnReset" runat="server"
            Text="Reset Password"
            CssClass="btn"
            OnClick="btnReset_Click" />

    </asp:Panel>

    <asp:Label ID="lblMsg" runat="server" CssClass="msg" />
</div>

</form>
</body>
</html>