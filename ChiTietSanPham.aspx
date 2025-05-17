<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="DoAn.ChiTietSanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-bg: #2c3e50;
        }
        
        .product-container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
            margin: 40px 0;
            overflow: hidden;
        }
        
        .product-image-container {
            padding: 30px;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .product-image {
            max-width: 100%;
            height: auto;
            transition: transform 0.5s;
        }
        
        .product-image:hover {
            transform: scale(1.05);
        }
        
        .product-info {
            padding: 30px;
        }
        
        .product-title {
            font-weight: 700;
            color: var(--secondary-color);
            margin-bottom: 10px;
        }
        
        .product-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        .product-brand {
            font-weight: 500;
            color: #6c757d;
            margin-bottom: 20px;
        }
        
        .product-description {
            color: #6c757d;
            margin-bottom: 30px;
            line-height: 1.7;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .quantity-label {
            margin-right: 15px;
            font-weight: 500;
        }
        
        .quantity-input {
            max-width: 100px;
            padding: 10px;
            border: 1px solid #e1e5eb;
            border-radius: 6px;
        }
        
        .add-to-cart-btn {
            background-color: var(--primary-color);
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            width: 100%;
        }
        
        .add-to-cart-btn:hover {
            background-color: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-bottom: 20px;
            background-color: #e3f2fd;
            color: var(--primary-color);
        }
        
        .breadcrumb {
            background-color: transparent;
            padding: 0;
            margin-bottom: 20px;
        }
        
        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .breadcrumb-item.active {
            color: #6c757d;
        }
        
        .specs-table td {
            padding: 12px;
        }
        
        .specs-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        .buy-now-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            width: 100%;
            margin-top: 10px;
        }
        .buy-now-btn:hover {
            background-color: #c0392b;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
    </style>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="TrangChu.aspx">Trang Chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Chi Tiết Sản Phẩm</li>
            </ol>
        </nav>
    </div>

    <div class="container">
        <asp:DataList ID="DataList1" runat="server">
            <ItemTemplate>
                <div class="product-container">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="product-image-container">
                                <img class="product-image" src="<%# "image/"+Eval("hinhanh") %>" alt="<%# Eval("tenhang") %>" id="product-detail">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="product-info">
                                <span class="status-badge"><i class="fas fa-check-circle"></i> Còn hàng</span>
                                <h1 class="product-title">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("tenhang") %>'></asp:Label>
                                </h1>
                                <h2 class="product-price">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("dongia")+ "$" %>'></asp:Label>
                                </h2>
                                <div class="product-brand">
                                    <span class="text-muted">Thương Hiệu:</span>
                                    <strong><%# Eval("tenloai") %></strong>
                                </div>
                                <div class="product-description">
                                    <h5>Mô Tả:</h5>
                                    <p><asp:Label ID="Label3" runat="server" Text='<%# Eval("mota") %>'></asp:Label></p>
                                </div>
                                <div class="quantity-selector">
                                    <label class="quantity-label">Số Lượng:</label>
                                    <asp:TextBox CssClass="form-control quantity-input" ID="txt_soluong" runat="server" TextMode="Number" min="1" value="1"></asp:TextBox>
                                </div>
                                <asp:Button CssClass="btn btn-primary add-to-cart-btn" ID="Button1" runat="server" 
                                    CommandArgument='<%# Eval("mahang") %>' Text="Thêm Vào Giỏ Hàng" 
                                    OnClick="Button1_Click" />
                              
                                <div class="mt-3">
                                    <asp:Label ID="lb_thongbao" runat="server" CssClass="text-success" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card shadow-sm mb-5">
                    <div class="card-body">
                        <h3 class="mb-4">Các thông tin khác</h3>
                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-striped specs-table">
                                    <tbody>
                                        <tr>
                                            <td class="fw-bold" style="width: 30%;">Model</td>
                                            <td><%# Eval("tenhang") %></td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold">Thương hiệu</td>
                                            <td><%# Eval("tenloai") %></td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold">Bảo hành</td>
                                            <td>Chính hãng 36 tháng.</td>
                                        </tr>
                                        <tr>
                                            <td class="fw-bold">Hỗ trợ</td>
                                            <td>Đổi mới trong 7 ngày.</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
</asp:Content>
