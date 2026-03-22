<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="B_G_Patel_Tea_Shop.About" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 
    <title>About Us - B G Patel Tea Shop</title>
    <style>
        body {
            margin: 0;
            font-family: Segoe UI, sans-serif;
            background: #f5f5f5;
        }

        /* HEADER */
        .header {
            background: #166534;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            margin: 0;
        }

        .menu img {
            width: 28px;
            height: 28px;
            margin-left: 10px;
            cursor: pointer;
        }

        /* ABOUT SECTION */
        .about-box {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .about-box img {
            width: 100%;
            height: 260px;
            object-fit: cover;
            border-radius: 10px;
        }

        .about-box h3 {
            margin-top: 20px;
            color: #166534;
        }

        .about-box p {
            line-height: 1.7;
            color: #065f46;
            font-size: 16px;
        }

        /* FOOTER */
        .footer {
            margin-top: 40px;
            padding: 15px;
            background: #166534;
            color: white;
            text-align: center;
        }
    </style>
</head>
<body>
<form runat="server">

    <!-- HEADER -->
    <div class="header">
        <h2>B G Patel Tea Shop</h2>
        <div class="menu">
            <asp:ImageButton ID="btnHome" runat="server" ImageUrl="Images/Home.png" Width="28px" Height="28px" PostBackUrl="PublicHome.aspx" />
            <asp:ImageButton ID="btnLogin" runat="server" ImageUrl="Images/login.png" Width="28px" Height="28px" PostBackUrl="UserLogin.aspx" />
        </div>
    </div>

    <!-- ABOUT CONTENT -->
    <div class="about-box">
        <asp:Image ID="imgTea" runat="server" ImageUrl="Images/banner1.jpg" />

        <h3>About B G Patel Tea Shop</h3>

        <p>
            Welcome to <b>B G Patel Tea Shop</b>, your trusted destination for premium quality
            <b>Tea Patti</b>. We believe that a perfect cup of tea brings freshness, energy,
            and happiness to everyday life.
        </p>

        <p>
            Our tea products are carefully selected and packed to maintain freshness and rich
            aroma. We combine traditional tea taste with modern online service to provide
            convenience and quality to our customers.
        </p>

        <p>
            Thank you for choosing <b>B G Patel Tea Shop</b>.
            We are committed to serving you the best tea experience.
        </p>
    </div>

    <!-- FOOTER -->
    <div class="footer">
        © 2026 B G Patel Tea Shop | All Rights Reserved
    </div>

</form>
</body>
</html>
