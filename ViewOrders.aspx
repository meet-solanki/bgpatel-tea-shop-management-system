<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewOrders.aspx.cs" Inherits="B_G_Patel_Tea_Shop.ViewOrders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  
    <title>My Orders - B G Patel Tea Shop</title>
    <style>
        body { font-family: Segoe UI, sans-serif; padding:20px; background:#f5f5f5; }
        h2 { text-align:center; color:#166534; }
        table { width:100%; border-collapse: collapse; margin-top:20px; }
        th, td { padding:12px; border-bottom:1px solid #ccc; text-align:center; }
        th { background:#dcfce7; color:#065f46; }
        img.product-img { width:80px; height:80px; border-radius:10px; object-fit:cover; }
    </style>
</head>
<body>
    <h2>My Orders</h2>

    <asp:Repeater ID="rptOrders" runat="server">
        <HeaderTemplate>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th>Order Date</th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Eval("OrderId") %></td>
                <td>
                    <img class="product-img" src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' /><br/>
                    <%# Eval("ProductName") %>
                </td>
                <td><%# Eval("Quantity") %></td>
                <td>₹ <%# Eval("Price") %></td>
                <td>₹ <%# Eval("TotalPrice") %></td>
                <td><%# Eval("OrderDate", "{0:dd/MM/yyyy HH:mm}") %></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
</body>
</html>