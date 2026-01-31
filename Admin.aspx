<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="QuizBattleGame.Admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Dashboard</title>

    <!-- REQUIRED meta tags for XHTML -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <!-- Cyberpunk CSS -->
    <style type="text/css">
        body {
            background: #0a0f1f;
            font-family: Arial, sans-serif;
            margin: 0;
            color: #00eaff;
        }

        .admin-box {
            width: 90%;
            max-width: 900px;
            margin: 50px auto;
            padding: 25px;
            background: rgba(0, 0, 30, 0.85);
            border: 2px solid #00eaff;
            border-radius: 15px;
            box-shadow: 0 0 30px #00eaff;
        }

        h1 {
            text-align: center;
            text-shadow: 0 0 15px #00eaff;
            font-size: 32px;
            letter-spacing: 3px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            margin-top: 15px;
            background: #00eaff;
            border: none;
            border-radius: 8px;
            color: #000;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 0 12px #00eaff;
        }

        .btn:hover {
            background: #00a7cc;
            box-shadow: 0 0 20px #00eaff;
        }

        .section {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #00eaff;
            border-radius: 10px;
            background: rgba(0, 10, 25, 0.6);
        }

        table {
            width: 100%;
            margin-top: 15px;
            border-collapse: collapse;
        }

        th {
            background: #001f33;
            color: #00eaff;
            padding: 10px;
            border: 1px solid #00eaff;
        }

        td {
            padding: 10px;
            border: 1px solid #00eaff;
            color: #bffaff;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="admin-box">

            <h1>ADMIN PANEL</h1>

            <!-- Add Questions -->
            <div class="section">
                <h3>Add New Quiz Question</h3>

                <asp:TextBox ID="txtQuestion" runat="server" Width="100%" Placeholder="Enter Questiont"></asp:TextBox><br /><br />

                <asp:TextBox ID="txtOptionA" runat="server" Width="100%" Placeholder="Option A"></asp:TextBox><br /><br />
                <asp:TextBox ID="txtOptionB" runat="server" Width="100%" Placeholder="Option B"></asp:TextBox><br /><br />
                <asp:TextBox ID="txtOptionC" runat="server" Width="100%" Placeholder="Option C"></asp:TextBox><br /><br />
                <asp:TextBox ID="txtOptionD" runat="server" Width="100%" Placeholder="Option D"></asp:TextBox><br /><br />

                <asp:TextBox ID="txtCorrect" runat="server" Width="100%" Placeholder="Correct Option (1-4)"></asp:TextBox><br /><br />
                <asp:TextBox ID="txtMarks" runat="server" Width="100%" Placeholder="Marks (ex: 1)"></asp:TextBox><br /><br />

                <asp:Button ID="btnAdd" runat="server" Text="Add Question" CssClass="btn" OnClick="btnAdd_Click" /><br />

                <asp:Label ID="lblMsg" runat="server" ForeColor="#00ffea"></asp:Label>
            </div>

            <!-- Show Questions -->
            <div class="section">
                <h3>Existing Questions</h3>

                <asp:GridView 
                    ID="GridView1" 
                    runat="server"
                    AutoGenerateColumns="True"
                    BorderColor="#00eaff"
                    HeaderStyle-BackColor="#001f33"
                    HeaderStyle-ForeColor="#00eaff"
                    RowStyle-ForeColor="#ffffff"
                    GridLines="Both">
                </asp:GridView>
            </div>

            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn" OnClick="btnLogout_Click" />

        </div>
    </form>
</body>
</html>
