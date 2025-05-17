using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAn
{
    public partial class XacNhanDonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maDonHang = Session["MaDonHang"] as string;
                if (!string.IsNullOrEmpty(maDonHang))
                {
                    ltrMaDonHang.Text = maDonHang;
                }
                else
                {
                    Response.Redirect("TrangChu.aspx");
                }
            }
        }

        protected void btnTiepTuc_Click(object sender, EventArgs e)
        {
            Response.Redirect("TrangChu.aspx");
        }
    }
}