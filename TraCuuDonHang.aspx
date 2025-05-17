<%@ Page Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeFile="TraCuuDonHang.aspx.cs" Inherits="DoAn.TraCuuDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       .search-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 30px;
            margin-bottom: 30px;
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
            text-align: left; /* Mặc định căn trái */
        }

        .order-table th:nth-child(2),
        .order-table th:nth-child(4) {
            text-align: right; /* Đơn giá và Thành tiền căn phải */
        }

        .order-table th:nth-child(3) {
            text-align: center; /* Số lượng căn giữa */
        }

        .order-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: left; /* Mặc định căn trái */
        }

        .order-table td:nth-child(2),
        .order-table td:nth-child(4) {
            text-align: right; /* Đơn giá và Thành tiền căn phải */
        }

        .order-table td:nth-child(3) {
            text-align: center; /* Số lượng căn giữa */
        }

        .order-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .order-table tr:hover {
            background-color: #f1f1f1;
        }

        .status-pending {
            color: #f39c12;
            font-weight: 600;
        }

        .status-shipping {
            color: #3498db;
            font-weight: 600;
        }

        .status-completed {
            color: #2ecc71;
            font-weight: 600;
        }

        .status-cancelled {
            color: #e74c3c;
            font-weight: 600;
        }

        .btn-detail {
            background-color: cornflowerblue;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .btn-detail:hover {
            background-color: pink;
        }
      
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="search-container">
            <h2 class="mb-4">Tra cứu đơn hàng</h2>
            <div class="row">
                <div class="col-md-8">
                    <asp:TextBox ID="txtMaDonHang" runat="server" CssClass="form-control" 
                        placeholder="Nhập mã đơn hàng"></asp:TextBox>
                </div>
                <div class="col-md-4">
                    <asp:Button ID="btnTimKiem" runat="server" Text="Tìm kiếm" 
                        CssClass="btn btn-primary w-100" OnClick="btnTimKiem_Click" />
                </div>
            </div>
        </div>
        
        <asp:Panel ID="pnlKetQua" runat="server" Visible="false">
            <div class="table-responsive">
                <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False" 
                    CssClass="order-table" EmptyDataText="Không tìm thấy đơn hàng nào">
                    <Columns>
                        <asp:BoundField DataField="MaDonHang" HeaderText="Mã đơn hàng" />
                        <asp:BoundField DataField="NgayDatHang" HeaderText="Ngày đặt" 
                            DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                        <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" 
                            DataFormatString="{0:N0}đ" ItemStyle-HorizontalAlign="Right" />
                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <span class='<%# GetStatusClass(Eval("TrangThai").ToString()) %>'>
                                    <%# Eval("TrangThai") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thao tác">
                            <ItemTemplate>
                                <asp:Button ID="btnChiTiet" runat="server" Text="Chi tiết" 
                                    CommandArgument='<%# Eval("MaDonHang") %>' 
                                    OnClick="btnChiTiet_Click" CssClass="btn-detail" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </asp:Panel>
        
        <asp:Panel ID="pnlChiTiet" runat="server" Visible="false">
            <div class="search-container mt-4">
                <h4>Chi tiết đơn hàng: <asp:Literal ID="ltrMaDon" runat="server"></asp:Literal></h4>
                
                <div class="row mb-3">
                    <div class="col-md-6">
                        <h5>Thông tin khách hàng</h5>
                        <p><strong>Tên:</strong> <asp:Literal ID="ltrTenKH" runat="server"></asp:Literal></p>
                        <p><strong>Điện thoại:</strong> <asp:Literal ID="ltrDienThoai" runat="server"></asp:Literal></p>
                        <p><strong>Địa chỉ:</strong> <asp:Literal ID="ltrDiaChi" runat="server"></asp:Literal></p>
                    </div>
                    <div class="col-md-6">
                        <h5>Thông tin đơn hàng</h5>
                        <p><strong>Ngày đặt:</strong> <asp:Literal ID="ltrNgayDat" runat="server"></asp:Literal></p>
                        <p><strong>Phương Thức Thanh toán:</strong> <asp:Literal ID="ltrPTThanhToan" runat="server"></asp:Literal></p>
                        <p><strong>Trạng thái:</strong> <span class='<%# GetStatusClass(Eval("TrangThai").ToString()) %>'>
                            <asp:Literal ID="ltrTrangThai" runat="server"></asp:Literal></span></p>
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
                    <asp:Button ID="btnQuayLai" runat="server" Text="Quay lại" 
                        CssClass="btn btn-secondary" OnClick="btnQuayLai_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
