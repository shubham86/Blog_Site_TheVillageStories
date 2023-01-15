<%@ Page Title="Comments" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="comment_details.aspx.cs" Inherits="villageStories.cpanel.comment_details" %>
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
        .unread {
            color:#0070c0;
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
            <h2>Comments</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li class="active">
                    <a href="javascript:void(0)"><strong>Comments</strong></a>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
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
                                    <div class="col-lg-12">
                                        <input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="Search in table">
                                    </div>
                                </div>
                                <asp:Repeater ID="rptrBlog" runat="server" OnItemCommand="rptrBlog_RowCommand">
                                    <HeaderTemplate>
                                        <table class="footable table table-stripped" data-page-size="20" data-filter="#filter">
                                            <thead>
                                                <tr>                                                    
                                                    <th width="5%" style="text-align: center">Sr.no.</th>
                                                    <th data-hide="phone,tablet" width="15%" style="text-align: center">Date</th>
                                                    <th data-hide="phone,tablet" width="15%" style="text-align: center">Visitor</th>
                                                    <th data-hide="phone,tablet" width="10%" style="text-align: center">Mobile</th>
                                                    <th width="45%">Comments</th>
                                                    <th width="10%" style="text-align: center">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class='<%#Eval("isRead").ToString() == "0" ? "gradeX unread" : "gradeX"%>'>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="lblno" runat="server" Text='<%#Container.ItemIndex+1 %>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("commentDate")).ToString("dd-MM-yyyy hh:mm tt")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("visitorName")%>'></asp:Label>
                                            </td>
                                            <td style="vertical-align: middle;text-align: center">
                                                <asp:Label ID="Label0" runat="server" Text='<%#Eval("mobileNo")%>'></asp:Label>
                                            </td>
                                            <td style="vertical-align: middle">
                                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("comment")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="text-align: center; vertical-align: middle">
                                                <asp:ImageButton ID="imgbtnStatus" runat="server" ImageUrl='<%#Eval("isRead").ToString() == "1" ? "img/tickIcon_green.png" : "img/crossIcon_red.png"%>' ToolTip="Mark as read" Width="18" Height="18" CommandArgument='<%#Eval("commentID")%>' CommandName="status" Enabled='<%# Eval("isRead").ToString() == "1" ? false : true %>'/>&nbsp &nbsp
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="img/delete.png" ToolTip="Delete" Width="18" Height="18" CommandArgument='<%#Eval("commentID")%>' CommandName="delete" OnClientClick="return confirm('Are you sure you want to delete?')" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="7">
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
