<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="DoAn.GioHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    /* Giữ lại CSS của bạn */
    .cart-container {
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 20px;
        margin-bottom: 30px;
    }
    
    .cart-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        border-radius: 8px;
        overflow: hidden;
    }
    
    .cart-table th {
        background-color: #2c3e50;
        color: white;
        padding: 12px;
        text-align: left;
    }
    
    .cart-table td {
        padding: 12px;
        border-bottom: 1px solid #e8e8e8;
        vertical-align: middle;
    }
    
    .cart-table tr:hover {
        background-color: #f9f9f9;
    }
    
    .product-image {
        max-width: 100px;
        height: auto;
        border-radius: 4px;
    }
    
    .quantity-input {
        width: 60px;
        padding: 6px;
        text-align: center;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .btn-action {
        padding: 8px 12px;
        margin: 0 5px;
        border-radius: 4px;
        font-size: 14px;
        transition: all 0.3s;
    }
    
    .btn-update {
        background-color: #3498db;
        color: white;
        border: none;
    }
    
    .btn-delete {
        background-color: #e74c3c;
        color: white;
        border: none;
    }
    
    .btn-action:hover {
        opacity: 0.9;
        transform: translateY(-1px);
    }
    
    .total-section {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        margin-top: 20px;
    }
    
    .empty-cart {
        text-align: center;
        padding: 40px;
        color: #7f8c8d;
    }
    
    .notification {
        padding: 10px 15px;
        margin-bottom: 15px;
        border-radius: 4px;
        display: inline-block;
    }
    
    .success-notification {
        background-color: #d4edda;
        color: #155724;
    }
    
    .error-notification {
        background-color: #f8d7da;
        color: #721c24;
    }
    
    /* CSS mới  */
    .cart-header {
        margin-bottom: 20px;
        border-bottom: 2px solid #f0f2f5;
        padding-bottom: 12px;
    }
    
    .cart-header h3 {
        font-size: 20px;
        color: #ff4757;
        margin: 0;
        font-weight: 600;
    }
    
    .product-name {
        font-weight: 600;
        color: #2c3e50;
    }
    
    .price-tag {
        font-weight: 600;
        color: #ff4757;
    }
    
    .table-responsive {
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 0 15px rgba(0,0,0,0.05);
    }
    
    .action-buttons {
        display: flex;
        gap: 5px;
    }
    
    .summary-section {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
        padding: 15px;
        background-color: #f8f9fa;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    
    .summary-total {
        font-size: 18px;
        font-weight: 700;
        color: #ff4757;
        margin-right: 15px;
    }
    
    .checkout-button {
        background-color: #ff4757;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s;
    }
    
    .checkout-button:hover {
        background-color: #e83e49;
        transform: translateY(-2px);
    }
    
    .btn-lg {
        padding: 8px 16px !important;
        font-size: 14px !important;
    }
    
    .btn-success {
        background-color: #2ed573 !important;
        border-color: #2ed573 !important;
    }
    
    .btn-danger {
        background-color: #ff4757 !important;
        border-color: #ff4757 !important;
    }
    
    /* Thêm animation cho các sản phẩm */
    .cart-table tr {
        transition: all 0.3s;
    }
    
    /* Thêm CSS cho alert */
    .alert {
        padding: 10px 15px;
        margin-bottom: 15px;
        border-radius: 4px;
    }
    
    .alert-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .alert-danger {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .alert-warning {
        background-color: #fff3cd;
        color: #856404;
        border: 1px solid #ffeeba;
    }
    
    .alert-info {
        background-color: #d1ecf1;
        color: #0c5460;
        border: 1px solid #bee5eb;
    }
    
    .empty-cart-container {
        text-align: center;
        padding: 40px;
    }
    
    .empty-cart-container h4 {
        color: #555;
        margin-bottom: 20px;
    }
    
    .empty-cart-container .btn-primary {
        background-color: #3498db;
        color: white;
        padding: 10px 20px;
        border-radius: 5px;
        text-decoration: none;
        display: inline-block;
        margin-top: 15px;
    }
        .checkbox-lon {
            width: 24px;
            height: 24px;
            accent-color: #f53d2d; 
            cursor: pointer;
            transform: scale(5.0);
        }
    
    @media (max-width: 768px) {
        .cart-container {
            padding: 15px;
        }
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-3">
        <div class="row">
            <div class="col-md-12">
                <div class="cart-container">
                    <div class="cart-header">
                        <h3>Giỏ hàng của bạn</h3>
                    </div>
                    
                    <asp:Label ID="lb_thongbao" runat="server" Text=""></asp:Label>
                    <asp:Label ID="lb_sx" runat="server" Text=""></asp:Label>
                    
                    <div class="table-responsive">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="cart-table" DataKeyNames="mahang">
                            <Columns>
                                <asp:TemplateField HeaderText="Chọn">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkChon" runat="server" CssClass="checkbox-lon" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="mahang" HeaderText="" Visible="false" />
                                <asp:BoundField DataField="tenhang" HeaderText="Tên Sản Phẩm" ItemStyle-CssClass="product-name" />
                                <asp:TemplateField HeaderText="Hình Ảnh">
                                    <ItemTemplate>
                                        <asp:Image ID="Image1" runat="server" CssClass="product-image" ImageUrl='<%# "image/"+Eval("hinhanh") %>' Width="107px" Height="105px" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thành Tiền">
                                    <ItemTemplate>
                                        <asp:Label ID="lblThanhTien" runat="server" CssClass="price-tag" Text='<%# Eval("thanhtien", "{0:N0}đ") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Số Lượng">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtsoluong" runat="server" Text='<%# Eval("soluong") %>' CssClass="quantity-input" 
                                                    TextMode="Number" min="1" Width="74px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="thanhtien" HeaderText="Thành Tiền" ItemStyle-CssClass="price-tag" DataFormatString="{0:N0}đ" />
                                <asp:TemplateField HeaderText="Thao Tác">
                                    <ItemTemplate>
                                        <div class="action-buttons">
                                            <asp:Button ID="sua" CommandArgument='<%# Eval("mahang") %>' runat="server" Text="Cập nhật" 
                                                       CssClass="btn btn-success btn-lg" OnClick="sua_Click" />
                                            <asp:Button ID="xoa" CommandArgument='<%# Eval("mahang") %>' runat="server" Text="Xóa" 
                                                       CssClass="btn btn-danger btn-lg" OnClick="xoa_Click" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="empty-cart-container">
                                    <h4>Giỏ hàng của bạn đang trống</h4>
                                    <p>Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                                    <a href="TrangChu.aspx" class="btn-primary">Tiếp tục mua sắm</a>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                    
                    <!-- Phần tổng tiền và thanh toán -->
                    <div class="summary-section" id="divSummary" runat="server">
                        <div class="summary-total">Tổng cộng: <asp:Label ID="lblTongTien" runat="server" Text="0đ"></asp:Label></div>
                        <asp:Button ID="btnThanhToan" runat="server" Text="Thanh toán" CssClass="checkout-button" OnClick="btnThanhToan_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>