<%@ Page Title="Manage Advertise" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="manage_advertise.aspx.cs" Inherits="villageStories.cpanel.manage_advertise" %>
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
        <div class="col-lg-12">
            <h2>Manage Advertise</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li class="active">
                    <a href="javascript:void(0)"><strong>Manage Advertise</strong></a>
                </li>
            </ol>
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
                                            <asp:ImageButton ID="imgbtnAdd" runat="server" ImageUrl="img/add_record.png" Width="25px" Height="25px" ToolTip="Add New Advertise" OnClick="imgbtnadd_Click" />
                                        </div>
                                    </div>
                                </div>
                                <asp:Repeater ID="rptrAdvertise" runat="server" OnItemCommand="rptrAdvertise_RowCommand">
                                    <HeaderTemplate>
                                        <table class="footable table table-stripped" data-page-size="20" data-filter="#filter">
                                            <thead>
                                                <tr>                                                    
                                                    <th width="10%" style="text-align: center">Sr.no.</th>
                                                    <th width="20%" style="text-align: center">Date</th>
                                                    <th width="30%" style="text-align: center">Company Name</th>
                                                    <th data-hide="phone,tablet" width="20%" style="text-align: center">Status</th>
                                                    <th data-hide="phone,tablet" width="20%" style="text-align: center">Action</th>
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
                                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("companyName")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:ImageButton ID="imgbtnRentOut" runat="server" ImageUrl='<%#Eval("isActive").ToString() == "1" ? "img/tickIcon_green.png" : "img/crossIcon_red.png"%>' ToolTip='<%#Eval("isActive").ToString() == "1" ? "Make Inactive" : "Make Active"%>' Width="18" Height="18" CommandArgument='<%#Eval("advID")%>' CommandName="status" OnClientClick="return confirm('Are you sure you want to change status?')" />
                                            </td>
                                            <td class="center" style="text-align: center; vertical-align: middle">
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="img/edit.png" ToolTip="Edite Advertise" Width="18" Height="18" CommandArgument='<%#Eval("advID")%>' CommandName="edit" />&nbsp &nbsp
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="img/delete.png" ToolTip="Delete" Width="18" Height="18" CommandArgument='<%#Eval("advID")%>' CommandName="delete" OnClientClick="return confirm('Are you sure you want to delete?')" />
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
