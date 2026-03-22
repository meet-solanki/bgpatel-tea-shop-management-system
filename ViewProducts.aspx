<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewProducts.aspx.cs" Inherits="B_G_Patel_Tea_Shop.ViewProducts" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <title>View Tea Patti Products</title>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0fdf4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #065f46;
            margin-bottom: 20px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .grid th {
            background: #16a34a;
            color: white;
            padding: 10px;
        }

        .grid td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        .grid img {
            width: 80px;
            height: 60px;
            border-radius: 6px;
        }

        .del-btn {
            background: #dc2626;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
          body {
        font-family: 'Segoe UI', sans-serif;
        background: #f0fdf4;
        margin: 0;
        padding: 20px;
    }

    h2 {
        text-align: center;
        color: #065f46;
        margin-bottom: 20px;
    }

    .grid {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }

    .grid th {
        background: #16a34a;
        color: white;
        padding: 10px;
    }

    .grid td {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    .grid img {
        width: 80px;
        height: 60px;
        border-radius: 6px;
    }

    /* ===== BUTTON STYLES ===== */

    .btn-edit {
        background: #2563eb;
        color: white;
        padding: 6px 14px;
        border-radius: 6px;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
    }

    .btn-edit:hover {
        background: #1e40af;
        transform: scale(1.1);
    }

    .btn-delete {
        background: #dc2626;
        color: white;
        padding: 6px 14px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .btn-delete:hover {
        background: #991b1b;
        transform: scale(1.1);
    }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <h2>Tea Patti Products</h2>

    <asp:GridView ID="gvProducts" runat="server"
        CssClass="grid"
        AutoGenerateColumns="False"
        DataKeyNames="ProductId"
        OnRowDeleting="gvProducts_RowDeleting">

      <Columns>

    <asp:BoundField DataField="ProductId" HeaderText="ID" />

    <asp:ImageField DataImageUrlField="ImagePath" HeaderText="Image" />

    <asp:BoundField DataField="ProductName" HeaderText="Tea Patti Name" />

    <asp:BoundField DataField="Price" HeaderText="Price (₹)" />

    <!-- EDIT BUTTON -->
    <asp:TemplateField HeaderText="Edit">
        <ItemTemplate>
            <a class="btn-edit"
               href='EditProduct.aspx?id=<%# Eval("ProductId") %>'>
                ✏ Edit
            </a>
        </ItemTemplate>
    </asp:TemplateField>

    <!-- DELETE BUTTON -->
    <asp:TemplateField HeaderText="Delete">
        <ItemTemplate>
            <asp:Button ID="btnDelete"
                runat="server"
                Text="🗑 Delete"
                CssClass="btn-delete"
                CommandName="Delete"
                OnClientClick="return confirm('Are you sure you want to delete this product?');" />
        </ItemTemplate>
    </asp:TemplateField>

</Columns>
    </asp:GridView>

</form>
</body>
</html>
