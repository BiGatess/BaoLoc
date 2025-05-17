<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeBehind="XacNhanDonHang.aspx.cs" Inherits="DoAn.XacNhanDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .confirmation-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin: 50px auto;
            max-width: 800px;
            text-align: center;
        }
        
        .confirmation-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
        }
        
        .confirmation-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }
        
        .confirmation-message {
            font-size: 18px;
            margin-bottom: 30px;
            color: #555;
        }
        
        .order-number {
            font-weight: 700;
            color: #e74c3c;
            font-size: 22px;
        }
        
        .btn-continue {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 5px;
            font-weight: 600;
            font-size: 16px;
            margin-top: 20px;
            transition: all 0.3s;
        }
        
        .btn-continue:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="confirmation-container">
            <div class="confirmation-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1 class="confirmation-title">Đặt hàng thành công!</h1>
            <p class="confirmation-message">
                Cảm ơn bạn đã đặt hàng tại LaptopDANA. Đơn hàng của bạn đã được tiếp nhận và đang được xử lý.
            </p>
            <p>
                Mã đơn hàng của bạn: <span class="order-number"><asp:Literal ID="ltrMaDonHang" runat="server"></asp:Literal></span>
            </p>
            <p>
                Bạn có thể theo dõi đơn hàng trong mục <a href="TraCuuDonHang.aspx">Tra cứu đơn hàng</a>
            </p>
            <asp:Button ID="btnTiepTuc" runat="server" Text="Tiếp tục mua sắm" 
                CssClass="btn-continue" OnClick="btnTiepTuc_Click" />
        </div>
    </div>
</asp:Content>
