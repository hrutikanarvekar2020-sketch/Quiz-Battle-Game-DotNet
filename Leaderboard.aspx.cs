using System;
using System.Data;
using System.Data.OleDb;

namespace QuizBattleGame
{
    public partial class Leaderboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLeaderboard();
            }
        }

        private void LoadLeaderboard()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Rank");
            dt.Columns.Add("Username");
            dt.Columns.Add("Score");
            dt.Columns.Add("TakenOn");

            using (OleDbConnection con = new OleDbConnection(AuthHelper.GetConnectionString()))
            {
                con.Open();
                string query = @"
            SELECT TOP 10 u.Username, s.Score, s.TakenOn
            FROM Scores AS s
            INNER JOIN Users AS u ON s.UserId = u.Id
            WHERE s.Id IN (
                SELECT TOP 1 s2.Id
                FROM Scores AS s2
                WHERE s2.UserId = s.UserId
                ORDER BY s2.Score DESC, s2.TakenOn ASC
            )
            ORDER BY s.Score DESC, s.TakenOn ASC";

                using (OleDbCommand cmd = new OleDbCommand(query, con))
                using (OleDbDataReader dr = cmd.ExecuteReader())
                {
                    int rank = 1;
                    while (dr.Read())
                    {
                        DataRow row = dt.NewRow();
                        row["Rank"] = rank++;
                        row["Username"] = dr["Username"].ToString();
                        row["Score"] = dr["Score"].ToString();
                        row["TakenOn"] = Convert.ToDateTime(dr["TakenOn"]).ToString("dd/MM/yyyy");
                        dt.Rows.Add(row);
                    }
                }
            }

            gvLeaderboard.DataSource = dt;
            gvLeaderboard.DataBind();
        }


        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
