<%@ Page Title="Manage Blogs" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="manage_blogs.aspx.cs" Inherits="villageStories.cpanel.manage_blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        table td {
            padding: 0 10px;
        }

        table label {
            padding-left: 7px;
        }

        @media only screen and (min-width : 770px) {
            .wrapper-content {
                width: 100%;
                margin: auto;
            }
        }

        @media only screen and (max-width : 770px) {
            table label {
                padding-left: 7px;
                font-size: 10px;
            }
        }
        .mar-t20 {
            margin-top:20px;
        }
    </style>
    <script>
        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlAlert" runat="server" role="alert" Visible="false" style="margin-top:20px">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
    </asp:Panel>
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>Manage Blogs</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li class="active">
                    <a href="javascript:void(0)"><strong>Manage Blogs</strong></a>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control mar-t20" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Text="All Category" Value="0"></asp:ListItem>
                <asp:ListItem Text="कृषिबातम्या" Value="1"></asp:ListItem>
                <asp:ListItem Text="कृषिगाथा" Value="2"></asp:ListItem>
                <asp:ListItem Text="शेतीविषयक" Value="3"></asp:ListItem>
                <asp:ListItem Text="कृषिपूरक" Value="4"></asp:ListItem>
                <asp:ListItem Text="ग्रामिण विकास" Value="5"></asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="row">
                        <div class="ibox-content">                            
                            <div class="form-horizontal" style="margin-top: 10px">                                
                                <div class="row">
                                    <div class="col-lg-10">
                                        <input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="Search in table">
                                    </div>
                                    <div class="col-lg-2" style="text-align:right">
                                        <asp:Label ID="lblAdd" runat="server" Text="Add New Blog" Font-Size="14px" ForeColor="#9e9e9e"></asp:Label>
                                        <div style="float: right; margin-left: 10px;">
                                            <asp:ImageButton ID="imgbtnAdd" runat="server" ImageUrl="img/add_record.png" Width="25px" Height="25px" ToolTip="Add New Blog" OnClick="imgbtnadd_Click" />
                                        </div>
                                    </div>
                                </div>
                                <asp:Repeater ID="rptrBlog" runat="server" OnItemCommand="rptrBlog_RowCommand">
                                    <HeaderTemplate>
                                        <table class="footable table table-stripped" data-page-size="20" data-filter="#filter">
                                            <thead>
                                                <tr>                                                    
                                                    <th width="5%" style="text-align: center">Sr.no.</th>
                                                    <th width="15%" style="text-align: center">Date</th>
                                                    <th width="20%" style="text-align: center">Category</th>
                                                    <th width="40%">Blog Title</th>
                                                    <th data-hide="phone,tablet" width="10%" style="text-align: center">View</th>
                                                    <th data-hide="phone,tablet" width="10%" style="text-align: center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="gradeX">
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("date")).ToString("dd-MM-yyyy hh:mm tt")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("category")%>'></asp:Label>
                                            </td>
                                            <td style="vertical-align: middle">
                                                <asp:Label ID="Label0" runat="server" Text='<%#Eval("postTitle")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("visitorCount")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="text-align: center; vertical-align: middle">
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="img/edit.png" ToolTip="Edite Blog" Width="18" Height="18" CommandArgument='<%#Eval("postID")%>' CommandName="edit" />&nbsp &nbsp
                                                <asp:ImageButton ID="imgbtnStatus" runat="server" ImageUrl='<%#Eval("isActive").ToString() == "1" ? "img/tickIcon_green.png" : "img/crossIcon_red.png"%>' ToolTip='<%#Eval("isActive").ToString() == "1" ? "Make Inactive" : "Make Active"%>' Width="18" Height="18" CommandArgument='<%#Eval("postID")%>' CommandName="status" OnClientClick="return confirm('Are you sure you want to change status?')" />&nbsp &nbsp
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="img/delete.png" ToolTip="Delete" Width="18" Height="18" CommandArgument='<%#Eval("postID")%>' CommandName="delete" OnClientClick="return confirm('Are you sure you want to delete?')" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="6">
                                                        <ul class="pagination pull-right"></ul>
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
