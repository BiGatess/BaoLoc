using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DoAn;

namespace DoAn
{
    public partial class QuanLiMatHang : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "")
            {
                ShowToast("Vui lòng đăng nhập với quyền quản trị viên", false);
                return;
            }
            else
            {
                int phanquyen = 1;
                string sql = "select * from taikhoan where tendangnhap = '" + tendangnhap + "' and phanquyen = '" + phanquyen + "'";
                DataTable dt = dungchung.docdulieu(sql);
                if (dt.Rows.Count > 0)
                {
                    load_dulieu();
                }
                else
                {
                    ShowToast("Vui lòng đăng nhập với quyền quản trị viên", false);
                    return;
                }
            }
        }

        protected void load_dulieu()
        {
            string sql = "select * from mathang";
            GridView1.DataSource = dungchung.docdulieu(sql);
            GridView1.DataBind();

            string sql2 = "select tenloai,maloai from loaihang";
            loaihang.DataSource = dungchung.docdulieu(sql2);
            loaihang.DataBind();
        }

        protected void themsanpham_Click1(object sender, EventArgs e)
        {
            string tendn = Session["tendangnhap"] + "";
            if (tendn == "")
            {
                ShowToast("Vui lòng đăng nhập", false);
                return;
            }

            int phanquyen = 1;
            string sql = "select * from taikhoan where tendangnhap = '" + tendn + "' and phanquyen = '" + phanquyen + "'";
            DataTable dt = dungchung.docdulieu(sql);
            if (dt.Rows.Count > 0)
            {
                string sqltim = "select * from mathang where mahang ='" + mahang.Text + "'";
                DataTable dt2 = dungchung.docdulieu(sqltim);
                if (dt2.Rows.Count > 0)
                {
                    ShowToast("Mặt hàng đã tồn tại", false);
                    return;
                }
                else
                {
                    try
                    {
                        string fileName = Path.GetFileName(fileUpload.FileName);
                        if (string.IsNullOrEmpty(fileName))
                        {
                            ShowToast("Vui lòng chọn ảnh sản phẩm", false);
                            return;
                        }

                        string imagePath = Server.MapPath("~/image/") + fileName;
                        fileUpload.SaveAs(imagePath);
                        string image = fileName;
                        string maLoai = loaihang.SelectedValue;

                        string sql2 = "INSERT INTO MATHANG (MaHang, TenHang, DonGia, SoLuong, MoTa, HinhAnh, MaLoai) " +
                            "VALUES ('" + mahang.Text + "','" + tenhang.Text + "','" + dongia.Text + "','" + soluong.Text + "','" + mota.Text + "','" + image + "','" + maLoai + "')";

                        int result = dungchung.updateData(sql2);
                        if (result > 0)
                        {
                            load_dulieu();
                            ShowToast("Thêm sản phẩm thành công", true);
                            // Reset form
                            mahang.Text = "";
                            tenhang.Text = "";
                            dongia.Text = "";
                            soluong.Text = "";
                            mota.Text = "";
                        }
                        else
                        {
                            ShowToast("Thêm sản phẩm thất bại", false);
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowToast("Lỗi: " + ex.Message, false);
                    }
                }
            }
        }

        protected void sua_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "")
            {
                ShowToast("Vui lòng đăng nhập", false);
                return;
            }

            try
            {
                Button bt = (Button)sender;
                string mahang = bt.CommandArgument;
                GridViewRow item = (GridViewRow)bt.Parent.Parent;
                string soluong = ((TextBox)item.FindControl("txt_soluong")).Text;

                string sql = "update mathang set soluong=" + soluong + " where mahang= '" + mahang + "'";
                int row = dungchung.updateData(sql);
                if (row > 0)
                {
                    load_dulieu();
                    ShowToast("Cập nhật số lượng thành công", true);
                }
                else
                {
                    ShowToast("Cập nhật số lượng thất bại", false);
                }
            }
            catch (Exception ex)
            {
                ShowToast("Lỗi khi cập nhật: " + ex.Message, false);
            }
        }

        protected void xoa_Click(object sender, EventArgs e)
        {
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "")
            {
                ShowToast("Vui lòng đăng nhập", false);
                return;
            }

            try
            {
                string mahang = ((Button)sender).CommandArgument;
                string sql = "delete from mathang where mahang = '" + mahang + "'";
                int ketqua = dungchung.updateData(sql);
                if (ketqua > 0)
                {
                    load_dulieu();
                    ShowToast("Xóa sản phẩm thành công", true);
                }
                else
                {
                    ShowToast("Xóa sản phẩm thất bại", false);
                }
            }
            catch (Exception ex)
            {
                ShowToast("Lỗi khi xóa: " + ex.Message, false);
            }
        }

        // Hàm hiển thị toast thông báo
        private void ShowToast(string message, bool isSuccess)
        {
            string script = $@"<script type='text/javascript'>
                showToast('{message.Replace("'", "\\'")}', {isSuccess.ToString().ToLower()});
            </script>";

            ScriptManager.RegisterStartupScript(this, GetType(), "ToastMessage", script, false);
        }
    }
}