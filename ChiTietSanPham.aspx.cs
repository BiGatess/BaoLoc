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
    public partial class ChiTietSanPham : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string mahang = Request.QueryString["mahang"] ?? "";
            if (string.IsNullOrEmpty(mahang))
            {
                // Xử lý khi không có mã hàng
                Response.Redirect("TrangChu.aspx");
                return;
            }
            string sql = "SELECT mathang.*, loaihang.tenloai FROM mathang INNER JOIN loaihang ON " +
                "mathang.maloai = loaihang.maloai WHERE mathang.mahang = '" + mahang + "'";
            DataTable dt = dungchung.docdulieu(sql);
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            Button btt = (Button)sender;
            DataListItem item = (DataListItem)btt.Parent;
            Label thongbao = (Label)item.FindControl("lb_thongbao");
            if (tendangnhap == "")
            {
                thongbao.Text = "<div class='alert alert-warning'>Vui lòng đăng nhập để thêm vào giỏ hàng</div>";
                return;
            }
            string mahang = btt.CommandArgument;
            TextBox txtSoluong = (TextBox)item.FindControl("txt_soluong");
            int soluong;
            // Kiểm tra định dạng số lượng
            if (!int.TryParse(txtSoluong.Text, out soluong) || soluong <= 0)
            {
                thongbao.Text = "<div class='alert alert-warning'>Số lượng không hợp lệ</div>";
                return;
            }
            string sqldem = "select * from GIOHANG where tendangnhap ='" + tendangnhap + "' and mahang='" + mahang + "'";
            DataTable dtDH = dungchung.docdulieu(sqldem);
            string sql = "";
            if (dtDH.Rows.Count > 0)
            {
                sql = "update GIOHANG set SOLUONG = SOLUONG+" + soluong + " where tendangnhap ='" + tendangnhap
                       + "' and mahang='" + mahang + "'";
            }
            else
            {
                sql = "insert into GIOHANG values('" + tendangnhap + "','" + mahang + "'," + soluong + ")";
            }
            int row = dungchung.updateData(sql);
            if (row > 0)
            {
                thongbao.Text = "<div class='alert alert-success'>Thêm vào giỏ hàng thành công</div>";
                // Tải lại trang để cập nhật số lượng giỏ hàng
                ScriptManager.RegisterStartupScript(this, this.GetType(), "redirectScript",
                    "setTimeout(function() { window.location.href = window.location.href; }, 1500);", true);
            }
            else
            {
                thongbao.Text = "<div class='alert alert-danger'>Thêm vào giỏ hàng không thành công</div>";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            Button btt = (Button)sender;
            DataListItem item = (DataListItem)btt.Parent;
            Label thongbao = (Label)item.FindControl("lb_thongbao");
            if (tendangnhap == "")
            {
                thongbao.Text = "<div class='alert alert-warning'>Vui lòng đăng nhập để mua hàng</div>";
                return;
            }
            string mahang = btt.CommandArgument;
            TextBox txtSoluong = (TextBox)item.FindControl("txt_soluong");
            int soluong;
            // Kiểm tra định dạng số lượng
            if (!int.TryParse(txtSoluong.Text, out soluong) || soluong <= 0)
            {
                thongbao.Text = "<div class='alert alert-warning'>Số lượng không hợp lệ</div>";
                return;
            }
            // 1. Xóa giỏ hàng hiện tại (nếu có)
            string sqlXoa = "DELETE FROM GIOHANG WHERE tendangnhap = '" + tendangnhap + "'";
            dungchung.updateData(sqlXoa);
            // 2. Thêm sản phẩm muốn mua vào giỏ hàng
            string sqlThem = "INSERT INTO GIOHANG VALUES('" + tendangnhap + "','" + mahang + "'," + soluong + ")";
            int ketqua = dungchung.updateData(sqlThem);
            if (ketqua > 0)
            {
                // 3. Chuyển thẳng đến trang thanh toán
                Response.Redirect("ThanhToan.aspx");
            }
            else
            {
                thongbao.Text = "<div class='alert alert-danger'>Có lỗi xảy ra khi thực hiện mua hàng</div>";
            }
        }
    }
}