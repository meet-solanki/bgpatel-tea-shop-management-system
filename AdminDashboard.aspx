<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="B_G_Patel_Tea_Shop.AdminDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

      <title>Admin Dashboard - B G Patel Tea Shop</title>
    <style>
        /* Full page tea background */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background-image: url('../Images/BG Image.jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        /* Glass container for dashboard */
        .dashboard-container {
            max-width: 1200px;
            margin: 20px auto;
            background: rgba(255,255,255,0.9);
            border-radius: 20px;
            padding: 20px 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }

        /* Header */
        .header {
            background: #166534;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-radius: 15px;
        }
        .header h2 { margin: 0; }
        .menu img { width: 30px; height: 30px; cursor: pointer; }

        /* Dashboard buttons */
        .dashboard-buttons {
            display: flex;
            gap: 20px;
            margin: 30px 0;
        }
        .panel {
            background: white;
            flex: 1;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .panel:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .panel h3 { color: #166534; margin-bottom: 15px; }
        .panel button {
            padding: 10px 20px;
            background: #16a34a;
            color: white;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }
        .panel button:hover {
            background: #15803d;
            transform: scale(1.05);
        }

        /* Content panel */
        .content {
            margin: 20px 0;
        }

        /* Tables */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ccc;
            text-align: center;
        }
        th {
            background: #dcfce7;
            color: #065f46;
        }
        img.product-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }

        /* Form styles */
        .form-group { margin: 10px 0; text-align: left; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; color: #065f46; }
        .form-group input { width: 100%; padding: 6px 10px; border-radius: 6px; border: 1px solid #ccc; }

        .btn-submit { background: #16a34a; color: white; border: none; padding: 8px 20px; border-radius: 12px; cursor: pointer; margin-top: 10px; }

        /* Edit & Delete buttons */
        .btn-edit {
            background: #2563eb;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-edit:hover {
            background: #1e40af;
            transform: scale(1.05);
        }

        .btn-delete {
            background: #dc2626;
            color: white;
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }
        .btn-delete:hover {
            background: #991b1b;
            transform: scale(1.05);
        }

        .msg { margin-top: 10px; font-weight: bold; }
    </style>
</head>

<body>
    <form runat="server">
        <div class="dashboard-container">

            <!-- Header -->
            <div class="header">
                <h2>Admin Dashboard - B G Patel Tea Shop</h2>
                <div class="menu">
                    <asp:ImageButton ID="btnHome" runat="server" ImageUrl="Images/Home.png" Width="28px" Height="28px" PostBackUrl="PublicHome.aspx" ToolTip="Home" OnClick="btnHome_Click" />
                    <asp:ImageButton ID="btnLogout" runat="server" ImageUrl="Images/logout.png" Width="28px" Height="28px" OnClick="btnLogout_Click" ToolTip="Logout" />
                </div>
            </div>

            <!-- Dashboard Buttons -->
            <div class="dashboard-buttons">
                   <div class="panel">
                    <h3>Add Products</h3>
                    <asp:Button ID="btnAddProducts" runat="server" Text="Add Products" OnClick="btnAddProducts_Click" />
                </div>
               <asp:Panel ID="pnlAddProduct" runat="server" Visible="false">

    <div class="form-group">
        <label>Product Name</label>
        <asp:TextBox ID="txtName" runat="server" />
    </div>

    <div class="form-group">
        <label>Price</label>
        <asp:TextBox ID="txtPrice" runat="server" />
    </div>

    <div class="form-group">
        <label>Product Image</label>
        <asp:FileUpload ID="fuImg" runat="server" />
    </div>

    <asp:Button ID="btnSubmit" runat="server"
        Text="Add Product"
        CssClass="btn-submit"
        OnClick="btnSubmit_Click" />

    <br />
    <asp:Label ID="lblMsg" runat="server" CssClass="msg" />

</asp:Panel>
                <div class="panel">
                    <h3>View Products</h3>
                    <asp:Button ID="btnViewProducts" runat="server" Text="View Products" OnClick="btnViewProducts_Click" />
                </div>
                <div class="panel">
                    <h3>View Orders</h3>
                    <asp:Button ID="btnViewOrders" runat="server" Text="View Orders" OnClick="btnViewOrders_Click" />
                </div>
            </div>

            <!-- Dynamic Content -->
            <div class="content">
                <asp:Panel ID="pnlContent" runat="server"></asp:Panel>
            </div>

        </div>
    </form>
</body>
</html>