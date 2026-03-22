<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartPage.aspx.cs" Inherits="B_G_Patel_Tea_Shop.StartPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Start Page</title>
    <link href="Style/site.css" rel="stylesheet" />

    <style>
        /* Full page background with tea image */
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;

            background-image: url('../Images/BG Image.jpeg'); /* Your tea background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        /* Glass-style container */
        .container {
            background: rgba(255, 255, 255, 0.88); /* semi-transparent glass */
            padding: 50px 70px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
            animation: fadeIn 1.2s ease;
        }

        .container h1 {
            margin-bottom: 40px;
            color: #065f46;
            font-size: 32px;
        }

        /* Button container */
        .btn-box {
            display: flex;
            gap: 30px;
            justify-content: center;
        }

        /* Buttons style */
        .btn {
            width: 180px;
            padding: 15px;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            color: white;
            background: linear-gradient(135deg, #16a34a, #22c55e);
            transition: all 0.4s ease;
        }

        .btn:hover {
            transform: translateY(-8px) scale(1.05);
            box-shadow: 0 12px 25px rgba(0,0,0,0.3);
        }

        .btn:active {
            transform: scale(0.95);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

</head>

<body>
    <form id="form1" runat="server">

        <div class="container">
            <h1>Welcome to B G Patel Tea Shop</h1>

            <div class="btn-box">
                <asp:Button
                    ID="btnUser"
                    runat="server"
                    Text="User Login"
                    CssClass="btn"
                    OnClick="btnUser_Click" />

                <asp:Button
                    ID="btnAdmin"
                    runat="server"
                    Text="Admin Login"
                    CssClass="btn"
                    OnClick="btnAdmin_Click" />
            </div>
        </div>

    </form>
</body>
</html>