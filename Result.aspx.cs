using System;
using System.Data.OleDb;

namespace QuizBattleGame
{
    public partial class Result : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to login if session expired
            if (Session["User"] == null || Session["UserId"] == null)
                Response.Redirect("Login.aspx");

            // Display user and score
            lblUser.Text = "User: " + Session["User"].ToString();
            int score = Session["Score"] != null ? (int)Session["Score"] : 0;
            lblScore.Text = "Score: " + score;

            // Save score to Access database
            SaveScoreToDatabase(score);
        }

        // Method to save score into Access database
        private void SaveScoreToDatabase(int score)
        {
            try
            {
                int userId = (int)Session["UserId"]; // numeric ID from session

                using (OleDbConnection con = new OleDbConnection(AuthHelper.GetConnectionString()))
                {
                    con.Open();
                    string query = "INSERT INTO Scores (UserId, Score, TakenOn) VALUES (?, ?, ?)";
                    using (OleDbCommand cmd = new OleDbCommand(query, con))
                    {
                        cmd.Parameters.Add("?", OleDbType.Integer).Value = userId;
                        cmd.Parameters.Add("?", OleDbType.Integer).Value = score;
                        cmd.Parameters.Add("?", OleDbType.Date).Value = DateTime.Now;

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch(Exception ex)
            {
                // Optional: display error message
                lblScore.Text += " (Error saving score:" + ex.Message+")";
            }
        }

        // Play again button
        protected void btnPlayAgain_Click(object sender, EventArgs e)
        {
            Session["Score"] = 0;
            Session["QIndex"] = 0;
            Response.Redirect("Quiz.aspx");
        }

        protected void btnLeaderboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("Leaderboard.aspx");
        }


        // Logout button
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
