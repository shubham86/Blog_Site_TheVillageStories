<%@ Page Title="Add Advertise" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="add_advertise.aspx.cs" Inherits="villageStories.cpanel.add_advertise" %>
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
            margin-top: 20px;
        }

        img:hover {
            cursor: copy;
        }

        .report-img {
            font-family: OpenSans;
            color: #FFFFFF;
            background-color: #cccccc;
            border: 1px solid #cccccc;
            border-radius: 5px;
            box-shadow: 0px 3px 0px #cccccc;
            position: relative;
            top: 0px;
            transition: all ease 0.1s;
        }

            .report-img:active {
                box-shadow: 0 1px 0 #cccccc;
                top: 1px;
            }

        .copy {
            display:none;
            background-color:dimgrey;
            border-radius:5px;
            color:white;
            padding:5px 10px;
            font-weight:normal;
        }

    </style>
    <script>
        function addValidateForm() {
            if (document.getElementById('<%=txtCompanyName.ClientID%>').value == "") {
                document.getElementById("lblCompanyName").style.display = "block";
                document.getElementById('<%=txtCompanyName.ClientID%>').focus();
                return false;
            }
            <%--else if (document.getElementById('<%=txtWebURL.ClientID%>').value == "") {
                document.getElementById("lblWebURL").style.display = "block";
                document.getElementById('<%=txtWebURL.ClientID%>').focus();
                return false;
            }--%>
            else {
                document.getElementById("loader").style.display = "block";
            }
        }


        function hideCompanyNamelbl() {
            document.getElementById("lblCompanyName").style.display = "none";
        }
        function hideWebURLlbl() {
            document.getElementById("lblWebURL").style.display = "none";
        }

        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);

        function isDecimalNumber(evt, c) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            var dot1 = c.value.indexOf('.');
            var dot2 = c.value.lastIndexOf('.');

            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            else if (charCode == 46 && (dot1 == dot2) && dot1 != -1 && dot2 != -1)
                return false;

            return true;
        }

        function isNumberKey(evt, obj) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;

            return true;
        }

        function previewFile1() {
            var preview1 = document.querySelector('#<%=Image1.ClientID %>');
            var file1 = document.querySelector('#<%=FileUpload1.ClientID %>').files[0];
            var reader1 = new FileReader();

            reader1.onloadend = function () {
                preview1.src = reader1.result;                
            }            

            if (file1) {
                reader1.readAsDataURL(file1);   
                document.querySelector('#<%=lblImg1.ClientID %>').innerHTML = document.querySelector('#<%=FileUpload2.ClientID %>').value.split(/(\\|\/)/g).pop()
            }
            else {
                preview1.src = "";
            }
        }
                
        function delete1click() {
            document.getElementById('<%=lblImg1.ClientID%>').innerHTML = "empty";
            document.getElementById('<%=Image1.ClientID %>').src = "";
        }

        function previewFile2() {
            var preview2 = document.querySelector('#<%=Image2.ClientID %>');
            var file2 = document.querySelector('#<%=FileUpload2.ClientID %>').files[0];
            var reader2 = new FileReader();

            reader2.onloadend = function () {
                preview2.src = reader2.result;                
            }            

            if (file2) {
                reader2.readAsDataURL(file2);   
                document.querySelector('#<%=lblImg2.ClientID %>').innerHTML = document.querySelector('#<%=FileUpload2.ClientID %>').value.split(/(\\|\/)/g).pop()
            }
            else {
                preview2.src = "";
            }
        }
                
        function delete2click() {
            document.getElementById('<%=lblImg2.ClientID%>').innerHTML = "empty";
            document.getElementById('<%=Image2.ClientID %>').src = "";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

    <asp:Panel ID="pnlAlert" runat="server" role="alert" Visible="false" style="margin-top:20px">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
    </asp:Panel>
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>Add Advertise</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li>
                    <a href="manage_advertise.aspx">Manage Advertise</a>
                </li>
                <li class="active">
                    <strong>Add Advertise</strong>
                    <asp:Label ID="lblAdvID" runat="server" Text="0" Font-Size="1" ForeColor="Transparent"></asp:Label>
                    <asp:TextBox ID="lblimgURL" runat="server" Text="" Font-Size="1" ForeColor="Transparent" BorderStyle="None"></asp:TextBox>
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
                    <img id="loader-image" src="img/loading.gif" width="100"/>
                </div>
                <div class="ibox float-e-margins">
                    <div class="row">
                        <div class="ibox-content">
                            <div class="form-horizontal" style="margin-top: 10px">
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Company Name</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtCompanyName" runat="server" class="form-control"  onkeypress="hideCompanyNamelbl()" MaxLength="150"></asp:TextBox>
                                        <label id="lblCompanyName" class="error">Please enter company name.</label>
                                    </div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Web URL</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtWebURL" runat="server" class="form-control" onkeypress="hideWebURLlbl()" MaxLength="200"></asp:TextBox>
                                        <label id="lblWebURL" class="error">Please enter website URL</label>
                                    </div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
                                    <asp:updatepanel id="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <label class="col-sm-3 control-label">Horizontal Image (728 X 90)</label>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="FileUpload1" accept="image/*" runat="server" class="form-control" onchange="previewFile1()" />
                                                <asp:Label ID="lblImg1" runat="server" ForeColor="White"></asp:Label>
                                                <asp:Label ID="lblOldName1" runat="server" ForeColor="White" Font-Size="1px"></asp:Label>
                                            </div>
                                            <div class="col-sm-1">
                                                <asp:ImageButton ID="btnDelet1" runat="server" ImageUrl="img/delete.png" OnClick="btnDelete1_Click" />
                                            </div>
                                            <div class="col-sm-4" style="text-align:center">
                                                <asp:Image ID="Image1" runat="server" Width="100%"/>
                                            </div>
                                        </ContentTemplate>
                                    </asp:updatepanel>
                                </div>
                                <div class="form-group col-lg-12">
                                    <asp:updatepanel id="UpdatePanel2" runat="server">
                                        <ContentTemplate>
                                            <label class="col-sm-3 control-label">Vertical Image (300 X 400)</label>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="FileUpload2" accept="image/*" runat="server" class="form-control" onchange="previewFile2()" />
                                                <asp:Label ID="lblImg2" runat="server" ForeColor="White"></asp:Label>
                                                <asp:Label ID="lblOldName2" runat="server" ForeColor="White" Font-Size="1px"></asp:Label>
                                            </div>
                                            <div class="col-sm-1">
                                                <asp:ImageButton ID="btnDelet2" runat="server" ImageUrl="img/delete.png" OnClick="btnDelete2_Click" />
                                            </div>
                                            <div class="col-sm-4" style="text-align:center">
                                                <asp:Image ID="Image2" runat="server" Width="100%" />
                                            </div>
                                        </ContentTemplate>
                                    </asp:updatepanel>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-4"></div>
                                    <div class="col-lg-4" style="text-align: center; margin-top: 10px">
                                        <asp:Button ID="btnBlogAdd" runat="server" Text="Save" CssClass="btn btn-primary" OnClientClick="return addValidateForm()" Width="30%" OnClick="btnBlogAdd_Click" />
                                        <asp:Button ID="btnBlogUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClientClick="return addValidateForm()" Width="30%" OnClick="btnBlogUpdate_Click" />
                                        <asp:Button ID="btnBlogCancel" runat="server" CssClass="btn btn-white" Text="Cancel" Width="30%" OnClick="btnBlogCancel_Click" />                                        
                                    </div>
                                    <div class="col-lg-4"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>