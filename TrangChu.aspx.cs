using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DoAn;

namespace DoAn
{
    public partial class TrangChu : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string sql = "Select * from LOAIHANG";
            dl_danhmuc.DataSource = dungchung.docdulieu(sql);
            dl_danhmuc.DataBind();

            string sql2 = "Select * from MATHANG";
            ds_mathang.DataSource = dungchung.docdulieu(sql2);
            ds_mathang.DataBind();
        }
        protected void lbt_loaihang_Click(object sender, EventArgs e)
        {
            string maloai = ((LinkButton)sender).CommandArgument;
            string sql = "Select * from MATHANG where maloai = '" + maloai + "' ";
            ds_mathang.DataSource = dungchung.docdulieu(sql);
            ds_mathang.DataBind();
        }

        protected void lbt_mathang_Click1(object sender, EventArgs e)
        {
            string mahang = ((LinkButton)sender).CommandArgument;
            Context.Items["mahang"] = mahang;
            Server.Transfer("ChiTietSanPham.aspx");
        }
    }
}