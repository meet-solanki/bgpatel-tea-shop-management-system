<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintBill.aspx.cs" Inherits="B_G_Patel_Tea_Shop.PrintBill" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

     <title>Print Bill - B G Patel Tea Shop</title>
       
    <style>
        body {
            font-family:'Segoe UI';
            margin:0; padding:0;
            min-height:100vh;
            background-image:url('Images/BG Image.jpeg');
            background-size:cover;
            background-position:center;
        }
        .overlay { position:absolute; top:0; left:0; right:0; bottom:0; background: rgba(0,0,0,0.35); z-index:1;}
        form { position:relative; z-index:2; padding:20px; }
        .bill-container {
            max-width:700px;
            margin:30px auto;
            background:rgba(255,255,255,0.95);
            border-radius:15px;
            padding:25px;
            box-shadow:0 10px 25px rgba(0,0,0,0.3);
        }
        h2 { text-align:center; color:#065f46; margin-bottom:20px; }
        table { width:100%; border-collapse:collapse; margin-bottom:15px;}
        th, td { border:1px solid #ccc; padding:10px; text-align:center;}
        th { background:#16a34a; color:white; }
        .total { text-align:right; font-weight:bold; margin-top:10px; }
        .btn { padding:10px 20px; border:none; border-radius:25px; background:#16a34a; color:white; cursor:pointer; transition:0.3s;}
        .btn:hover { background:#15803d; transform:translateY(-2px);}
    </style>
</head>
<body>
<div class="overlay"></div>
<form runat="server">
    <div class="bill-container">
        <h2>B G Patel Tea Shop - Bill</h2>
        <asp:Label ID="lblOrderInfo" runat="server" Text=""></asp:Label>
        <asp:Repeater ID="rptBill" runat="server" OnItemCommand="rptBill_ItemCommand">
            <HeaderTemplate>
                <table>
                    <tr>
                        <th>Product</th>
                        <th>Image</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Total</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("ProductName") %></td>
                    <td><img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' width="80" height="60" /></td>
                    <td>₹ <%# Eval("Price") %></td>
                    <td><%# Eval("Quantity") %></td>
                    <td>₹ <%# Eval("TotalPrice") %></td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
                <div class="total">Grand Total: ₹ <asp:Label ID="lblGrandTotal" runat="server"></asp:Label></div>
                <div style="text-align:center;margin-top:15px;">
                    <asp:Button ID="btnPrint" runat="server" Text="Print Bill / Save PDF" OnClientClick="window.print(); return false;" CssClass="btn"/>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </div>
</form>
</body>
</html>