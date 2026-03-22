<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PublicHome.aspx.cs" Inherits="B_G_Patel_Tea_Shop.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <title>B G Patel Tea Shop - User Home</title>

    <style>
        /* Full page background */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-image: url('Images/BG Image.jpeg'); /* full tea plantation background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        form {
            position: relative;
            z-index: 1;
        }

        /* Header */
        .header {
            background: rgba(17,24,39,0.85); /* semi-transparent dark */
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 3;
            border-radius: 0 0 15px 15px;
        }

        .header h2 {
            margin: 0;
        }

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

        /* Highlight marquee */
        .highlight {
            background: rgba(6,95,70,0.85);
            color: white;
            font-size: 18px;
            padding: 10px;
            font-weight: bold;
            text-align: center;
            margin-top: 5px;
            border-radius: 10px;
        }

        .highlight marquee {
            color: #fff;
        }

        /* Welcome text */
        .welcome {
            text-align: center;
            margin-top: 20px;
            color: white;
            font-size: 20px;
            font-weight: bold;
        }

        /* Products Container with Background */
        .products-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 30px;

            /* Background image behind products */
            background-image: url('Images/BG Image2.jpeg'); /* your products background */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            border-radius: 15px;
            margin: 20px;
        }

        /* Individual Product Cards */
        .product-card {
            background: rgba(255,255,255,0.85); /* semi-transparent to show bg */
            border-radius: 10px;
            width: 200px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        .product-card img {
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

        .btn-add {
            padding: 8px 18px;
            border: none;
            border-radius: 20px;
            background: #16a34a;
            color: white;
            cursor: pointer;
            margin-top: 10px;
            transition: background 0.3s, transform 0.2s;
        }

        .btn-add:hover {
            background: #15803d;
            transform: scale(1.05);
        }

        .msg {
            text-align: center;
            margin: 10px 0;
            font-weight: bold;
            color: red;
        }

        /* Carousel Section */
        .collection-section {
            margin-top: 50px;
            padding: 40px 0;
            background: rgba(238,247,233,0.9);
            text-align: center;
            border-radius: 15px;
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
            background: rgba(17,24,39,0.85);
            color: white;
            text-align: center;
            padding: 25px;
            border-radius: 15px;
        }
    </style>
</head>

<body>
<form runat="server">

    <!-- HEADER -->
    <div class="header">
        <h2>B G Patel Tea Shop</h2>

        <div class="menu">
             <asp:ImageButton ID="imgHome" runat="server" ImageUrl="~/Images/Home.png"
                        Width="28px" Height="28px" ToolTip="Home" OnClick="imgHome_Click" />
                    <asp:ImageButton ID="imgLogin" runat="server" ImageUrl="~/Images/login.png"
                        Width="28px" Height="28px" ToolTip="Login" OnClick="imgLogin_Click" />
                    <asp:ImageButton ID="imgCart" runat="server" ImageUrl="~/Images/cart.png"
                        Width="28px" Height="28px" ToolTip="Cart" OnClick="imgCart_Click" />
                    <asp:ImageButton ID="imgAbout" runat="server" ImageUrl="~/Images/about.jpeg"
                        Width="28px" Height="28px" ToolTip="About" OnClick="imgAbout_Click" />
        </div>
    </div>

    <!-- Highlight marquee -->
    <div class="highlight">
        <marquee behavior="scroll" direction="left">
            🌟 This is Our Top Tea Patti Brand – Fresh • Strong • Trusted 🌟
        </marquee>
    </div>

    <!-- Welcome message -->
    <div class="welcome">
        Welcome, <asp:Label ID="lblUser" runat="server" Text=""></asp:Label> – Enjoy our Premium Tea Patti
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="msg" />

    <!-- Products grid with background -->
    <div class="products-container">
        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
            <ItemTemplate>
                <div class="product-card">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>'/>
                    <div class="productname"> <%# Eval("ProductName") %> </div>
                    <div class="price">₹ <%# Eval("Price") %></div>
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                        CommandArgument='<%# Eval("ProductId") %>'
                        CssClass="btn-add"
                        OnClick="btnAddToCart_Click" />
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
        <h3>B G Patel Tea Shop</h3>
        <p>Quality Tea | Trusted Brand | Since 1995</p>
        <p>© 2026 All Rights Reserved</p>
    </div>

</form>
</body>
</html>