<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.Master" AutoEventWireup="true" CodeBehind="QuanLiTaiKhoan.aspx.cs" Inherits="DoAn.QuanLiTaiKhoan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Quản Lý Tài Khoản | LaptopDANA</title>
    <style>
        /* Css tự mình thêm */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .modern-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: all 0.3s ease;
            animation: fadeIn 0.6s forwards;
            border: none;
        }
        
        .modern-card:hover {
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            transform: translateY(-5px);
        }
        
        .glass-panel {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .gradient-header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 15px 20px;
            margin: -1px -1px 20px -1px;
            border-radius: 10px 10px 0 0;
        }
        
        .neumorphic-btn {
            background: #f0f0f0;
            box-shadow:  5px 5px 10px #d9d9d9, 
                         -5px -5px 10px #ffffff;
            border: none;
            transition: all 0.2s;
        }
        
        .neumorphic-btn:hover {
            box-shadow: inset 2px 2px 5px #d9d9d9, 
                        inset -2px -2px 5px #ffffff;
        }
        
        .hover-zoom {
            transition: transform 0.3s;
        }
        
        .hover-zoom:hover {
            transform: scale(1.02);
        }
 
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: linear-gradient(#6a11cb, #2575fc);
            border-radius: 10px;
        }
        
  
        .modern-form .form-control {
            border: none;
            border-bottom: 2px solid #eee;
            border-radius: 0;
            padding-left: 0;
            background: transparent;
            transition: all 0.3s;
        }
        
        .modern-form .form-control:focus {
            box-shadow: none;
            border-bottom-color: #6a11cb;
        }
    
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.03); }
            100% { transform: scale(1); }
        }
        
        .pulse-notification {
            animation: pulse 2s infinite;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <!-- Main Content with Animation -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="modern-card glass-panel">
                    <div class="gradient-header">
                        <h3><i class="fas fa-user-cog me-2"></i> QUẢN LÝ TÀI KHOẢN HỆ THỐNG</h3>
                    </div>
                    
                    <div class="p-4">
                        <asp:Label ID="lb_thongbao1" runat="server" Text="" 
                            CssClass="alert alert-dismissible fade show d-none pulse-notification"></asp:Label>
                        
                        <div class="table-responsive hover-zoom">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                CssClass="table table-hover align-middle">
                                <Columns>
                                    <asp:BoundField HeaderText="TÊN ĐĂNG NHẬP" DataField="tendangnhap" 
                                        HeaderStyle-CssClass="bg-light" />
                                    
                                    <asp:BoundField HeaderText="MẬT KHẨU" DataField="matkhau" 
                                        HeaderStyle-CssClass="bg-light" />
                                    
                                    <asp:TemplateField HeaderText="PHÂN QUYỀN" HeaderStyle-CssClass="bg-light">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txt_phanquyen" runat="server" 
                                                Text='<%# Eval("phanquyen") %>' 
                                                CssClass="form-control modern-input"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="THAO TÁC" HeaderStyle-CssClass="bg-light">
                                        <ItemTemplate>
                                            <div class="d-flex gap-2">
                                                <asp:Button ID="btn_sua" runat="server" Text="SỬA" 
                                                    CommandArgument='<%# Eval("tendangnhap") %>' 
                                                    OnClick="btn_sua_Click"
                                                    CssClass="btn btn-warning btn-sm neumorphic-btn" />
                                                    
                                                <asp:Button ID="btn_xoa" runat="server" Text="XÓA" 
                                                    CommandArgument='<%# Eval("tendangnhap") %>' 
                                                    OnClick="btn_xoa_Click"
                                                    CssClass="btn btn-danger btn-sm neumorphic-btn" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Add Account Section -->
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="modern-card glass-panel hover-zoom">
                    <div class="gradient-header">
                        <h4><i class="fas fa-user-plus me-2"></i> THÊM TÀI KHOẢN MỚI</h4>
                    </div>
                    
                    <div class="p-4 modern-form">
                        <div class="mb-4">
                            <label class="form-label">TÊN ĐĂNG NHẬP</label>
                            <asp:TextBox ID="tendangnhap" runat="server" 
                                CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label">MẬT KHẨU</label>
                            <asp:TextBox ID="matkhau" runat="server" 
                                TextMode="Password" 
                                CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label">PHÂN QUYỀN</label>
                            <asp:TextBox ID="phanquyen" runat="server" 
                                CssClass="form-control"></asp:TextBox>
                        </div>
                        
                        <asp:Button ID="submit" runat="server" Text="THÊM TÀI KHOẢN" 
                            OnClick="submit_Click" 
                            CssClass="btn btn-primary w-100 py-3 gradient-btn" />
                            
                        <asp:Label ID="lb_thongbao" runat="server" Text="" 
                            CssClass="d-block mt-3 text-center pulse-notification"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const notification = document.querySelector('.pulse-notification');
            if (notification && notification.textContent.trim() !== '') {
                notification.classList.remove('d-none');
            }
            
            const cards = document.querySelectorAll('.modern-card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-5px)';
                });
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</asp:Content>