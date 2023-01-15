<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="villageStories.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>The Village Stories - Login</title>
    <link href="css/bootstrap.min.css" rel="stylesheet"/>
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet"/>

    <link href="css/animate.css" rel="stylesheet"/>
    <link href="css/style.css" rel="stylesheet"/>
    
     <!-- Favicon icon -->
    <link rel="shortcut icon" href="../assets/img/favicon.ico" type="image/x-icon" />
    <link rel="icon" href="../assets/img/favicon.ico" type="image/gif" sizes="16x16" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script>
        window.setTimeout(function () {
            $(".alert").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 4000);

        function validateForm() {
            if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUserName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').focus();
                return false;
            }

            if (document.getElementById('<%=txtPassword.ClientID%>').value == "") {
                document.getElementById("lblPassword").style.display = "block";
                document.getElementById('<%=txtPassword.ClientID%>').focus();
                return false;
            }
        }

        
        function forgetValidateForm() {
            if (document.getElementById('<%=txtUserName.ClientID%>').value == "") {
                document.getElementById("lblUserName").style.display = "block";
                document.getElementById('<%=txtUserName.ClientID%>').focus();
                return false;
            }

            return confirm('Are you sure, you forgot your password?');
        }

        function hideUserNamelbl() {
            document.getElementById("lblUserName").style.display = "none";
        }

        function hidePasswordlbl() {
            document.getElementById("lblPassword").style.display = "none";
        }

    </script>
</head>
<body class="gray-bg">
    <form id="form1" runat="server" autocomplete="off">
        <div id="middle-box" class="middle-box text-center loginscreen animated fadeInDown" style="padding-top:100px;">
            <div>
                <div>
                    <a runat="server" href="~/home"><img src="../images/logo.png" width="150"/></a>
                </div>
                <h3 style="margin-top:30px">Welcome</h3>
                <p>
                    
                </p>
                <p>Login in To see Admin Panel.</p>

                <asp:Panel ID="pnlAlert" runat="server" class="" role="alert" Visible="false">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <asp:Label ID="lblalert" runat="server" Text="" Font-Bold="true"></asp:Label>
                </asp:Panel>

                <div class="m-t" role="form">
                    <div class="form-group">
                        <asp:TextBox ID="txtUserName" runat="server" class="form-control" placeholder="Username" onkeypress="hideUserNamelbl()"></asp:TextBox>                        
                        <label id="lblUserName" class="error">Please enter Username !</label>
                    </div>
                    <div class="form-group">
                        <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" class="form-control" placeholder="Password" onkeypress="hidePasswordlbl()"></asp:TextBox>                        
                        <label id="lblPassword"  class="error">Please enter Password !</label>
                    </div>                    
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary block full-width m-b" OnClientClick="return validateForm()" OnClick="btnLogin_Click"/>  

                    <%--<a href="#" runat="server" onclick="return forgetValidateForm()"><small>Forgot password?</small></a>--%>
                    <div style="height:10px"></div>
                </div>
                <p class="m-t"><small>The Village Stories</small> </p>
            </div>
        </div>
    </form>

    <!-- Mainly scripts -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
