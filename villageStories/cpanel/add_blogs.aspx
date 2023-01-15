<%@ Page Title="Add Blogs" Language="C#" MasterPageFile="MasterCP.Master" AutoEventWireup="true" CodeBehind="add_blogs.aspx.cs" Inherits="villageStories.cpanel.add_blogs" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
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
        function copyAddress(address) {            
            document.getElementById('<%=lblimgURL.ClientID%>').value = address.src;
            var copyText = document.getElementById('<%=lblimgURL.ClientID%>');
            copyText.select();
            copyText.setSelectionRange(0, 99999);
            document.execCommand("copy");
            //document.getElementById("lblCopy").style.display = "block";
        }

        function imgUploadValidation() {
            if (document.getElementById('<%=txtImageTitle.ClientID%>').value == "") {
                document.getElementById("lblImageTitle").style.display = "block";
                document.getElementById('<%=txtImageTitle.ClientID%>').focus();
                document.getElementById('<%=FileUpload1.ClientID%>').disabled = true;
                return false;
            }
        }

        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID %>").click();
            }
        }

        function addValidateForm() {
            if (document.getElementById('<%=ddlCategory.ClientID%>').value == "0") {
                document.getElementById("lblDdlCategory").style.display = "block";
                document.getElementById('<%=ddlCategory.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtBlogTitle.ClientID%>').value == "") {
                document.getElementById("lblBlogTitle").style.display = "block";
                document.getElementById('<%=txtBlogTitle.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtSortPara.ClientID%>').value == "") {
                document.getElementById("lblSortPara").style.display = "block";
                document.getElementById('<%=txtSortPara.ClientID%>').focus();
                return false;
            }
            <%--if (document.getElementById('<%=txtCKEditor1.ClientID%>').value == "") {
                document.getElementById("lblPost").style.display = "block";
                document.getElementById("cke_ContentPlaceHolder1_txtCKEditor1").focus();
                return false;
            }--%>
            else {
                document.getElementById("loader").style.display = "block";
            }
        }

        function hideImgTitlelbl() {
            document.getElementById("lblImageTitle").style.display = "none";
            document.getElementById('<%=FileUpload1.ClientID%>').disabled = false;
        }

        function hideCategorylbl() {
            document.getElementById("lblDdlCategory").style.display = "none";
        }
        function hideSortParalbl() {
            document.getElementById("lblSortPara").style.display = "none";
        }
        function hideTitlelbl() {
            document.getElementById("lblBlogTitle").style.display = "none";
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
            var file1 = document.querySelector('#<%=FileUpload2.ClientID %>').files[0];
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"> 

    <asp:Panel ID="pnlAlert" runat="server" role="alert" Visible="false" style="margin-top:20px">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <asp:Label ID="lblAlert" runat="server" Text="" Font-Bold="true"></asp:Label>
    </asp:Panel>
    <div class="row wrapper border-bottom white-bg page-heading">
        <div class="col-lg-10">
            <h2>Add Blog</h2>
            <ol class="breadcrumb">
                <li>
                    <a href="Dashboard.aspx">Home</a>
                </li>
                <li>
                    <a href="manage_blogs.aspx">Manage Blog</a>
                </li>
                <li class="active">
                    <strong>Add Blog</strong>
                    <asp:Label ID="lblBlogID" runat="server" Text="0" Font-Size="1" ForeColor="Transparent"></asp:Label>
                    <asp:Label ID="lblKeyVal" runat="server" Text="0" Font-Size="1" ForeColor="Transparent"></asp:Label>
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
                                    <label class="col-sm-3 control-label">Blog Category</label>
                                    <div class="col-sm-6">
                                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" onclick="hideCategorylbl()">
                                            <asp:ListItem Text="All Category" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="चालू घडामोडी" Value="12"></asp:ListItem>
                                            <asp:ListItem Text="कृषीविषयक" Value="11"></asp:ListItem>
                                            <asp:ListItem Text="संपादकीय" Value="13"></asp:ListItem>
                                            <asp:ListItem Text="मनोगत" Value="7"></asp:ListItem>
                                            <asp:ListItem Text="माहितीपट" Value="8"></asp:ListItem>
                                            <asp:ListItem Text="लोककथा" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="भयकथा" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="हास्यकथा" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="शौर्यकथा" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="साहसकथा" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="रहस्यकथा" Value="6"></asp:ListItem>
                                            <asp:ListItem Text="ललीतकथा" Value="5"></asp:ListItem>
                                            <asp:ListItem Text="चारोळी" Value="9"></asp:ListItem>
                                            <asp:ListItem Text="कविता" Value="10"></asp:ListItem>
                                        </asp:DropDownList>
                                        <label id="lblDdlCategory" class="error">Please select category</label>
                                    </div>
                                    <div class="col-sm-4"></div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Blog Title</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtBlogTitle" runat="server" class="form-control"  onkeypress="hideTitlelbl()" MaxLength="300"></asp:TextBox>
                                        <label id="lblBlogTitle" class="error">Please enter blog title</label>
                                    </div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Short Discription</label>
                                    <div class="col-sm-9">
                                        <asp:TextBox ID="txtSortPara" runat="server" class="form-control" onkeypress="hideSortParalbl()" TextMode="MultiLine" Rows="6" MaxLength="1000"></asp:TextBox>
                                        <label id="lblSortPara" class="error">Please enter short discription</label>
                                    </div>
                                </div>
                                
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Blog Images (780 X 360)</label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtImageTitle" runat="server" class="form-control" placeholder="Image Title" onclick="hideImgTitlelbl()"></asp:TextBox>
                                        <label id="lblImageTitle" class="error">Please enter image title.</label>
                                    </div>
                                    <div class="col-sm-5">
                                        <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" accept="image/*" onchange="UploadFile(this)" onclick="imgUploadValidation()" />
                                        <asp:Button ID="btnUpload" Text="Upload" runat="server" OnClick="Upload" Style="display: none" />
                                    </div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <div class="col-sm-3">
                                        <label id="lblCopy" class="copy">Address Copied.</label></div>
                                    <div class="col-sm-9">
                                        <asp:DataList ID="rptImages" runat="server" RepeatDirection="Horizontal" OnItemCommand="rptImages_RowCommand">
                                            <ItemTemplate>
                                                <div style="width: 150px; text-align: center">
                                                    <div style="height: 130px; padding: 2px">
                                                        <img src='<%# "blogImg/" + Eval("imgURL") %>' class="report-img" width="100%" height="100%" title='<%# Eval("imgTitle") %>' onclick="copyAddress(this)" />
                                                    </div>
                                                    <div style="padding-top: 3px">
                                                        <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="img/delete.png" Width="20px" Height="20px" ToolTip="Delete" CommandName="delete" CommandArgument='<%# Eval("imgID") + ";" + Eval("imgURL") %>' />
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </div>
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Publish Date</label>
                                    <div class="col-sm-3">
                                        <asp:TextBox ID="txtPublishDate" TextMode="Date" runat="server" class="form-control" onkeypress='javascript:return false;'></asp:TextBox>
                                        <label id="lblPublishDate" class="error">Please enter publish date</label>
                                    </div>
                                    <label class="col-sm-2 control-label">Author Name</label>
                                    <div class="col-sm-4">
                                        <asp:TextBox ID="txtAuthor" runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                </div> 
                                <div class="form-group col-lg-12">
                                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <label class="col-sm-3 control-label">Blog Heading Image (780 X 360)</label>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="FileUpload2" accept="image/*" runat="server" class="form-control" onchange="previewFile1()" />
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
                                    </asp:UpdatePanel>
                                </div>
                                <div class="form-group col-lg-12">
                                    <label class="col-sm-3 control-label">Blog Post</label>
                                    <div class="col-sm-9">                                        
                                        <label id="lblPost" class="error">Please enter post details</label>
                                        <CKEditor:CKEditorControl ID="txtCKEditor1" runat="server" Height="700px" onkeypress=""></CKEditor:CKEditorControl>
                                    </div>
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
