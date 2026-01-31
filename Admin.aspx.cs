using System;
using System.Data;
using System.Data.OleDb;

namespace QuizBattleGame
{
    public partial class Admin : System.Web.UI.Page
    {
        OleDbConnection con = new OleDbConnection(
            @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=|DataDirectory|\QuizDB.mdb;"
        );

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                LoadQuestions();
            }
        }


        void LoadQuestions()
        {
            OleDbDataAdapter da = new OleDbDataAdapter("SELECT * FROM Questions", con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtQuestion.Text == "" || txtCorrect.Text == "")
            {
                lblMsg.Text = "Fill all fields!";
                return;
            }

            con.Open();
            OleDbCommand cmd = new OleDbCommand(
                "INSERT INTO Questions (QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption, Marks) " +
                "VALUES (?,?,?,?,?,?,?)", con);

            cmd.Parameters.AddWithValue("@q", txtQuestion.Text);
            cmd.Parameters.AddWithValue("@a", txtOptionA.Text);
            cmd.Parameters.AddWithValue("@b", txtOptionB.Text);
            cmd.Parameters.AddWithValue("@c", txtOptionC.Text);
            cmd.Parameters.AddWithValue("@d", txtOptionD.Text);
            cmd.Parameters.AddWithValue("@correct", txtCorrect.Text);
            cmd.Parameters.AddWithValue("@marks", Convert.ToInt32(txtMarks.Text));

            cmd.ExecuteNonQuery();
            con.Close();

            lblMsg.Text = "Question Added!";
            LoadQuestions();

            txtQuestion.Text = "";
            txtOptionA.Text = "";
            txtOptionB.Text = "";
            txtOptionC.Text = "";
            txtOptionD.Text = "";
            txtCorrect.Text = "";
            txtMarks.Text = "";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

    }
}
