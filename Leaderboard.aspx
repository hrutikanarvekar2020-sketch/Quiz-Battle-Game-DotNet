<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Leaderboard.aspx.cs" Inherits="QuizBattleGame.Leaderboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Quiz Battle Game - Leaderboard</title>
    <style>
        body {
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            font-family: 'Arial', sans-serif;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .leaderboard-box {
            background: #111;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 0 30px #00eaff;
            width: 400px;
            text-align: center;
        }
        h2 {
            color: #00ff99;
            text-shadow: 0 0 10px #00ff99;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background: #00eaff;
            color: #000;
            border-radius: 6px;
        }
        tr:nth-child(even) {
            background: #222;
        }
        tr:nth-child(odd) {
            background: #1a1a1a;
        }
        .btn-back {
            margin-top: 20px;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            background: #00ff99;
            color: #000;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 0 15px #00ff99;
            transition: 0.3s;
        }
        .btn-back:hover {
            background: #00cc77;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="leaderboard-box">
            <h2>🏆 Leaderboard</h2>
            <asp:GridView ID="gvLeaderboard" runat="server" AutoGenerateColumns="False" CssClass="leaderboard-table">
                <Columns>
                    <asp:BoundField HeaderText="Rank" DataField="Rank" />
                    <asp:BoundField HeaderText="User" DataField="Username" />
                    <asp:BoundField HeaderText="Score" DataField="Score" />
                    <asp:BoundField HeaderText="Date" DataField="TakenOn" DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnBack" runat="server" Text="🏠 Back to Home" CssClass="btn-back" OnClick="btnBack_Click" />
        </div>
    </form>
</body>
</html>
