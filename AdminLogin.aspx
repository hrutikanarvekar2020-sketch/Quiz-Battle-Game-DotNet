<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="QuizBattleGame.AdminLogin" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Admin Login</title>
    <style>
        body { background:#0f0f0f; font-family:Arial; display:flex; justify-content:center; align-items:center; height:100vh; color:white; }
        .box { background:#1a1a1a; width:350px; padding:30px; border-radius:12px; box-shadow:0 0 25px #00eaff; text-align:center; }
        .box h2 { margin-bottom:25px; color:#00eaff; text-shadow:0 0 10px #00eaff; }
        input { width:100%; padding:12px; margin:5px 0; border-radius:8px; border:none; background:#262626; color:white; }
        .btn { width:100%; padding:12px; background:#00eaff; border:none; border-radius:8px; color:#000; font-weight:bold; cursor:pointer; box-shadow:0 0 10px #00eaff; }
        .btn:hover { background:#00aabb; transform:scale(1.05); }
        .toggle-icon { position:absolute; right:10px; top:12px; cursor:pointer; color:#00eaff; }
        .pwd-box { position:relative; }
    </style>

    <script>
        function togglePassword() {
            var pwd = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('iconPwd');
            if (pwd.type === "password") { pwd.type = "text"; icon.innerHTML = "🙈"; }
            else { pwd.type = "password"; icon.innerHTML = "👁️"; }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="box">
            <h2>ADMIN LOGIN</h2>
            <asp:TextBox ID="txtUsername" runat="server" Placeholder="Username"></asp:TextBox><br />

            <div class="pwd-box">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Password"></asp:TextBox>
                <span id="iconPwd" class="toggle-icon" onclick="togglePassword()">👁️</span>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" /><br /><br />
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
