<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="B_G_Patel_Tea_Shop.EditProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    
 <title>Edit Product</title>

    <style>
        /* Full page background image */
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-image: url('Images/BG Image 2.jpeg'); /* Set your background image path */
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
            background: rgba(0,0,0,0.3);
            z-index: 1;
        }

        form {
            position: relative;
            z-index: 2; /* content above overlay */
        }

        .box {
            width: 420px;
            margin: 60px auto;
            background: rgba(255,255,255,0.95); /* slightly transparent white */
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            text-align: center;
            color: #065f46;
        }

        label {
            font-weight: bold;
            color: #065f46;
        }

        input[type=text] {
            width: 100%;
            padding: 8px;
            margin: 6px 0 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .img-box {
            text-align: center;
            margin-bottom: 10px;
        }

        .img-box img {
            width: 120px;
            height: 90px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .btn-update {
            width: 100%;
            padding: 10px;
            background: #16a34a;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-update:hover {
            background: #15803d;
            transform: scale(1.05);
        }

        .msg {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>

<body>
<form runat="server">
    <div class="box">

        <h2>Edit Tea Patti</h2>

        <label>Product Name</label>
        <asp:TextBox ID="txtName" runat="server" />

        <label>Price (₹)</label>
        <asp:TextBox ID="txtPrice" runat="server" />

        <div class="img-box">
            <asp:Image ID="imgProduct" runat="server" />
        </div>

        <label>Change Image (Optional)</label>
        <asp:FileUpload ID="fuImage" runat="server" />

        <asp:Button ID="btnUpdate" runat="server"
            Text="Update Product"
            CssClass="btn-update"
            OnClick="btnUpdate_Click" />

        <asp:Label ID="lblMsg" runat="server" CssClass="msg" />

    </div>
</form>
</body>
</html>