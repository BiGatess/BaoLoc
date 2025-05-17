using DoAn;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAn
{
    public partial class DangNhap : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_dangnhap_Click(object sender, EventArgs e)
        {
            string sql = "select * from taikhoan where tendangnhap = '" + tendangnhap.Text + "' and matkhau = '" + matkhau.Text + "'";
            DataTable dt = dungchung.docdulieu(sql);

            if (dt.Rows.Count > 0)
            {
                Session["tendangnhap"] = tendangnhap.Text;
                int phanquyen = dt.Rows[0].Field<int>("phanquyen");
                if (phanquyen == 1)
                {
                    Server.Transfer("TrangChuAdmin.aspx");
                }
                else
                {
                    Server.Transfer("TrangChu.aspx");
                }
            }
            else
            {
                lb_thongbao.Text = "Tên Đăng Nhập Hoặc Mật Khẩu Không Đúng";
            }
        }
    }
}