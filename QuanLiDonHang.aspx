<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.Master" AutoEventWireup="true" CodeFile="QuanLiDonHang.aspx.cs" Inherits="DoAn.QuanLiDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .filter-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .admin-table th {
            background-color: #2c3e50;
            color: white;
            padding: 15px;
            text-align: left;
            position: sticky;
            top: 0;
        }
        
        .admin-table td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        
        .admin-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .admin-table tr:hover {
            background-color: #f1f1f1;
        }
        
        /* Trạng thái */
        .status-pending {
            color: #f39c12;
            font-weight: 600;
        }
        
        .status-processing {
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
        
        /* Thao tác */
        .btn-action {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s;
            margin: 2px;
            border: none;
            color: white;
        }
        
        .btn-detail {
            background-color: #3498db;
        }
        
        .btn-detail:hover {
            background-color: #2980b9;
        }
        
        .btn-edit {
            background-color: #f39c12;
        }
        
        .btn-edit:hover {
            background-color: #e67e22;
        }
        
        .btn-delete {
            background-color: #e74c3c;
        }
        
        .btn-delete:hover {
            background-color: #c0392b;
        }
        
        .pagination-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
        }
        
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
        }
        
        .page-item {
            margin: 0 5px;
        }
        
        .page-link {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: #3498db;
            text-decoration: none;
        }
        
        .page-link:hover {
            background-color: #f1f1f1;
        }
        
        .page-item.active .page-link {
            background-color: #3498db;
            color: white;
            border-color: #3498db;
        }
        
        .form-control {
            border-radius: 5px;
            padding: 8px 12px;
            border: 1px solid #ddd;
        }
        
        .btn-filter {
            background-color: green;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
        }
        
        .btn-filter:hover {
            background-color: #1a252f;
        }
        
        .total-orders {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <h2 class="mb-4">QUẢN LÝ ĐƠN HÀNG</h2>
        
        <!-- Bộ lọc đơn hàng -->
        <div class="filter-container">
            <div class="row">
                <div class="col-md-3">
                    <label>Mã đơn hàng</label>
                    <asp:TextBox ID="txtMaDon" runat="server" CssClass="form-control" placeholder="Nhập mã đơn"></asp:TextBox>
                </div>
                
                <div class="col-md-3">
                    <label>Trạng thái</label>
                    <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-control">
                        <asp:ListItem Value="">Tất cả</asp:ListItem>
                        <asp:ListItem>Chờ xác nhận</asp:ListItem>
                        <asp:ListItem>Đang xử lý</asp:ListItem>
                        <asp:ListItem>Đang giao hàng</asp:ListItem>
                        <asp:ListItem>Đã giao</asp:ListItem>
                        <asp:ListItem>Đã hủy</asp:ListItem>
                    </asp:DropDownList>
                </div>
                
                <div class="col-md-3">
                    <label>Từ ngày</label>
                    <asp:TextBox ID="txtTuNgay" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
                
                <div class="col-md-3">
                    <label>Đến ngày</label>
                    <asp:TextBox ID="txtDenNgay" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>
            </div>
            
            <div class="row mt-3">
                <div class="col-md-12 text-right">
                    <asp:Button ID="btnLoc" runat="server" Text="Lọc đơn hàng" CssClass="btn-filter" OnClick="btnLoc_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Đặt lại" CssClass="btn btn-secondary ml-2" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>
        
        <!-- Thống kê -->
        <div class="total-orders">
            Tổng số đơn hàng: <asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label>
        </div>
        
        <!-- Danh sách đơn hàng -->
        <div class="table-responsive">
            <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False" 
                CssClass="admin-table" EmptyDataText="Không tìm thấy đơn hàng nào"
                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvDonHang_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="STT">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="MaDonHang" HeaderText="Mã đơn hàng">
                        <ItemStyle Font-Bold="true" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="TenKhachHang" HeaderText="Khách hàng" />
                    
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
                                OnClick="btnChiTiet_Click" CssClass="btn-action btn-detail" />
                            
                            <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật" 
                                CommandArgument='<%# Eval("MaDonHang") %>' 
                                OnClick="btnCapNhat_Click" CssClass="btn-action btn-edit" />
                            
                            <asp:Button ID="btnHuyDon" runat="server" Text="Hủy đơn" 
                                CommandArgument='<%# Eval("MaDonHang") %>' 
                                OnClick="btnHuyDon_Click" CssClass="btn-action btn-delete" 
                                Visible='<%# Eval("TrangThai").ToString() != "Đã hủy" && Eval("TrangThai").ToString() != "Đã giao" %>' />
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pagination-container" />
            </asp:GridView>
        </div>
        
        <!-- Panel cập nhật trạng thái (modal) -->
        <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Cập nhật trạng thái đơn hàng</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Mã đơn hàng</label>
                            <asp:TextBox ID="txtModalMaDon" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Trạng thái hiện tại</label>
                            <asp:TextBox ID="txtModalTrangThai" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Cập nhật trạng thái</label>
                            <asp:DropDownList ID="ddlModalTrangThai" runat="server" CssClass="form-control">
                                <asp:ListItem>Chờ xác nhận</asp:ListItem>
                                <asp:ListItem>Đang xử lý</asp:ListItem>
                                <asp:ListItem>Đang giao hàng</asp:ListItem>
                                <asp:ListItem>Đã giao</asp:ListItem>
                                <asp:ListItem>Đã hủy</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <asp:Button ID="btnSaveStatus" runat="server" Text="Lưu thay đổi" 
                            CssClass="btn btn-primary" OnClick="btnSaveStatus_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function showUpdateModal(maDon, trangThai) {
            $('#<%= txtModalMaDon.ClientID %>').val(maDon);
            $('#<%= txtModalTrangThai.ClientID %>').val(trangThai);
            $('#<%= ddlModalTrangThai.ClientID %>').val(trangThai);
            $('#updateStatusModal').modal('show');
        }
    </script>
</asp:Content>
