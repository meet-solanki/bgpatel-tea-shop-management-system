<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="B_G_Patel_Tea_Shop.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 
      <title>Admin Login</title>

    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: 'Segoe UI', sans-serif;
            background-image: url('Images/BG Image.jpeg'); /* Your background image */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Semi-transparent glass login box */
        .login-box {
            background: rgba(255, 255, 255, 0.9);
            padding: 45px;
            width: 380px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4);
            animation: fadeIn 1s ease;
            backdrop-filter: blur(5px); /* Optional: adds glass blur effect */
        }

        .login-box h2 {
            text-align: center;
            color: #065f46;
            margin-bottom: 30px;
        }

        .input-box {
            margin-bottom: 20px;
        }

        .input-box input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            font-size: 15px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 25px;
            background: linear-gradient(135deg, #16a34a, #22c55e);
            color: white;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.3);
        }

        .success {
            color: green;
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="login-box">
            <h2>Admin Login</h2>

            <div class="input-box">
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
            </div>

            <div class="input-box">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />

            <asp:Label ID="lblSuccess" runat="server" CssClass="success"></asp:Label>
            <asp:Label ID="lblMsg" runat="server" CssClass="error"></asp:Label>
        </div>

    </form>
</body>
</html>