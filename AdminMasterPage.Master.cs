using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAn
{
    public partial class AdminMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";

            if (tendangnhap == "")
            {
                dangkydangnhap.Text = "Đăng Nhập";
                dangkydangnhap.Click += DangNhap_Click;
            }
            else
            {
                dangkydangnhap.Text = "Đăng Xuất";
                dangkydangnhap.Click += DangXuat_Click;
            }

        }
        protected void DangNhap_Click(object sender, EventArgs e)
        {
            Response.Redirect("DangNhap.aspx");
        }

        protected void DangXuat_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("TrangChu.aspx");
        }
    }
}