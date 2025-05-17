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
    public partial class GioHang : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "")
            {
                lb_thongbao.Text = "<div class='alert alert-warning'>Vui lòng đăng nhập để xem giỏ hàng</div>";
                // Ẩn GridView và phần tổng tiền khi chưa đăng nhập
                GridView1.Visible = false;
                divSummary.Visible = false;
                return;
            }
            load_dulieu(tendangnhap);
        }

        protected void load_dulieu(string tendangnhap)
        {
            // Đảm bảo câu truy vấn SQL đúng và đầy đủ
            string sqldoc = "select GIOHANG.mahang, TenHang, GIOHANG.soluong, dongia, hinhanh, GIOHANG.soluong * dongia AS thanhtien " +
                           "From GIOHANG, MATHANG where GIOHANG.mahang = MATHANG.mahang and tendangnhap = '" + tendangnhap + "'";

            DataTable dt = dungchung.docdulieu(sqldoc);

            // Kiểm tra kết quả truy vấn
            if (dt != null && dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                GridView1.Visible = true;
                divSummary.Visible = true;

                // Hiển thị thông báo số sản phẩm
                lb_thongbao.Text = "<div class='alert alert-info'>Giỏ hàng của bạn có " + dt.Rows.Count + " sản phẩm</div>";

                // Tính và hiển thị tổng tiền
                TinhTongTien();
            }
            else
            {
                // Hiển thị thông báo giỏ hàng trống
                lb_thongbao.Text = "<div class='alert alert-info'>Giỏ hàng của bạn đang trống</div>";
                lblTongTien.Text = "0đ";

                // Ẩn phần tổng tiền khi giỏ hàng trống
                divSummary.Visible = false;

                // Hiển thị GridView với mẫu trống
                GridView1.DataSource = null;
                GridView1.DataBind();
                GridView1.Visible = true;
            }
        }

        // Hàm tính tiền - cải tiến để xử lý chính xác hơn
        protected void TinhTongTien()
        {
            decimal tongTien = 0;

            foreach (GridViewRow row in GridView1.Rows)
            {
                Label lblThanhTien = (Label)row.FindControl("lblThanhTien");
                if (lblThanhTien != null)
                {
                    string thanhTienStr = lblThanhTien.Text;
                    decimal thanhTien;

                    // Loại bỏ các ký tự định dạng
                    thanhTienStr = thanhTienStr.Replace(".", "").Replace(",", "").Replace("đ", "").Trim();

                    if (decimal.TryParse(thanhTienStr, out thanhTien))
                    {
                        tongTien += thanhTien;
                    }
                }
            }

            lblTongTien.Text = String.Format("{0:N0}đ", tongTien);
        }



        protected void sua_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "") return;

            Button bt = (Button)sender;
            string mahang = bt.CommandArgument;

            // Tìm GridViewRow từ Button sender
            GridViewRow item = (GridViewRow)bt.NamingContainer;

            // Sửa cách lấy TextBox để đảm bảo lấy đúng control
            TextBox txtSoLuong = (TextBox)item.FindControl("txtsoluong");

            if (txtSoLuong != null)
            {
                string soluongStr = txtSoLuong.Text;
                int soluong;

                // Kiểm tra giá trị số lượng có hợp lệ không
                if (!string.IsNullOrEmpty(soluongStr) && int.TryParse(soluongStr, out soluong) && soluong > 0)
                {
                    string sql = "update giohang set soluong=" + soluong +
                               " where tendangnhap='" + tendangnhap + "' and mahang='" + mahang + "'";

                    int row = dungchung.updateData(sql);

                    if (row > 0)
                    {
                        load_dulieu(tendangnhap);
                        lb_sx.Text = "<div class='alert alert-success'>Cập nhật số lượng thành công</div>";
                    }
                    else
                    {
                        lb_sx.Text = "<div class='alert alert-danger'>Cập nhật số lượng thất bại</div>";
                    }
                }
                else
                {
                    lb_sx.Text = "<div class='alert alert-warning'>Số lượng không hợp lệ</div>";
                }
            }
        }

        protected void xoa_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "") return;

            Button btnXoa = (Button)sender;
            string mahang = btnXoa.CommandArgument;

            string sql = "delete from GIOHANG where mahang = '" + mahang + "' and tendangnhap='" + tendangnhap + "'";
            int ketqua = dungchung.updateData(sql);

            if (ketqua > 0)
            {
                load_dulieu(tendangnhap);
                lb_sx.Text = "<div class='alert alert-success'>Xóa sản phẩm thành công</div>";
            }
            else
            {
                lb_sx.Text = "<div class='alert alert-danger'>Xóa sản phẩm thất bại</div>";
            }
        }

        // Xử lý nút thanh toán
            protected void btnThanhToan_Click(object sender, EventArgs e)
            {
                string tendangnhap = Session["tendangnhap"] + "";
                if (tendangnhap == "")
                {
                    lb_thongbao.Text = "<div class='alert alert-warning'>Vui lòng đăng nhập để thanh toán</div>";
                    return;
                }

                // Kiểm tra xem có sản phẩm nào được chọn không
                bool coSanPhamDuocChon = false;
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("chkChon");
                    if (chk != null && chk.Checked)
                    {
                        coSanPhamDuocChon = true;
                        break;
                    }
                }

                if (!coSanPhamDuocChon)
                {
                    lb_thongbao.Text = "<div class='alert alert-warning'>Vui lòng chọn ít nhất một sản phẩm để thanh toán</div>";
                    return;
                }

                // Lưu danh sách sản phẩm được chọn vào Session
                List<string> danhSachChon = new List<string>();
                foreach (GridViewRow row in GridView1.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("chkChon");
                    if (chk != null && chk.Checked)
                    {
                        string mahang = GridView1.DataKeys[row.RowIndex].Value.ToString();
                        danhSachChon.Add(mahang);
                    }
                }
                Session["SanPhamChon"] = danhSachChon;

                // Chuyển đến trang thanh toán
                Response.Redirect("ThanhToan.aspx");
            }
    }
    }