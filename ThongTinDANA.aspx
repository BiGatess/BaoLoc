<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeBehind="ThongTinDANA.aspx.cs" Inherits="DoAn.ThongTinDANA" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section class="bg-success py-5">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8 text-white">
                    <h1>Chào mừng bạn đến với DANA - Nơi mua sắm laptop uy tín tại Đà Nẵng, Việt Nam!</h1>
                    <p>
                        Tại DANA, chúng tôi tự hào là một trong những địa chỉ đáng tin cậy nhất cho việc mua sắm laptop chất lượng tại Đà Nẵng.
                        Với cam kết mang đến sản phẩm tốt nhất và dịch vụ khách hàng tuyệt vời, chúng tôi đồng hành cùng bạn trên con đường công nghệ, 
                        giúp bạn tạo nên những trải nghiệm đáng nhớ.
                    </p>
                </div>
                <div class="col-md-4">
                    <img src="image/gaming3remove.png" alt="About Hero">
                </div>
            </div>
        </div>
    </section>
    <section class="container py-5">
        <div class="row text-center pt-5 pb-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">Dịch Vụ Của Chúng Tôi</h1>
                <p>
                    Với mục tiêu mang đến sự hài lòng tuyệt đối cho khách hàng, chúng tôi không chỉ tập trung vào chất lượng sản phẩm,
                    mà còn cam kết đảm bảo dịch vụ sau bán hàng hoàn hảo. 
                </p>
            </div>
        </div>
        <div class="row">

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-truck fa-lg"></i></div>
                    <h2 class="h5 mt-4 text-center">Miễn Phí Vận Chuyển</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fas fa-exchange-alt"></i></div>
                    <h2 class="h5 mt-4 text-center">Giao Hàng và Đổi Trả</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-percent"></i></div>
                    <h2 class="h5 mt-4 text-center">Giảm Giá</h2>
                </div>
            </div>

            <div class="col-md-6 col-lg-3 pb-5">
                <div class="h-100 py-5 services-icon-wap shadow">
                    <div class="h1 text-success text-center"><i class="fa fa-user"></i></div>
                    <h2 class="h5 mt-4 text-center">Hoạt Động 24H</h2>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
