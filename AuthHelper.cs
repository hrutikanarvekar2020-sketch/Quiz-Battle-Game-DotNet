using System;
using System.Data;
using System.Data.OleDb;
using System.Security.Cryptography;
using System.Text;

namespace QuizBattleGame
{
    public static class AuthHelper
    {
        // Connection String
        public static string GetConnectionString()
        {
            return @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=|DataDirectory|\QuizDB.mdb";
        }

        // Hash function
        private static string Hash(string input)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] hash = sha.ComputeHash(Encoding.UTF8.GetBytes(input));
                return Convert.ToBase64String(hash);
            }
        }

        private static string CreateSalt()
        {
            return Guid.NewGuid().ToString("N");
        }

        // REGISTER USER
        public static bool RegisterUser(string username, string email, string password)
        {
            using (OleDbConnection con = new OleDbConnection(GetConnectionString()))
            {
                con.Open();

                // CHECK EXISTING USERNAME
                using (OleDbCommand checkCmd = new OleDbCommand(
                    "SELECT COUNT(*) FROM Users WHERE Username = ?", con))
                {
                    checkCmd.Parameters.AddWithValue("?", username);

                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                        return false; // username exists
                }

                // CREATE SALT & HASH
                string salt = CreateSalt();
                string hashed = Hash(password + salt);

                // INSERT USER
                using (OleDbCommand cmd = new OleDbCommand(
                    "INSERT INTO Users (Username, Email, PasswordHash, Salt, Role, CreatedAt) VALUES (?, ?, ?, ?, ?, ?)",
                    con))
                {
                    cmd.Parameters.AddWithValue("?", username);
                    cmd.Parameters.AddWithValue("?", email);
                    cmd.Parameters.AddWithValue("?", hashed);
                    cmd.Parameters.AddWithValue("?", salt);
                    cmd.Parameters.AddWithValue("?", "User");
                    cmd.Parameters.Add("?", OleDbType.Date).Value = DateTime.Now;


                    cmd.ExecuteNonQuery();
                }
            }

            return true;
        }

        // LOGIN USER
        public static bool ValidateUser(string username, string password)
        {
            using (OleDbConnection con = new OleDbConnection(GetConnectionString()))
            {
                con.Open();

                using (OleDbCommand cmd = new OleDbCommand(
                    "SELECT PasswordHash, Salt FROM Users WHERE Username = ?", con))
                {
                    cmd.Parameters.AddWithValue("?", username);

                    using (OleDbDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            string storedHash = dr.GetString(0);
                            string storedSalt = dr.GetString(1);

                            string inputHash = Hash(password + storedSalt);

                            return storedHash == inputHash;
                        }
                    }
                }
            }

            return false;
        }
        // LOGIN USER AND RETURN UserId
        public static int ValidateUserAndGetId(string username, string password)
        {
            using (OleDbConnection con = new OleDbConnection(GetConnectionString()))
            {
                con.Open();

                using (OleDbCommand cmd = new OleDbCommand(
                    "SELECT Id, PasswordHash, Salt FROM Users WHERE Username = ?", con))
                {
                    cmd.Parameters.AddWithValue("?", username);

                    using (OleDbDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            int userId = dr.GetInt32(0);
                            string storedHash = dr.GetString(1);
                            string storedSalt = dr.GetString(2);

                            string inputHash = Hash(password + storedSalt);

                            if (storedHash == inputHash)
                                return userId; // return numeric UserId
                        }
                    }
                }
            }

            return 0; // invalid login
        }

    }
}
