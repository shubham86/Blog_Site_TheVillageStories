<%@ Page Title="Visitor List" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="manage_visitor.aspx.cs" Inherits="villageStories.cpanel.manage_visitor" %>
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
            <h2>Visitor List</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li class="active">
                    <a href="javascript:void(0)"><strong>Visitor List</strong></a>
                </li>
            </ol>
        </div>
        <div class="col-lg-2 text-center">
            <h3 style="margin: 20px 0 10px 0">Visitor Count</h3>
            <p style="font-size:18px;margin-bottom:0"><asp:Label ID="lblCount" runat="server" Text="0"></asp:Label></p>
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
                                <asp:Repeater ID="rptrVisitor" runat="server">
                                    <HeaderTemplate>
                                        <table class="footable table table-stripped" data-page-size="20" data-filter="#filter">
                                            <thead>
                                                <tr>                                                    
                                                    <th width="10%" style="text-align: center">Sr.no.</th>
                                                    <th width="20%" style="text-align: center">Date</th>
                                                    <th width="40%" style="text-align: center">IP</th>
                                                    <th width="10%" style="text-align: center">City</th>
                                                    <th width="10%" style="text-align: center">State</th>
                                                    <th width="10%" style="text-align: center">Country</th>
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
                                                <asp:Label ID="Label1" runat="server" Text='<%#Convert.ToDateTime(Eval("visitDate")).ToString("dd-MM-yyyy hh:mm tt")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("ipAddress")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center;;vertical-align: middle">
                                                <asp:Label ID="Label0" runat="server" Text='<%#Eval("city").ToString() == "" ? "-" : Eval("city")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("state").ToString() == "" ? "-" : Eval("state")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label6" runat="server" Text='<%#Eval("country").ToString() == "" ? "-" : Eval("country")%>'></asp:Label>
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
