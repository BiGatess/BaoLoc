<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.Master" AutoEventWireup="true" CodeFile="ChiTietDonHangAdmin.aspx.cs" Inherits="DoAn.ChiTietDonHangAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .order-detail-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .order-header {
            border-bottom: 2px solid #f5f5f5;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        
        .order-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .order-table th {
            background-color: #2c3e50;
            color: white;
            padding: 15px;
            text-align: left;
        }
        
        .order-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
        
        .order-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .customer-info, .order-info {
            margin-bottom: 30px;
        }
        
        .info-label {
            font-weight: 600;
            color: #555;
            min-width: 150px;
            display: inline-block;
        }
        
        .status-select {
            padding: 6px 12px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }
        
        .btn-update {
            background-color: #f39c12;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-update:hover {
            background-color: #e67e22;
        }
        
        .btn-back {
            background-color: #95a5a6;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-back:hover {
            background-color: #7f8c8d;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="order-detail-container">
            <div class="order-header">
                <h2>Chi tiết đơn hàng: <asp:Literal ID="ltrMaDonHang" runat="server"></asp:Literal></h2>
            </div>
            
            <div class="row">
                <div class="col-md-6 customer-info">
                    <h4>Thông tin khách hàng</h4>
                    <p><span class="info-label">Tên khách hàng:</span> <asp:Literal ID="ltrTenKH" runat="server"></asp:Literal></p>
                    <p><span class="info-label">Điện thoại:</span> <asp:Literal ID="ltrDienThoai" runat="server"></asp:Literal></p>
                    <p><span class="info-label">Địa chỉ:</span> <asp:Literal ID="ltrDiaChi" runat="server"></asp:Literal></p>
                </div>
                
                <div class="col-md-6 order-info">
                    <h4>Thông tin đơn hàng</h4>
                    <p><span class="info-label">Ngày đặt:</span> <asp:Literal ID="ltrNgayDat" runat="server"></asp:Literal></p>
                    <p><span class="info-label">PT thanh toán:</span> <asp:Literal ID="ltrPTThanhToan" runat="server"></asp:Literal></p>
                    <p>
                        <span class="info-label">Trạng thái:</span> 
                        <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="status-select">
                            <asp:ListItem>Chờ xác nhận</asp:ListItem>
                            <asp:ListItem>Đang giao hàng</asp:ListItem>
                            <asp:ListItem>Đã giao</asp:ListItem>
                            <asp:ListItem>Đã hủy</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                </div>
            </div>
            
            <div class="table-responsive">
                <asp:GridView ID="gvChiTiet" runat="server" AutoGenerateColumns="False" 
                    CssClass="order-table">
                    <Columns>
                        <asp:BoundField DataField="TenSanPham" HeaderText="Sản phẩm" />
                        <asp:BoundField DataField="DonGia" HeaderText="Đơn giá" 
                            DataFormatString="{0:N0}đ" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" 
                            ItemStyle-HorizontalAlign="Center" />
                        <asp:BoundField DataField="ThanhTien" HeaderText="Thành tiền" 
                            DataFormatString="{0:N0}đ" ItemStyle-HorizontalAlign="Right" />
                    </Columns>
                </asp:GridView>
            </div>
            
            <div class="text-end mt-3">
                <h4>Tổng cộng: <asp:Literal ID="ltrTongCong" runat="server"></asp:Literal></h4>
            </div>
            
            <div class="mt-4">
                <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật trạng thái" 
                    CssClass="btn-update" OnClick="btnCapNhat_Click" />
                <asp:Button ID="btnQuayLai" runat="server" Text="Quay lại" 
                    CssClass="btn-back" OnClick="btnQuayLai_Click" />
            </div>
        </div>
    </div>
</asp:Content>
