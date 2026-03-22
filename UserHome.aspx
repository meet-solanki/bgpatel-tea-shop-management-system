<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserHome.aspx.cs" Inherits="B_G_Patel_Tea_Shop.UserHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>B G Patel Tea Shop - User Home</title>

    <style>
        /* Full page background image */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-image: url('Images/BG Image.jpeg'); /* Set your tea plantation image here */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }

        /* Dark overlay for readability */
        body::before {
            content: "";
            position: absolute;
            top:0; left:0; right:0; bottom:0;
            background: rgba(0,0,0,0.35);
            z-index: 1;
        }

        form {
            position: relative;
            z-index: 2; /* Ensure content is above overlay */
        }

        /* Header */
        .header {
            background: rgba(17,24,39,0.9); /* semi-transparent dark */
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 3;
        }

        .title h1 {
            margin: 0;
            font-size: 26px;
        }

        .title span {
            font-size: 14px;
            color: #d1d5db;
        }

        /* Navigation icons */
        .menu img {
            margin-left: 12px;
            cursor: pointer;
            width: 28px;
            height: 28px;
            transition: transform 0.2s;
        }

        .menu img:hover {
            transform: scale(1.15);
        }

        .highlight {
            background: linear-gradient(to right, #065f46, #16a34a, 0.9);
            color: white;
            font-size: 18px;
            padding: 10px;
            font-weight: bold;
            text-align: center;
        }

        .highlight marquee {
            color: #fff;
        }

        /* Products grid */
        .products {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 40px;
            gap: 30px;
        }

        .card {
            background: rgba(255,255,255,0.95);
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            transition: transform 0.3s;
            width: 200px;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
        }

        .price {
            font-weight: bold;
            margin: 10px 0;
            color: #166534;
        }

        .btn {
            padding: 8px 18px;
            border: none;
            border-radius: 20px;
            background: #16a34a;
            color: white;
            cursor: pointer;
        }

        .btn:hover {
            background: #15803d;
        }

        /* Bottom Collection Section */
        .collection-section {
            margin-top: 70px;
            padding: 40px 0;
            background: rgba(238,247,233,0.95);
            text-align: center;
        }

        .collection-section h2 {
            margin-bottom: 30px;
            font-size: 26px;
            color: #365314;
        }

        .carousel {
            overflow: hidden;
            width: 100%;
        }

        .carousel-track {
            display: flex;
            width: calc(200px * 6);
            animation: slide 25s linear infinite;
        }

        .circle-card {
            width: 180px;
            margin: 0 20px;
            text-align: center;
        }

        .circle-card img {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            background: white;
            padding: 10px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }

        .circle-card p {
            margin-top: 10px;
            font-weight: bold;
            color: #374151;
        }

        @keyframes slide {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        /* Footer */
        .footer {
            margin-top: 60px;
            background: rgba(17,24,39,0.9);
            color: white;
            text-align: center;
            padding: 25px;
        }

    </style>
</head>

<body>
<form runat="server">

    <!-- HEADER -->
    <div class="header">
        <h2>B G Patel Tea Shop</h2>

        <div class="menu">
            <asp:ImageButton ID="btnHome" runat="server" ImageUrl="images/Home.png" Width="28px" Height="28px" ToolTip="Home" OnClick="btnHome_Click" />
            <asp:ImageButton ID="btnCart" runat="server" ImageUrl="images/cart.png" Width="28px" Height="28px" ToolTip="Cart" OnClick="btnCart_Click" />
            <asp:ImageButton ID="btnLogout" runat="server" ImageUrl="images/logout.png" Width="28px" Height="28px" ToolTip="Logout" OnClick="btnLogout_Click" />
            <asp:ImageButton ID="btnAbout" runat="server" ImageUrl="images/about.jpeg" Width="28px" Height="28px" ToolTip="About Us" OnClick="btnAbout_Click" />
        </div>
    </div>

    <!-- Highlight marquee -->
    <div class="highlight">
        <marquee behavior="scroll" direction="left">
            🌟 This is Our Top Tea Patti Brand – Fresh • Strong • Trusted 🌟
        </marquee>
    </div>

    <!-- Welcome message -->
    <div class="welcome" style="text-align:center; margin-top:20px; color:white;">
        Welcome, <asp:Label ID="lblUser" runat="server" Text=""></asp:Label> – Enjoy our Premium Tea Patti
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="msg" />

    <!-- Products grid -->
    <div class="products">
        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
            <ItemTemplate>
                <div class="card">
                   <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>'/>
                      <div class="productname"> <%# Eval("ProductName") %> </div>
                    <div class="price">₹ <%# Eval("Price") %> / 500gm</div>
                    <asp:Button ID="btnAddToCart" runat="server"
                        Text="Add to Cart"
                        CssClass="btn"
                        CommandArgument='<%# Eval("ProductId") %>'
                        OnClick="AddToCart_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Bottom Carousel -->
    <div class="collection-section">
        <h2>Our Top Tea Patti Brands</h2>

        <div class="carousel">
            <div class="carousel-track">
                <div class="circle-card">
                    <img src="Images/assam.jpg" />
                    <p>Assam Tea</p>
                </div>
                <div class="circle-card">
                    <img src="Images/green.jpeg" />
                    <p>Green Tea</p>
                </div>
                <div class="circle-card">
                    <img src="Images/masala.jpeg" />
                    <p>Masala Tea</p>
                </div>
                <div class="circle-card">
                    <img src="Images/premium.jpeg" />
                    <p>Premium Tea</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        © 2026 B G Patel Tea Shop | All Rights Reserved
    </div>

</form>
</body>
</html>