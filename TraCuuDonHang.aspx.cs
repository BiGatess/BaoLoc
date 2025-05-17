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
    public partial class TraCuuDonHang : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string tendangnhap = Session["tendangnhap"] + "";
                if (!string.IsNullOrEmpty(tendangnhap))
                {
                    // Nếu đã đăng nhập, hiển thị tất cả đơn hàng của khách
                    LoadDonHangTheoTaiKhoan(tendangnhap);
                }
            }
        }

        private void LoadDonHangTheoTaiKhoan(string tendangnhap)
        {
            string sql = "SELECT MaDonHang, NgayDatHang, TongTien, TrangThai " +
              "FROM DonHang " +
              "WHERE TenKhachHang = '" + tendangnhap + "' " +
              "ORDER BY NgayDatHang DESC";


            DataTable dt = dungchung.docdulieu(sql);
            gvDonHang.DataSource = dt;
            gvDonHang.DataBind();

            pnlKetQua.Visible = true;
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            string maDonHang = txtMaDonHang.Text.Trim();
            if (!string.IsNullOrEmpty(maDonHang))
            {
                string sql = @"SELECT MaDonHang, NgayDatHang, TongTien, TrangThai 
                              FROM DonHang 
                              WHERE MaDonHang = '" + maDonHang + "'";

                DataTable dt = dungchung.docdulieu(sql);
                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();

                pnlKetQua.Visible = true;
                pnlChiTiet.Visible = false;
            }
        }

        protected void btnChiTiet_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string maDonHang = btn.CommandArgument;

            // Load thông tin đơn hàng
            string sqlDonHang = @"SELECT * FROM DonHang WHERE MaDonHang = '" + maDonHang + "'";
            DataTable dtDonHang = dungchung.docdulieu(sqlDonHang);

            if (dtDonHang.Rows.Count > 0)
            {
                DataRow row = dtDonHang.Rows[0];

                ltrMaDon.Text = maDonHang;
                ltrTenKH.Text = row["TenKhachHang"].ToString();
                ltrDienThoai.Text = row["SoDienThoai"].ToString();
                ltrDiaChi.Text = row["DiaChiGiaoHang"].ToString();
                ltrNgayDat.Text = Convert.ToDateTime(row["NgayDatHang"]).ToString("dd/MM/yyyy HH:mm");
                ltrPTThanhToan.Text = row["PhuongThucThanhToan"].ToString();
                ltrTrangThai.Text = row["TrangThai"].ToString();
                ltrTongCong.Text = Convert.ToDecimal(row["TongTien"]).ToString("N0") + "đ";

                // Load chi tiết đơn hàng
                string sqlChiTiet = @"SELECT * FROM ChiTietDonHang WHERE MaDonHang = '" + maDonHang + "'";
                DataTable dtChiTiet = dungchung.docdulieu(sqlChiTiet);
                gvChiTiet.DataSource = dtChiTiet;
                gvChiTiet.DataBind();

                pnlKetQua.Visible = false;
                pnlChiTiet.Visible = true;
            }
        }

        protected void btnQuayLai_Click(object sender, EventArgs e)
        {
            pnlKetQua.Visible = true;
            pnlChiTiet.Visible = false;
        }

        // Hàm helper để trả về class CSS cho trạng thái
        public string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "chờ xác nhận":
                    return "status-pending";
                case "đang giao hàng":
                    return "status-shipping";
                case "đã giao":
                    return "status-completed";
                case "đã hủy":
                    return "status-cancelled";
                default:
                    return "";
            }
        }
    }
}