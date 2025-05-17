using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoAn
{
    public partial class NguoiDungMasterPage : System.Web.UI.MasterPage
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();

        protected void Page_Load(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "")
            {
                dangkydangnhap.Text = "Đăng Nhập";
                dangkydangnhap.Click += DangNhap_Click;
                cartCount.InnerText = "0";
            }
            else
            {
                dangkydangnhap.Text = "Đăng Xuất";
                dangkydangnhap.Click += DangXuat_Click;
                UpdateCartCount(tendangnhap);
            }
        }

        protected void UpdateCartCount(string tendangnhap)
        {
            string sql = "SELECT COUNT(*) FROM GIOHANG WHERE tendangnhap = '" + tendangnhap + "'";
            try
            {
                DataTable dt = dungchung.docdulieu(sql);
                if (dt != null && dt.Rows.Count > 0)
                {
                    int count = Convert.ToInt32(dt.Rows[0][0]);
                    cartCount.InnerText = count.ToString();
                }
                else
                {
                    cartCount.InnerText = "0";
                }
            }
            catch (Exception)
            {
                cartCount.InnerText = "0";
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

        protected void btnMuaNgay_Click(object sender, EventArgs e)
        {
            // Cần khai báo các biến này hoặc lấy từ nguồn phù hợp
            string tendangnhap = Session["tendangnhap"]?.ToString() ?? "";

            // Đây nên là kết quả thực tế từ thao tác database của bạn
            int ketqua = 0; // Cần gán giá trị này dựa trên thao tác thực tế

            // Ví dụ thao tác database (cần triển khai logic thực tế ở đây)
            // string sql = "INSERT INTO ...";
            // ketqua = dungchung.themxoasua(sql);

            if (ketqua > 0)
            {
                // Cập nhật số lượng giỏ hàng trên header
                UpdateCartCount(tendangnhap);

                // Chuyển thẳng đến trang thanh toán
                Response.Redirect("ThanhToan.aspx");
            }
        }
    }
}