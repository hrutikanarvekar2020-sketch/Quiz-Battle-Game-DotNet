<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Result.aspx.cs" Inherits="QuizBattleGame.Result" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Quiz Battle Game - Result</title>
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

        .result-box {
            background: #111;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 30px #00eaff;
            text-align: center;
            width: 400px;
        }

        h2 {
            color: #00ff99;
            text-shadow: 0 0 10px #00ff99;
            margin-bottom: 20px;
        }

        .score {
            font-size: 24px;
            font-weight: bold;
            color: #ffd700;
            margin: 15px 0;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            color: #000;
        }

        .btn-play {
            background: #00ff99;
            box-shadow: 0 0 15px #00ff99;
        }

        .btn-play:hover {
            background: #00cc77;
            transform: scale(1.05);
        }

        .btn-logout {
            background: #ff4d4d;
            box-shadow: 0 0 15px #ff4d4d;
        }

        .btn-logout:hover {
            background: #cc3a3a;
            transform: scale(1.05);
        }

        .btn-leaderboard {
            background: #00eaff;
            box-shadow: 0 0 15px #00eaff;
        }

        .btn-leaderboard:hover {
            background: #00aabb;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="result-box">
            <h2>🏆 GAME OVER</h2>
            <asp:Label ID="lblUser" runat="server" Text="User: "></asp:Label><br />
            <asp:Label ID="lblScore" runat="server" CssClass="score" Text="Score: 0"></asp:Label><br />

            <asp:Button ID="btnPlayAgain" runat="server" Text="🎮 PLAY AGAIN" CssClass="btn btn-play" OnClick="btnPlayAgain_Click" />
            <asp:Button ID="btnLeaderboard" runat="server" Text="🏆 LEADERBOARD" CssClass="btn btn-leaderboard" OnClick="btnLeaderboard_Click" />
            <asp:Button ID="btnLogout" runat="server" Text="📜 LOGOUT" CssClass="btn btn-logout" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>
