<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="B_G_Patel_Tea_Shop.cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Cart - B G Patel Tea Shop</title>
      <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin:0;
            padding:0;
            min-height:100vh;
            background-image:url('Images/BG Image.jpeg');
            background-size:cover;
            background-position:center;
        }
        .overlay {
            position:absolute;
            top:0; left:0; right:0; bottom:0;
            background: rgba(0,0,0,0.35);
            z-index:1;
        }
        form {
            position:relative;
            z-index:2;
            padding:20px;
        }
        h2 {
            color:white;
            text-align:center;
            margin-bottom:20px;
        }
        .cart-container {
            max-width:900px;
            margin:0 auto;
            background:rgba(255,255,255,0.95);
            border-radius:15px;
            padding:20px;
            box-shadow:0 10px 25px rgba(0,0,0,0.3);
            animation:fadeIn 0.7s ease;
        }
        @keyframes fadeIn { from {opacity:0; transform:translateY(30px);} to {opacity:1; transform:translateY(0);} }
        .cart-item {
            display:flex;
            align-items:center;
            margin-bottom:15px;
            padding:10px;
            border-bottom:1px solid #ccc;
        }
        .cart-item img {
            width:100px;
            height:80px;
            border-radius:10px;
            object-fit:cover;
            margin-right:15px;
        }
        .cart-item div {
            flex:1;
        }
        input[type=number] {
            width:60px;
            padding:5px;
        }
        .btn {
            padding:8px 20px;
            border:none;
            border-radius:25px;
            background:#16a34a;
            color:white;
            cursor:pointer;
            margin-left:5px;
            transition:0.3s;
        }
        .btn:hover {
            background:#15803d;
        }
        .total {
            text-align:right;
            font-weight:bold;
            margin-top:15px;
        }
        .msg { text-align:center; font-weight:bold; color:red; margin:10px 0; }
        .checkout-container {
            text-align:center;
            margin-top:20px;
        }
    </style>
</head>
<body>
<div class="overlay"></div>
<form runat="server">
    <h2>Your Cart</h2>
    <div class="cart-container">
        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand2">
            <ItemTemplate>
                <div class="cart-item">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' />
                    <div>
                        <strong><%# Eval("ProductName") %></strong><br />
                        ₹ <%# Eval("Price") %> x 
                        <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Quantity") %>' Width="40px"></asp:TextBox>
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandArgument='<%# Eval("CartId") %>' OnClick="btnUpdate_Click" CssClass="btn"/>
                        <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandArgument='<%# Eval("CartId") %>' OnClick="btnRemove_Click" CssClass="btn"/>
                        <div>Total: ₹ <%# Eval("TotalPrice") %></div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <div class="total">
            Grand Total: ₹ <asp:Label ID="lblTotal" runat="server"></asp:Label>
        </div>

        <div class="checkout-container">
            <asp:Button ID="btnCheckout" runat="server" Text="Checkout & Print Bill" CssClass="btn" OnClick="btnCheckout_Click" />
        </div>

        <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
    </div>
</form>
</body>
</html>