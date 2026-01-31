<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="QuizBattleGame.Quiz" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Quiz Battle Game</title>

    <style>
        body {
            background: radial-gradient(circle, #001f2f, #000);
            font-family: Arial;
            color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .quiz-box {
            background: #111;
            width: 520px;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 25px #00eaff;
        }

        .title {
            text-align: center;
            font-size: 28px;
            color: #00eaff;
            text-shadow: 0 0 15px #00eaff;
            margin-bottom: 15px;
        }

        .timer {
            text-align: center;
            font-size: 20px;
            color: #00ffcc;
            margin-bottom: 15px;
            text-shadow: 0 0 10px #00ffcc;
        }

        .question {
            font-size: 18px;
            margin-bottom: 15px;
        }

        .options label {
            display: block;
            padding: 10px;
            margin-bottom: 10px;
            background: #222;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        .options label:hover {
            background: #00eaff;
            color: black;
        }

        .btn {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: none;
            background: #00eaff;
            font-size: 18px;
            cursor: pointer;
            font-weight: bold;
            box-shadow: 0 0 15px #00eaff;
        }

        .btn:hover {
            background: #00bcd4;
        }

        .msg {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>

    <!-- TIMER SCRIPT -->
    <script>
        let timeLeft = 30;
        let timer;

        function startTimer() {
            clearInterval(timer);
            timeLeft = 30;
            document.getElementById("time").innerText = timeLeft;

            timer = setInterval(function () {
                timeLeft--;
                document.getElementById("time").innerText = timeLeft;

                if (timeLeft <= 0) {
                    clearInterval(timer);
                    document.getElementById("<%= btnAutoNext.ClientID %>").click();
                }
            }, 1000);
        }

        window.onload = startTimer;
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="quiz-box">

            <div class="title">🎮 QUIZ BATTLE GAME</div>

            <div class="timer">
                ⏱️ Time Left: <span id="time">30</span> seconds
            </div>

            <div class="question">
                <asp:Label ID="lblQuestion" runat="server"></asp:Label>
            </div>

            <div class="options">
                <asp:RadioButtonList ID="rblOptions" runat="server"></asp:RadioButtonList>
            </div>

            <asp:Button ID="btnNext" runat="server"
                Text="Next ➡️"
                CssClass="btn"
                OnClick="btnNext_Click" />

            <!-- HIDDEN AUTO NEXT BUTTON -->
            <asp:Button ID="btnAutoNext" runat="server"
                OnClick="btnNext_Click"
                Style="display:none;" />

            <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>

        </div>
    </form>
</body>
</html>
