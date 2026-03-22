<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="B_G_Patel_Tea_Shop.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  
 
   <title>User Registration</title>

    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            background-image: url('Images/BG Image.jpeg'); /* Set your background image here */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        /* Optional dark overlay for readability */
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
            width: 380px;
            background: rgba(255,255,255,0.95); /* slightly transparent for background effect */
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.35);
            animation: slideFade 1s ease;
        }

        h2 {
            text-align: center;
            color: #065f46;
            margin-bottom: 20px;
        }

        .input-box {
            margin-bottom: 15px;
        }

        .input-box input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
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
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.3);
        }

        .msg {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }

        .links {
            text-align: center;
            margin-top: 15px;
        }

        .links a {
            text-decoration: none;
            color: #16a34a;
            font-weight: bold;
        }

        @keyframes slideFade {
            from { opacity: 0; transform: translateY(40px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
<form runat="server">
    <div class="box">
        <h2>Create Account</h2>

        <div class="input-box">
            <asp:TextBox ID="txtName" runat="server" Placeholder="Full Name" />
        </div>

        <div class="input-box">
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" />
        </div>

        <div class="input-box">
            <asp:TextBox ID="txtPassword" runat="server"
                TextMode="Password" Placeholder="Password" />
        </div>

        <asp:Button ID="btnRegister" runat="server"
            Text="Register"
            CssClass="btn"
            OnClick="btnRegister_Click" />

        <asp:Label ID="lblMsg" runat="server" CssClass="msg" />

        <div class="links">
            Already have an account?
            <a href="UserLogin.aspx">Login</a>
        </div>
    </div>
</form>
</body>
</html>