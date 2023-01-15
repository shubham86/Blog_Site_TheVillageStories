<%@ Page Title="Dashboard" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="villageStories.cpanel.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media only screen and (min-width : 770px) {
            .ibox-title {
                display:block;
            }
        }

        @media only screen and (max-width : 770px) {
            .ibox-title {
                display:block;
            }
                .ibox-title h5 {
                    font-size:16px;
                    font-weight:normal;
                }
        }        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content">
        <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false" Style="margin:20px auto;width:80%">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
        </asp:Panel>

        <div class="row">
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <a href="manage_visitor.aspx">
                        <div class="ibox-title">
                            <h5 style="color: brown">Visitors</h5>
                        </div>
                    </a>
                    <div class="ibox-content">
                        <h1 class="no-margins">
                            <asp:Label ID="lblVisitorCount" runat="server" Text="0"></asp:Label>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <a href="manage_comments.aspx">
                        <div class="ibox-title">
                            <h5 style="color: brown">New Comments</h5>
                        </div>
                    </a>
                    <div class="ibox-content">
                        <h1 class="no-margins">
                            <asp:Label ID="lblComments" runat="server" Text="0"></asp:Label>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="ibox float-e-margins">
                    <a href="manage_blogs.aspx">
                        <div class="ibox-title">
                            <h5 style="color: darkcyan">Total Blogs</h5>
                        </div>
                    </a>
                    <div class="ibox-content">
                        <h1 class="no-margins">
                            <asp:Label ID="lblBlog" runat="server" Text="0"></asp:Label>
                        </h1>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
