using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using DoAn;

namespace DoAn
{
    public partial class QuanLiDonHang : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();
        private string currentMaDon = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Kiểm tra quyền admin
                if (!IsAdmin())
                {
                    Response.Redirect("TrangChu.aspx");
                    return;
                }

                LoadDonHang();
            }
        }

        private bool IsAdmin()
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (string.IsNullOrEmpty(tendangnhap)) return false;

            string sql = "SELECT phanquyen FROM TAIKHOAN WHERE tendangnhap = '" + tendangnhap + "'";
            DataTable dt = dungchung.docdulieu(sql);
            return dt.Rows.Count > 0 && Convert.ToInt32(dt.Rows[0]["phanquyen"]) == 1;
        }

        private void LoadDonHang()
        {
            string sql = BuildQueryString();
            DataTable dt = dungchung.docdulieu(sql);

            gvDonHang.DataSource = dt;
            gvDonHang.DataBind();

            lblTotalOrders.Text = dt.Rows.Count.ToString();
        }

        private string BuildQueryString()
        {
            string sql = @"SELECT MaDonHang, TenKhachHang, NgayDatHang, TongTien, TrangThai 
                          FROM DonHang WHERE 1=1";

            // Lọc theo mã đơn hàng
            if (!string.IsNullOrEmpty(txtMaDon.Text.Trim()))
            {
                sql += " AND MaDonHang LIKE '%" + txtMaDon.Text.Trim() + "%'";
            }

            // Lọc theo trạng thái
            if (!string.IsNullOrEmpty(ddlTrangThai.SelectedValue))
            {
                sql += " AND TrangThai = N'" + ddlTrangThai.SelectedValue + "'";
            }

            // Lọc theo ngày
            if (!string.IsNullOrEmpty(txtTuNgay.Text))
            {
                sql += " AND CONVERT(date, NgayDatHang) >= '" + txtTuNgay.Text + "'";
            }

            if (!string.IsNullOrEmpty(txtDenNgay.Text))
            {
                sql += " AND CONVERT(date, NgayDatHang) <= '" + txtDenNgay.Text + "'";
            }

            sql += " ORDER BY NgayDatHang DESC";
            return sql;
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            LoadDonHang();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtMaDon.Text = "";
            ddlTrangThai.SelectedIndex = 0;
            txtTuNgay.Text = "";
            txtDenNgay.Text = "";
            LoadDonHang();
        }

        protected void gvDonHang_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDonHang.PageIndex = e.NewPageIndex;
            LoadDonHang();
        }

        protected void btnChiTiet_Click(object sender, EventArgs e)
        {
            string maDonHang = ((Button)sender).CommandArgument;
            Response.Redirect("ChiTietDonHangAdmin.aspx?madon=" + maDonHang);
        }

        protected void btnCapNhat_Click(object sender, EventArgs e)
        {
            string maDonHang = ((Button)sender).CommandArgument;
            currentMaDon = maDonHang;

            // Lấy trạng thái hiện tại
            string sql = "SELECT TrangThai FROM DonHang WHERE MaDonHang = '" + maDonHang + "'";
            DataTable dt = dungchung.docdulieu(sql);

            if (dt.Rows.Count > 0)
            {
                string trangThai = dt.Rows[0]["TrangThai"].ToString();
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal",
                    $"showUpdateModal('{maDonHang}', '{trangThai}');", true);
            }
        }

        protected void btnSaveStatus_Click(object sender, EventArgs e)
        {
            string trangThaiMoi = ddlModalTrangThai.SelectedValue;

            if (!string.IsNullOrEmpty(currentMaDon))
            {
                string sql = "UPDATE DonHang SET TrangThai = N'" + trangThaiMoi + "' WHERE MaDonHang = '" + currentMaDon + "'";
                int result = dungchung.updateData(sql);

                if (result > 0)
                {
                    // Đóng modal và tải lại dữ liệu
                    ScriptManager.RegisterStartupScript(this, GetType(), "hideModal",
                        "$('#updateStatusModal').modal('hide');", true);
                    LoadDonHang();

                    // Hiển thị thông báo thành công
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess",
                        "alert('Cập nhật trạng thái đơn hàng thành công!');", true);
                }
            }
        }

        protected void btnHuyDon_Click(object sender, EventArgs e)
        {
            string maDonHang = ((Button)sender).CommandArgument;

            // Cập nhật trạng thái thành "Đã hủy"
            string sql = "UPDATE DonHang SET TrangThai = N'Đã hủy' WHERE MaDonHang = '" + maDonHang + "'";
            int result = dungchung.updateData(sql);

            if (result > 0)
            {
                LoadDonHang();
                ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess",
                    "alert('Đơn hàng đã được hủy thành công!');", true);
            }
        }

        // Hàm helper để trả về class CSS cho trạng thái
        public string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "chờ xác nhận":
                    return "status-pending";
                case "đang xử lý":
                case "đang giao hàng":
                    return "status-processing";
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