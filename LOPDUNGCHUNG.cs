using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace DoAn
{
    public class LOPDUNGCHUNG : System.Web.UI.Page
    {
        SqlConnection conn;
        private void layketnoi()
        {
            string sqlcon = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=" + Server.MapPath("/App_Data/LAPTOPDANADB.mdf") + ";Integrated Security=True";
            conn = new SqlConnection(sqlcon);
            conn.Open();
        }
        private void dongketnoi()
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
            }
        }
        public DataTable docdulieu(string sql)
        {
            DataTable dt = new DataTable();
            try
            {
                layketnoi();
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.Fill(dt);
            }
            catch
            {
                dt = null;
                Response.Write("Lỗi");
            }
            finally
            {
                dongketnoi();
            }
            return dt;
        }
        public int updateData(string sql)
        {
            int row = 0;
            try
            {

                layketnoi();
                SqlCommand cmd = new SqlCommand(sql, conn);
                row = cmd.ExecuteNonQuery();
            }
            catch
            {

            }
            finally
            {
                dongketnoi();
            }
            return row;
        }

        internal object getData(string sql)
        {
            throw new NotImplementedException();
        }
    }
}