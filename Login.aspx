<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication8.Login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <%--<title>Smart Order - Login</title>--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #71b7e6, #9b59b6); height: 100vh; display: flex; align-items: center; justify-content: center; font-family: 'Segoe UI', sans-serif; }
        .login-card { border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); background: white; width: 400px; padding: 40px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card text-center">
            <h2 class="fw-bold text-primary mb-4">🔐 Smart Order</h2>
            <div class="mb-3 text-start">
                <label class="form-label fw-semibold">Username:</label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="admin"></asp:TextBox>
            </div>
            <div class="mb-4 text-start">
                <label class="form-label fw-semibold">Password:</label>
                <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
            </div>
            <div class="d-grid">
                <asp:Button ID="btnLogin" runat="server" Text="Login to System" CssClass="btn btn-primary py-2 fw-bold" OnClick="btnLogin_Click" />
            </div>
            <div class="mt-3">
                <asp:Label ID="lblError" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>