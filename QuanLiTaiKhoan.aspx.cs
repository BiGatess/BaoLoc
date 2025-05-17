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
    public partial class QuanLiTaiKhoan : System.Web.UI.Page
    {
        LOPDUNGCHUNG dungchung = new LOPDUNGCHUNG();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            string tendangnhap = Session["tendangnhap"] + "";
            if (tendangnhap == "")
            {
                lb_thongbao1.Text = "Vui Lòng Đăng Nhập Với Quyền Quản Trị Viên";
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
                    lb_thongbao1.Text = "Vui Lòng Đăng Nhập Với Quyền Quản Trị Viên";
                    return;
                }
            }
        }
        protected void load_dulieu()
        {
            string sql = "select * from taikhoan";
            GridView1.DataSource = dungchung.docdulieu(sql);
            GridView1.DataBind();
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            string tendn = Session["tendangnhap"] + "";
            if (tendn == "") return;
            string sql = "select * from taikhoan where tendangnhap = '" + tendn + "' and phanquyen='" + 1 + "'";
            DataTable dt = dungchung.docdulieu(sql);
            if (dt.Rows.Count > 0)
            {
                string sqltim = "select * from taikhoan where tendangnhap ='" + tendangnhap.Text + "'";
                DataTable dt2 = dungchung.docdulieu(sqltim);
                if (dt2.Rows.Count > 0)
                {
                    lb_thongbao.Text = "Tài Khoản Đã Tồn Tại";
                    return;
                }
                else
                {
                    string sqlthem = "insert into taikhoan values('" + tendangnhap.Text + "','" + matkhau.Text + "', '" + phanquyen.Text + "')";
                    int ketqua = dungchung.updateData(sqlthem);
                    if (ketqua > 0)
                    {
                        lb_thongbao.Text = "Thêm Thành Công";
                        load_dulieu();
                    }
                }
            }
        }
        protected void btn_sua_Click(object sender, EventArgs e)
        {
            string tendn = Session["tendangnhap"] + "";
            if (tendn == "") return;
            Button bt = (Button)sender;
            string tendangnhap = bt.CommandArgument;
            GridViewRow item = (GridViewRow)bt.Parent.Parent;
            string phanquyen = ((TextBox)item.FindControl("txt_phanquyen")).Text;

            string sql2 = "update taikhoan set phanquyen= '" + int.Parse(phanquyen) + "' where tendangnhap = '" + tendangnhap + "'";
            int row = dungchung.updateData(sql2);
            if (row > 0)
            {
                load_dulieu();
                lb_thongbao1.Text = "Sửa Thành công";
            }
        }

        protected void btn_xoa_Click(object sender, EventArgs e)
        {
            string tendn = Session["tendangnhap"] + "";
            if (tendn == "") return;
            Button bt = (Button)sender;
            string tendangnhap = bt.CommandArgument;
            string sql2 = "delete from taikhoan where tendangnhap = '" + tendangnhap + "'";
            int row = dungchung.updateData(sql2);
            if (row > 0)
            {
                load_dulieu();
                lb_thongbao1.Text = "Xóa Thành Công";
            }
        }
    }
}