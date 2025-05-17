<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDungMasterPage.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="DoAn.TrangChu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            left: 0px;
            top: 0px;
        }
        .link-button {
            text-decoration: none;
        }       
        .auto-style2 {
            width: 99%;
            height: 207px;
        }
        .compact-banner {
            width: 75%;
            max-height: 200px;
            margin: 0 auto;
            display: block;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            border-radius: 20px;
        }
        .product-image {
            cursor: pointer;
            transition: transform 0.3s;
        }
        .product-image:hover {
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <img src="image/bar1.png" alt="banner laptop" class="compact-banner">
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-3">
                <h1 class="h2 pb-4">DANH MỤC LAPTOP</h1>
                <asp:DataList ID="dl_danhmuc" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton class="collapsed d-flex justify-content-between h3 text-decoration-none danhmuc" ID="lbt_loaihang" runat="server" Text='<%# Eval("TenLoai") %>' CommandArgument='<%# Eval("maloai") %>' OnClick="lbt_loaihang_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:DataList>
            </div> 
            <div class="col-lg-9">
                <div class="row">
                    <asp:DataList ID="ds_mathang" runat="server" RepeatColumns="3" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <div class="col-md-10">
                                <div class="card mb-4 product-wap rounded-0">
                                    <div class="auto-style1">
                                        <asp:ImageButton ID="imgProduct" runat="server" 
                                            CssClass="card-img rounded-0 img-fluid product-image" 
                                            ImageUrl='<%# "image/"+Eval("hinhanh") %>'
                                            PostBackUrl='<%# "ChiTietSanPham.aspx?mahang=" + Eval("mahang") %>' />
                                    </div>
                                    <div class="card-body">
                                        <asp:LinkButton ID="lbt_mathang" CssClass="link-button" Font-Bold="True" runat="server" Text='<%# Eval("tenhang") %>' Font-Size="130px" CommandArgument='<%# Eval("mahang") %>' OnClick="lbt_mathang_Click1"></asp:LinkButton>
                                        <p class="text-center mb-0">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("dongia") + "$" %>'></asp:Label>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
            </div>
        </div>
    </div>
</asp:Content>