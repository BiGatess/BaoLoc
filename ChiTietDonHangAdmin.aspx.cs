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
    public partial class ChiTietDonHangAdmin : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string maDonHang = Request.QueryString["madon"];
                if (!string.IsNullOrEmpty(maDonHang))
                {
                    LoadChiTietDonHang(maDonHang);
                }
                else
                {
                    Response.Redirect("QuanLiDonHang.aspx");
                }
            }
        }

        private void LoadChiTietDonHang(string maDonHang)
        {
            // Load thông tin đơn hàng
            string sqlDonHang = @"SELECT * FROM DonHang WHERE MaDonHang = '" + maDonHang + "'";
            DataTable dtDonHang = dungchung.docdulieu(sqlDonHang);
            
            if (dtDonHang.Rows.Count > 0)
            {
                DataRow row = dtDonHang.Rows[0];
                
                ltrMaDonHang.Text = maDonHang;
                ltrTenKH.Text = row["TenKhachHang"].ToString();
                ltrDienThoai.Text = row["SoDienThoai"].ToString();
                ltrDiaChi.Text = row["DiaChiGiaoHang"].ToString();
                ltrNgayDat.Text = Convert.ToDateTime(row["NgayDatHang"]).ToString("dd/MM/yyyy HH:mm");
                ltrPTThanhToan.Text = row["PhuongThucThanhToan"].ToString();
                ddlTrangThai.SelectedValue = row["TrangThai"].ToString();
                ltrTongCong.Text = Convert.ToDecimal(row["TongTien"]).ToString("N0") + "đ";
                
                // Load chi tiết đơn hàng
                string sqlChiTiet = @"SELECT * FROM ChiTietDonHang WHERE MaDonHang = '" + maDonHang + "'";
                DataTable dtChiTiet = dungchung.docdulieu(sqlChiTiet);
                gvChiTiet.DataSource = dtChiTiet;
                gvChiTiet.DataBind();
            }
        }

        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            string maDonHang = Request.QueryString["madon"];
            string trangThaiMoi = ddlTrangThai.SelectedValue;
            
            if (!string.IsNullOrEmpty(maDonHang))
            {
                string sql = "UPDATE DonHang SET TrangThai = N'" + trangThaiMoi + "' WHERE MaDonHang = '" + maDonHang + "'";
                int result = dungchung.updateData(sql);
                
                if (result > 0)
                {
                    // Hiển thị thông báo thành công
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess", 
                        "alert('Cập nhật trạng thái đơn hàng thành công!');", true);
                }
                else
                {
                    // Hiển thị thông báo lỗi
                    ScriptManager.RegisterStartupScript(this, GetType(), "showError", 
                        "alert('Có lỗi xảy ra khi cập nhật trạng thái!');", true);
                }
            }
        }

        protected void btnQuayLai_Click(object sender, EventArgs e)
        {
            Response.Redirect("QuanLiDonHang.aspx");
        }
    }
}