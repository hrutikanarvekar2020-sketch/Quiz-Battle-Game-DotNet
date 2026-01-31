using System;
using System.Data;
using System.Data.OleDb;

namespace QuizBattleGame
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        OleDbConnection con = new OleDbConnection(
            @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=|DataDirectory|\QuizDB.mdb;"
        );

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            con.Open();
            OleDbCommand cmd = new OleDbCommand(
                "SELECT COUNT(*) FROM Admins WHERE Username=? AND Password=?", con);
            cmd.Parameters.AddWithValue("Username", username);
            cmd.Parameters.AddWithValue("Password", password);

            int count = (int)cmd.ExecuteScalar();
            con.Close();

            if (count > 0)
            {
                Session["Admin"] = username;
                Response.Redirect("Admin.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid admin username or password!";
            }
        }
    }
}
