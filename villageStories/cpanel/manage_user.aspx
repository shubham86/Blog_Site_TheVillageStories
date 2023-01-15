<%@ Page Title="Manage User" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="manage_user.aspx.cs" Inherits="villageStories.cpanel.manage_user" %>
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
                width: 70%;
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
        function validateForm() {    
            if (document.getElementById('<%=txtFullName.ClientID%>').value == "") {
                document.getElementById("lblFullName").style.display = "block";
                document.getElementById('<%=txtFullName.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUserName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById("lblPassword").style.display = "block";
                document.getElementById('<%=txtPassword.ClientID%>').focus();
                return false;
            }
            else {
                document.getElementById("loader").style.display = "block";
            }
        }

        function hideFullNamelbl() {
            document.getElementById("lblFullName").style.display = "none"
        }
        function hideUserNamelbl() {
            document.getElementById("lblUserName").style.display = "none"
        }
        function hidePasswordlbl() {
            document.getElementById("lblPassword").style.display = "none"
        }

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
            <h2>Manage User</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li>
                    <a href="javascript:void(0)">Manage User</a>
                </li>
                <li class="active">
                    <strong>Add User Details</strong>
                    <asp:Label ID="lblUserID" runat="server" Text="0" Font-Size="1" ForeColor="Transparent"></asp:Label>
                </li>
            </ol>
        </div>
        <div class="col-lg-2">
        </div>
    </div>
    <div class="wrapper wrapper-content animated fadeInRight" style="width: 95%">
        <div class="row">
            <div class="col-lg-12">
                <div id="loader">
                    <img id="loader-image" src="../assets/img/loading.gif" width="100"/>
                </div>
                <div class="ibox float-e-margins">
                    <div class="row">
                        <div class="ibox-content">
                            <div class="form-horizontal" style="margin-top: 10px">
                               <div class="form-group col-lg-12">
                                   <div class="col-sm-2"></div>
                                    <label class="col-sm-2 control-label">Full Name</label>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="txtFullName" runat="server" class="form-control" onkeypress="hideFullNamelbl()"></asp:TextBox>
                                        <label id="lblFullName" class="error">Please enter full name</label>
                                    </div>
                                   <div class="col-sm-2"></div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <div class="col-sm-2"></div>
                                    <label class="col-sm-2 control-label">User Name</label>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="txtUserName" runat="server" class="form-control" onkeypress="hideUserNamelbl()"></asp:TextBox>
                                        <label id="lblUserName" class="error">Please enter user Name</label>
                                        <div class="col-sm-2"></div>
                                    </div>
                                    <div class="col-sm-1"></div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <div class="col-sm-2"></div>
                                    <label class="col-sm-2 control-label">Password</label>
                                    <div class="col-sm-6">
                                        <asp:TextBox ID="txtPassword" runat="server" class="form-control" onkeypress="hidePasswordlbl()"></asp:TextBox>
                                        <label id="lblPassword" class="error">Please enter password</label>
                                        <div class="col-sm-2"></div>
                                    </div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <div class="col-sm-2"></div>
                                    <label class="col-sm-2 control-label">Role</label>
                                    <div class="col-sm-4">
                                        <asp:DropDownList ID="ddlRole" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="1" Text="Admin"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Manager"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-4"></div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4"></div>
                                    <div class="col-lg-4" style="text-align: center; margin-top: 10px">
                                        <asp:Button ID="btnUserSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClientClick="return validateForm()" Width="30%" OnClick="btnUserSave_Click" />
                                        <asp:Button ID="btnUserCancel" runat="server" CssClass="btn btn-white" Text="Cancel" Width="30%" OnClick="btnUserCancel_Click" />
                                    </div>
                                    <div class="col-lg-4"></div>
                                </div>

                                <div class="hr-line-dashed"></div>

                                <input type="text" class="form-control input-sm m-b-xs" id="filter" placeholder="Search in table">
                                <asp:Repeater ID="rptrUser" runat="server" OnItemCommand="rptrUser_RowCommand">
                                    <HeaderTemplate>
                                        <table class="footable table table-stripped" data-page-size="15" data-filter="#filter">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center">Sr.no.</th>
                                                    <th style="text-align: center">Name</th>
                                                    <th style="text-align: center">User Name</th>
                                                    <th style="text-align: center">Password</th>
                                                    <th style="text-align: center">Role</th>
                                                    <th style="text-align: center">Action</th>
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
                                                <asp:Label ID="Label0" runat="server" Text='<%#Eval("fullName")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label4" runat="server" Text='<%#Eval("userName")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("password")%>'></asp:Label>
                                            </td>
                                            <td style="text-align: center; vertical-align: middle">
                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("userRole")%>'></asp:Label>
                                            </td>
                                            <td class="center" style="text-align: center; vertical-align: middle">
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="img/edit.png" ToolTip="Edite Blog" Width="18" Height="18" CommandArgument='<%#Eval("userID") + ";" + Eval("fullName") + ";" + Eval("userName") + ";" + Eval("password") + ";" + Eval("userRole")%>' CommandName="edit" />&nbsp &nbsp
                                                <asp:ImageButton ID="imgbtnRentOut" runat="server" ImageUrl='<%#Eval("isActive").ToString() == "1" ? "img/tickIcon_green.png" : "img/crossIcon_red.png"%>' ToolTip='<%#Eval("isActive").ToString() == "1" ? "Make Inactive" : "Make Active"%>' Width="18" Height="18" CommandArgument='<%#Eval("userID")%>' CommandName="status" OnClientClick="return confirm('Are you sure you want to change status?')" />
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

