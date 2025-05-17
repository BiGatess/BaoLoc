using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DoAn;

namespace DoAn
{
    public partial class DangKi : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_dangki_Click(object sender, EventArgs e)
        {
            string sql = "select * from taikhoan where tendangnhap = '" + tendangnhap.Text + "' ";
            DataTable dt = dungchung.docdulieu(sql);

            if (dt.Rows.Count > 0)
            {
                lb_thongbao.Text = "Tên Đăng Nhập Đã Tồn Tại";
            }
            else
            {
                int phanquyen = 0;
                string sqlthem = "insert into TAIKHOAN values('" + tendangnhap.Text + "', '" + matkhau.Text + "', '" + phanquyen + "') ";
                int ketqua = dungchung.updateData(sqlthem);
                if (ketqua > 0)
                {
                    Session["tendangnhap"] = tendangnhap.Text;
                    Server.Transfer("TrangChu.aspx");
                }
            }
        }
    }
}