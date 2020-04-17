<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="advanced.aspx.cs" Inherits="aspapp.advanced" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="css/bootstrap.css" />

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <div>
            <asp:Label ID="Label1" runat="server" Text="Query area"></asp:Label>
        </div>
        <asp:TextBox ID="query" runat="server" Height="133px" Width="1000px"></asp:TextBox>
        <asp:Button ID="btnquery" runat="server" Height="136px" OnClick="btnquery_Click" style="margin-top: 0px" Text="Button" Width="85px" />
        <p>
            <asp:Label ID="l1" runat="server" Text="result"></asp:Label>
            :<asp:GridView ID="GridView1" runat="server" Width="505px">
            </asp:GridView>
        </p>
        <asp:TextBox ID="result" runat="server" Height="90px" ReadOnly="True" Width="992px"></asp:TextBox>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Upload area"></asp:Label>
        </p>
        <p>
            <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True" />
            <asp:Button ID="btnupload" runat="server" OnClick="btnupload_Click" Text="UpLoad" />
        </p>
        <asp:Label ID="lableupload" runat="server"></asp:Label>
        <p>
            <asp:Label ID="Label3" runat="server" Text="UnZip area"></asp:Label>
        </p>
        <asp:Label ID="filename" runat="server" Text="File Name"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="btnunzip" runat="server" OnClick="btnunzip_Click" Text="UnZip" />
        <p>
            <asp:Label ID="labelunzip" runat="server"></asp:Label>
        </p>
        <div id="dd" runat="server" >

        </div>
    </form>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
