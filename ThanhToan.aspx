<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="DoAn.ThanhToan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .checkout-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .checkout-header {
            border-bottom: 2px solid #f5f5f5;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }
        
        .form-label {
            font-weight: 600;
            margin-bottom: 8px;
            font-weight: 700;
        }
        
        .form-control {
            border-radius: 5px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }
        
        .btn-confirm {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 5px;
            font-weight: 600;
            font-size: 16px;
            width: 100%;
            transition: all 0.3s;
        }
        
        .btn-confirm:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .order-summary {
            background-color: #f9f9f9;
            border-radius: 10px;
            padding: 20px;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .order-total {
            font-weight: 700;
            font-size: 18px;
            color: #e74c3c;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="row">
            <div class="col-md-8">
                <div class="checkout-container">
                    <h2 class="checkout-header">Thông tin thanh toán</h2>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <asp:TextBox ID="txtSoDT" runat="server" CssClass="form-control" required TextMode="Phone"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Tỉnh/Thành phố</label>
                            <asp:DropDownList ID="ddlTinhThanh" runat="server" CssClass="form-control" required>
                                <asp:ListItem Value="">Chọn tỉnh/thành phố</asp:ListItem>
                                <asp:ListItem>Đà Nẵng</asp:ListItem>
                                <asp:ListItem>Hà Nội</asp:ListItem>
                                <asp:ListItem>Hồ Chí Minh</asp:ListItem>
                                <asp:ListItem>Khác</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Quận/Huyện</label>
                            <asp:TextBox ID="txtQuanHuyen" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Phường/Xã</label>
                            <asp:TextBox ID="txtPhuongXa" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Địa chỉ cụ thể</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" required></asp:TextBox>
                        </div>
                    </div>
                    
                    <label class="form-label">Phương thức thanh toán</label>
                    <asp:DropDownList ID="ddlPhuongThuc" runat="server" CssClass="form-control" required>
                        <asp:ListItem Value="">Chọn phương thức</asp:ListItem>
                        <asp:ListItem>Thanh toán khi nhận hàng</asp:ListItem>
                    </asp:DropDownList>
                    
                    <label class="form-label">Ghi chú</label>
                    <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="checkout-container order-summary">
                    <h2 class="checkout-header">Đơn hàng của bạn</h2>
                    
                    <asp:Repeater ID="rptDonHang" runat="server">
                        <ItemTemplate>
                            <div class="order-item">
                                <span><%# Eval("TenHang") %> x <%# Eval("SoLuong") %></span>
                                <span><%# Eval("ThanhTien", "{0:N0}đ") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    
                    <div class="order-item order-total">
                        <span>Tổng cộng:</span>
                        <span><asp:Literal ID="ltrTongTien" runat="server"></asp:Literal></span>
                    </div>
                    
                    <asp:Button ID="btnXacNhan" runat="server" Text="Xác nhận đơn hàng" 
                        CssClass="btn-confirm" OnClick="btnXacNhan_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
