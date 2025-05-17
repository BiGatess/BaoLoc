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
    public partial class ThanhToan : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tendangnhap = Session["tendangnhap"] + "";
                if (string.IsNullOrEmpty(tendangnhap))
                {
                    Response.Redirect("DangNhap.aspx");
                    return;
                }

                // Kiểm tra giỏ hàng có sản phẩm không
                string sqlCheck = "SELECT COUNT(*) FROM GIOHANG WHERE tendangnhap = '" + tendangnhap + "'";
                DataTable dtCheck = dungchung.docdulieu(sqlCheck);

                if (dtCheck.Rows.Count == 0 || Convert.ToInt32(dtCheck.Rows[0][0]) == 0)
                {
                    // Nếu giỏ hàng trống, chuyển về trang chủ
                    Response.Redirect("TrangChu.aspx");
                    return;
                }

                LoadGioHang(tendangnhap);
            }
        }

        private void LoadGioHang(string tendangnhap)
        {
            string sql = @"SELECT GIOHANG.mahang, TenHang, GIOHANG.soluong, dongia, 
                          GIOHANG.soluong * dongia AS thanhtien 
                          FROM GIOHANG, MATHANG 
                          WHERE GIOHANG.mahang = MATHANG.mahang 
                          AND tendangnhap = '" + tendangnhap + "'";

            DataTable dt = dungchung.docdulieu(sql);
            rptDonHang.DataSource = dt;
            rptDonHang.DataBind();

            // Tính tổng tiền
            decimal tongTien = 0;
            foreach (DataRow row in dt.Rows)
            {
                tongTien += Convert.ToDecimal(row["thanhtien"]);
            }
            ltrTongTien.Text = tongTien.ToString("N0") + "đ";
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (string.IsNullOrEmpty(tendangnhap))
            {
                Response.Redirect("DangNhap.aspx");
                return;
            }

            // Tạo mã đơn hàng ngẫu nhiên
            string maDonHang = "DH" + DateTime.Now.ToString("yyyyMMddHHmmss");

            // Lấy thông tin giỏ hàng
            string sqlGioHang = @"SELECT GIOHANG.mahang, TenHang, GIOHANG.soluong, dongia, 
                                GIOHANG.soluong * dongia AS thanhtien 
                                FROM GIOHANG, MATHANG 
                                WHERE GIOHANG.mahang = MATHANG.mahang 
                                AND tendangnhap = '" + tendangnhap + "'";
            DataTable dtGioHang = dungchung.docdulieu(sqlGioHang);

            // Tính tổng tiền
            decimal tongTien = 0;
            foreach (DataRow row in dtGioHang.Rows)
            {
                tongTien += Convert.ToDecimal(row["thanhtien"]);
            }

            // Thêm vào bảng DonHang
            string sqlDonHang = @"INSERT INTO DonHang (MaDonHang, TenKhachHang, NgayDatHang, TongTien, 
                                DiaChiGiaoHang, TrangThai, SoDienThoai, PhuongThucThanhToan, 
                                TinhThanh, QuanHuyen, PhuongXa, GhiChu, NgayTao)
                                VALUES ('" + maDonHang + "', N'" + txtHoTen.Text + "', GETDATE(), " + tongTien +
                                ", N'" + txtDiaChi.Text + "', N'Chờ xác nhận', '" + txtSoDT.Text +
                                "', N'" + ddlPhuongThuc.SelectedItem.Text + "', N'" + ddlTinhThanh.SelectedItem.Text +
                                "', N'" + txtQuanHuyen.Text + "', N'" + txtPhuongXa.Text + "', N'" + txtGhiChu.Text +
                                "', GETDATE())";

            int result = dungchung.updateData(sqlDonHang);

            if (result > 0)
            {
                // Thêm chi tiết đơn hàng
                foreach (DataRow row in dtGioHang.Rows)
                {
                    string sqlChiTiet = @"INSERT INTO ChiTietDonHang (MaDonHang, MaSanPham, TenSanPham, 
                                         SoLuong, DonGia, ThanhTien)
                                         VALUES ('" + maDonHang + "', '" + row["mahang"] + "', N'" +
                                         row["TenHang"] + "', " + row["soluong"] + ", " + row["dongia"] +
                                         ", " + row["thanhtien"] + ")";
                    dungchung.updateData(sqlChiTiet);
                }

                // Xóa giỏ hàng sau khi đặt hàng thành công
                string sqlXoaGioHang = "DELETE FROM GIOHANG WHERE tendangnhap = '" + tendangnhap + "'";
                dungchung.updateData(sqlXoaGioHang);

                // Lưu mã đơn hàng vào session để trang xác nhận có thể đọc
                Session["MaDonHang"] = maDonHang;
                Response.Redirect("XacNhanDonHang.aspx");
            }
            else
            {
                // Hiển thị thông báo lỗi
                ScriptManager.RegisterStartupScript(this, GetType(), "showError",
                    "alert('Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.');", true);
            }
        }
    }
}