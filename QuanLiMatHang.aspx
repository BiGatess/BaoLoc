<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLiMatHang.aspx.cs" Inherits="DoAn.QuanLiMatHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Css mới tự mình thêm trực tiếp */
        .admin-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            overflow: hidden;
            margin-bottom: 25px;
        }
        
        .admin-card:hover {
            box-shadow: 0 12px 24px rgba(0,0,0,0.12);
            transform: translateY(-3px);
        }
        
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            font-size: 1.2rem;
            border-bottom: none;
        }
        
        .product-img {
            width: 100%;
            height: 120px;
            object-fit: contain;
            border-radius: 6px;
            background: #f8f9fa;
            padding: 5px;
            transition: transform 0.3s;
        }
        
        .product-img:hover {
            transform: scale(1.05);
        }
        
        .modern-table {
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .modern-table th {
            background: #f8f9fa;
            position: sticky;
            top: 0;
            font-weight: 600;
            color: #495057;
        }
        
        .modern-table td {
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
        }
        
        .form-control-modern {
            border-radius: 6px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
        }
        
        .form-control-modern:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-action {
            padding: 6px 12px;
            font-size: 0.85rem;
            border-radius: 6px;
            transition: all 0.2s;
        }
        
        .btn-action i {
            margin-right: 5px;
        }
        
        .quantity-input {
            width: 80px;
            text-align: center;
        }
    
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .toast {
            display: none;
            min-width: 300px;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 4px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            animation: slideIn 0.5s forwards, fadeOut 0.5s 2.5s forwards;
            border-left: 5px solid;
        }
        
        .toast-success {
            background-color: #d4edda;
            border-left-color: #28a745;
            color: #155724;
        }
        
        .toast-error {
            background-color: #f8d7da;
            border-left-color: #dc3545;
            color: #721c24;
        }
        
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        
        @keyframes fadeOut {
            from { opacity: 1; }
            to { opacity: 0; }
        }
        
        .toast-icon {
            margin-right: 10px;
            font-size: 1.2rem;
        }
        
        .file-upload-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: 100%;
        }
        
        .file-upload-btn {
            border: 2px dashed #dee2e6;
            border-radius: 6px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
        }
        
        .file-upload-btn:hover {
            border-color: #667eea;
            background: #f8f9fa;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <!-- Toast -->
        <div class="toast-container">
            <asp:Panel ID="toastSuccess" runat="server" CssClass="toast toast-success" role="alert">
                <div class="d-flex align-items-center">
                    <i class="fas fa-check-circle toast-icon"></i>
                    <span id="successMessage"></span>
                </div>
            </asp:Panel>
            
            <asp:Panel ID="toastError" runat="server" CssClass="toast toast-error" role="alert">
                <div class="d-flex align-items-center">
                    <i class="fas fa-exclamation-circle toast-icon"></i>
                    <span id="errorMessage"></span>
                </div>
            </asp:Panel>
        </div>

        <div class="row">
            <!-- Product List -->
            <div class="col-lg-8">
                <div class="admin-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-boxes me-2"></i>DANH SÁCH SẢN PHẨM</span>
                    </div>
                    
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                CssClass="table modern-table">
                                <Columns>
                                    <asp:BoundField DataField="tenhang" HeaderText="TÊN SẢN PHẨM" 
                                        HeaderStyle-CssClass="py-3" ItemStyle-CssClass="py-3" />
                                        
                                    <asp:TemplateField HeaderText="HÌNH ẢNH" HeaderStyle-CssClass="py-3">
                                        <ItemTemplate>
                                            <asp:Image ID="Image1" runat="server" CssClass="product-img" 
                                                ImageUrl='<%# "image/"+Eval("hinhanh") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:BoundField DataField="dongia" HeaderText="GIÁ" 
                                        DataFormatString="{0:N0}₫" 
                                        HeaderStyle-CssClass="text-end py-3" 
                                        ItemStyle-CssClass="text-end py-3" />
                                    
                                    <asp:TemplateField HeaderText="SỐ LƯỢNG" HeaderStyle-CssClass="py-3">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_soluong" runat="server" 
                                                Text='<%# Eval("soluong") %>' 
                                                CssClass="form-control quantity-input"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="THAO TÁC" HeaderStyle-CssClass="py-3">
                                        <ItemTemplate>
                                            <div class="d-flex gap-2">
                                                <asp:Button ID="sua" runat="server" Text="SỬA" 
                                                    CommandArgument='<%# Eval("mahang") %>' 
                                                    OnClick="sua_Click"
                                                    CssClass="btn btn-warning btn-action" />
                                                    
                                                <asp:Button ID="xoa" runat="server" Text="XÓA" 
                                                    CommandArgument='<%# Eval("mahang") %>' 
                                                    OnClick="xoa_Click"
                                                    CssClass="btn btn-danger btn-action" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Add Form -->
            <div class="col-lg-4">
                <div class="admin-card">
                    <div class="card-header">
                        <i class="fas fa-plus-circle me-2"></i>THÊM SẢN PHẨM MỚI
                    </div>
                    
                    <div class="card-body p-4">
                        <div class="form-group mb-3">
                            <label class="form-label">MÃ HÀNG</label>
                            <asp:TextBox ID="mahang" runat="server" 
                                CssClass="form-control form-control-modern"></asp:TextBox>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label class="form-label">LOẠI HÀNG</label>
                            <asp:DropDownList ID="loaihang" runat="server" 
                                CssClass="form-control form-control-modern"
                                DataTextField="tenloai" DataValueField="maloai">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label class="form-label">TÊN SẢN PHẨM</label>
                            <asp:TextBox ID="tenhang" runat="server" 
                                CssClass="form-control form-control-modern"></asp:TextBox>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label class="form-label">GIÁ TIỀN (₫)</label>
                            <asp:TextBox ID="dongia" runat="server" 
                                CssClass="form-control form-control-modern"></asp:TextBox>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label class="form-label">MÔ TẢ</label>
                            <asp:TextBox ID="mota" runat="server" 
                                CssClass="form-control form-control-modern"></asp:TextBox>
                        </div>
                        
                        <div class="form-group mb-3">
                            <label class="form-label">SỐ LƯỢNG</label>
                            <asp:TextBox ID="soluong" runat="server" 
                                CssClass="form-control form-control-modern"></asp:TextBox>
                        </div>
                        
                        <div class="form-group mb-4">
                            <label class="form-label mb-2">ẢNH SẢN PHẨM</label>
                            <div class="file-upload-wrapper">
                                <asp:FileUpload ID="fileUpload" runat="server" 
                                    CssClass="d-none" />
                                <label for="<%= fileUpload.ClientID %>" class="file-upload-btn">
                                    <i class="fas fa-cloud-upload-alt fa-2x mb-2"></i>
                                    <p class="mb-0">Chọn hoặc kéo thả ảnh vào đây</p>
                                </label>
                            </div>
                        </div>
                        
                        <asp:Button ID="themsanpham" runat="server" 
                            Text="THÊM SẢN PHẨM" 
                            OnClick="themsanpham_Click1"
                            CssClass="btn btn-primary w-100 py-3" />
                            
                        <asp:Label ID="lb_thongbao" runat="server" Text="" 
                            CssClass="d-block mt-3 text-center text-danger"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Hiển thị toast thông báo
        function showToast(message, isSuccess) {
            var toastElement = isSuccess ? document.getElementById('<%= toastSuccess.ClientID %>') 
                                        : document.getElementById('<%= toastError.ClientID %>');
            var messageSpan = isSuccess ? document.getElementById('successMessage') 
                                      : document.getElementById('errorMessage');
            
            messageSpan.innerText = message;
            toastElement.style.display = 'block';
            
            // Tự động ẩn sau 3 giây
            setTimeout(function() {
                toastElement.style.display = 'none';
            }, 3000);
        }

        // Hiển thị tên file khi chọn ảnh
        document.addEventListener("DOMContentLoaded", function() {
            const fileUpload = document.getElementById('<%= fileUpload.ClientID %>');
            const fileUploadBtn = fileUpload.nextElementSibling;

            fileUpload.addEventListener('change', function () {
                if (this.files.length > 0) {
                    fileUploadBtn.innerHTML = `
                        <i class="fas fa-check-circle text-success me-2"></i>
                        ${this.files[0].name}
                    `;
                }
            });
        });
    </script>
</asp:Content>