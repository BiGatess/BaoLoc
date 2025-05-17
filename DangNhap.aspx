<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="DoAn.DangNhap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Đăng Nhập</title>
    <link rel="stylesheet" href="assets/css/Style.css">
</head>
<body>
    <form id="form1" runat="server">
          <div class="container">
            <div class="row justify-content-center" style="margin-top: 150px;">
                <div class="col-md-12 col-lg-10">
                    <div class="wrap d-md-flex">
                        <div class="text-wrap p-4 p-lg-5 text-center d-flex align-items-center order-md-last">
                            <div class="text w-100">
                                <h2>LAPTOP DANA</h2>
                                <p>Bạn Chưa Có Tài Khoản?</p>
                                <a href="DangKi.aspx" class="btn btn-white btn-outline-white">Đăng Kí</a>
                                <a href="TrangChu.aspx" class="btn btn-white btn-outline-white">Trang Chủ</a>
                            </div>
                        </div>
                        <div class="login-wrap p-4 p-lg-5">
                            <div class="d-flex">
                                <div class="w-100">
                                    <h3 class="mb-4">Đăng Nhập</h3>
                                </div>
                            </div>
                            <div class="form-group mb-3">
                                <label class="label" for="name">Tên Đăng Nhập</label>
                                <asp:TextBox ID="tendangnhap" class="form-control" placeholder="Tên Đăng Nhập"  runat="server" required></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <label class="label" for="password">Mật Khẩu</label>
                                <asp:TextBox type="password" ID="matkhau" class="form-control" placeholder="Mật Khẩu"  runat="server" required></asp:TextBox>
                            </div>
                            <div class="form-group">
                                <asp:Button class="form-control btn btn-primary submit px-3" ID="btn_dangnhap" runat="server" Text="Đăng Nhập" OnClick="btn_dangnhap_Click"  />
                            </div>
                            <asp:Label ID="lb_thongbao" runat="server" Text=""></asp:Label>
                        </div>             
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
