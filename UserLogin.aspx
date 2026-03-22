<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="B_G_Patel_Tea_Shop.UserLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Login</title>

    <style>
        /* Full-page background image */
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            height: 100vh;
            background-image: url('Images/BG Image.jpeg'); /* Set your tea plantation image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Dark overlay for readability */
        body::before {
            content: "";
            position: absolute;
            top:0; left:0; right:0; bottom:0;
            background: rgba(0,0,0,0.4); /* semi-transparent dark overlay */
            z-index: 1;
        }

        form {
            position: relative;
            z-index: 2; /* Ensure form is above overlay */
            width: 100%;
            max-width: 400px;
        }

        /* Login box */
        .box {
            background: rgba(255,255,255,0.95); /* slightly transparent to show bg */
            padding: 35px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.4);
        }

        h2 {
            text-align: center;
            color: #065f46;
            margin-bottom: 20px;
        }

        input, .aspNetTextBox {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .btn {
            width: 100%;
            background: #16a34a;
            color: white;
            border: none;
            padding: 12px;
            margin-top: 15px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn:hover {
            background: #15803d;
            transform: translateY(-2px);
        }

        .links {
            text-align: center;
            margin-top: 15px;
        }

        .links a {
            color: #16a34a;
            text-decoration: none;
            font-weight: bold;
            margin: 0 5px;
        }

        .links a:hover {
            text-decoration: underline;
        }

        /* Message label */
        #<%= lblMsg.ClientID %> {
            display: block;
            text-align: center;
            color: red;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>

<body>
<form runat="server">
    <div class="box">
        <h2>User Login</h2>

        <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password" />

        <asp:Button ID="btnLogin" runat="server" Text="Login"
            CssClass="btn" OnClick="btnLogin_Click" />

        <asp:Label ID="lblMsg" runat="server" />

        <div class="links">
            <a href="Register.aspx">Register</a> |
            <a href="ForgotPassword.aspx">Forgot Password?</a>
        </div>
    </div>
</form>
</body>
</html>