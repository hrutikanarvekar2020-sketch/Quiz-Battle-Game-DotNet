using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Web.UI.WebControls;

namespace QuizBattleGame
{
    public partial class Quiz : System.Web.UI.Page
    {
        private List<int> questionIds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                Session["Score"] = 0;
                LoadQuestionIds();
                LoadNextQuestion();
            }
        }

        // LOAD QUESTION IDS
        private void LoadQuestionIds()
        {
            questionIds = new List<int>();

            using (OleDbConnection con =
                new OleDbConnection(AuthHelper.GetConnectionString()))
            {
                con.Open();

                // RANDOM 10 QUESTIONS
                OleDbCommand cmd = new OleDbCommand(
                    "SELECT TOP 10 Id FROM Questions ORDER BY RND(Id)", con);

                OleDbDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    questionIds.Add(dr.GetInt32(0));
                }
            }

            Session["QuestionIds"] = questionIds;
            Session["QIndex"] = 0;
        }


        // LOAD QUESTION
        private void LoadNextQuestion()
        {
            questionIds = (List<int>)Session["QuestionIds"];
            int index = (int)Session["QIndex"];

            if (index >= questionIds.Count)
            {
                Response.Redirect("Result.aspx");
                return;
            }

            int qid = questionIds[index];

            using (OleDbConnection con =
                new OleDbConnection(AuthHelper.GetConnectionString()))
            {
                con.Open();
                OleDbCommand cmd =
                    new OleDbCommand("SELECT * FROM Questions WHERE Id=?", con);
                cmd.Parameters.AddWithValue("?", qid);

                OleDbDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblQuestion.Text = dr["QuestionText"].ToString();
                    rblOptions.Items.Clear();

                    rblOptions.Items.Add(new ListItem(dr["OptionA"].ToString(), "A"));
                    rblOptions.Items.Add(new ListItem(dr["OptionB"].ToString(), "B"));
                    rblOptions.Items.Add(new ListItem(dr["OptionC"].ToString(), "C"));
                    rblOptions.Items.Add(new ListItem(dr["OptionD"].ToString(), "D"));

                    rblOptions.ClearSelection();
                    Session["CorrectOption"] = dr["CorrectOption"].ToString();
                }
            }
        }

        // NEXT BUTTON / AUTO NEXT
        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (rblOptions.SelectedItem != null)
            {
                string selected = rblOptions.SelectedValue;
                string correct = Session["CorrectOption"].ToString();

                if (selected == correct)
                {
                    Session["Score"] = (int)Session["Score"] + 1;
                }
            }

            Session["QIndex"] = (int)Session["QIndex"] + 1;
            LoadNextQuestion();
        }
    }
}
