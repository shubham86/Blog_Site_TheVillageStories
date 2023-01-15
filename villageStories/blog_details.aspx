<%@ Page Title="" Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeBehind="blog_details.aspx.cs" Inherits="villageStories.blog_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <meta id="twtTitle" runat="server" property="twitter:title"/>
    <meta id="twtDesc" runat="server" property="twitter:description"/>
    <meta id="twtImg" runat="server" property="twitter:image"/>    
    <meta id="twtURL" runat="server" property="twitter:url"/>    
    <meta property="twitter:image:width" content="1200" />
    <meta property="twitter:image:height" content="630" />

    <meta id="ogTitle" runat="server" property="og:title"/>
    <meta id="ogDesc" runat="server" property="og:description"/>
    <meta id="ogImg" runat="server" property="og:image"/>
    <meta id="ogURL" runat="server" property="og:url"/>
    <meta property="og:image:width" content="1200" />
    <meta property="og:image:height" content="630" />

    <style>
        .composs-secondary-title {
            display: block;
            padding: 15px 0px;
            border-bottom: 2px solid #f2f2f2;
            border-top: 2px solid #f2f2f2;
            margin: 30px 0;
        }

        .children {
            border: none !important;
            padding-bottom: 0 !important;
            margin-bottom: 0 !important;
        }

        .slider-cat {
            padding: 4px 5px;
            color: #fff;
            position: absolute;
            z-index: 10;
            right: 0%;
            background-color: #94be30;
            font-size: 10px;
            font-weight: normal;
        }

        .slider-share {
            color: #fff;
            position: absolute;
            z-index: 10;
            right: 0%;
            background-color: #94be30;
            font-size: 14px;
            font-weight: normal;
            border-radius: 34px;
            padding: 2px 5px;
            box-shadow: 0px 0px 12px #ffffff;
            margin: 5px 5px 0 0;
        }

        #btnShare {
            color: #ffffff;
        }

        .modal-dialog {
            width: 300px;
            margin: 20% auto;
        }

        .modal-header {
            text-align: center;
            padding-bottom: 0;
        }
    </style>
    <script>
        function validateForm() {
            if (document.getElementById('<%=txtName.ClientID%>').value == "") {
                document.getElementById("lblName").style.display = "block";
                document.getElementById('<%=txtName.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtMobile.ClientID%>').value == "") {
                document.getElementById("lblMobile").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtMobile.ClientID%>').value.length < 10) {
                document.getElementById("lblMobile1").style.display = "block";
                document.getElementById('<%=txtMobile.ClientID%>').focus();
                return false;
            }
            else if (document.getElementById('<%=txtComment.ClientID%>').value == "") {
                document.getElementById("lblComment").style.display = "block";
                document.getElementById('<%=txtComment.ClientID%>').focus();
                return false;
            }
            else {
                document.getElementById("loader").style.display = "block";
            }
        }


        function hideNamelbl() {
            document.getElementById("lblName").style.display = "none";
        }

        function hideCommentlbl() {
            document.getElementById("lblComment").style.display = "none";
        }

        function hideAlert() {
            document.getElementById('<%=pnlCommentAlert.ClientID%>').style.display = "none";
        }

        function scrollToComment() {
            document.getElementById('commentForm').scrollIntoView();
        }

        function isNumberKey(evt, obj) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) return false;

            document.getElementById("lblMobile").style.display = "none";
            document.getElementById("lblMobile1").style.display = "none";
            return true;
        }

        function shareWhatsapp() {
            window.open("https://api.whatsapp.com/send?text=" + window.location.href);
        }

        function shareFB() {
            window.open("http://www.facebook.com/share.php?u=" + window.location.href);
        }

        function shareMail() {
            window.location = "mailto:?subject=" + "" + "&body=" + "The vilage Stories Article" + "%0A" + window.location.href;
        }

        function share() {
            const title = "The vilage Stories Article";
            const text = document.getElementById("ContentPlaceHolder1_lblBlogTitle").innerHTML;
            const url = window.location.href;

            if (navigator.share !== undefined) {
                navigator
                    .share({
                        title,
                        text,
                        url
                    })
                    .then(() => console.log("Shared!"))
                    .catch(err => console.error(err));
            } else {
                document.getElementById("MyPopup").style.display = "block";
                document.getElementById("MyPopup").style.opacity = "1";
            }
        }

        function popupClose() {
            document.getElementById("MyPopup").style.display = "none";
            document.getElementById("MyPopup").style.opacity = "0";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Modal Popup -->
    <div id="MyPopup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <b>Share On</b>
                    <button type="button" class="close" data-dismiss="modal" onclick="popupClose()">
                        &times;</button>
                </div>
                <div class="modal-body" style="text-align: center">
                    <div>
                        <a href="javascript:shareWhatsapp()" target="_blank">
                            <img src="images/wa.jpg" width="30" />
                        </a>
                        <a href="javascript:shareFB()">
                            <img src="images/fb.png" width="30" />
                        </a>
                        <a href="javascript:shareMail()">
                            <img src="images/mail.png" width="30" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <!-- Modal Popup -->
    <!-- BEGIN .content -->
    <div class="content">

        <!-- BEGIN .wrapper -->
        <div class="wrapper">

            <div class="content-wrapper">

                <!-- BEGIN .composs-main-content -->
                <div class="composs-main-content composs-main-content-s-1">

                    <div class="theiaStickySidebar">

                        <!-- BEGIN .composs-panel -->
                        <div class="composs-panel">

                            <!-- <div class="composs-panel-title">
										<strong>Blog page style #1</strong>
									</div> -->

                            <div class="composs-panel-inner">

                                <div class="composs-main-article-content">
                                    <div class="composs-main-article-head">                                        
                                        <div class="composs-main-article-media">
                                            <span class="slider-share">
                                                <a id="btnShare" onclick="share()" href="javascript:void(0)"><i class="material-icons">share</i></a>
                                            </span>
                                            <img id="imgHeadingPhoto" runat="server" />
                                        </div>
                                        <h1 style="padding-top: 10px;">
                                            <asp:Label ID="lblBlogTitle" runat="server"></asp:Label>
                                        </h1>
                                        <div class="composs-main-article-meta">
                                            <span class="item"><i class="material-icons">access_time</i>
                                                <asp:Label ID="lblBlogDate" runat="server"></asp:Label>
                                            </span>
                                            <a href="javascript:void(0);" class="item">
                                                <i class="material-icons">chat_bubble_outline</i>
                                                <asp:Label ID="lblCommentsCount" runat="server"></asp:Label>
                                                Comments</a>
                                            <span class="item">
                                                <i class="material-icons">folder_open</i>
                                                <a id="aCategory" runat="server">
                                                    <asp:Label ID="lblCategory" runat="server"></asp:Label>
                                                </a>
                                            </span>
                                            <span class="item">
                                                <i class="material-icons">mode_edit</i>
                                                <asp:Label ID="lblAuthor" runat="server"></asp:Label>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="shortcode-content">
                                        <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                    </div>

                                    <div class="composs-comments">
                                        <div class="composs-secondary-title">
                                            <a href="#commentForm" class="right composs-button">Leave a comment</a>
                                            <strong>
                                                <i class="material-icons">comment</i>
                                                <asp:Label ID="lblCommentCount" runat="server"></asp:Label>
                                                Comments                                                
                                            </strong>
                                        </div>
                                        <div class="comment-list">
                                            <ol id="comments">
                                                <asp:Repeater ID="rptComments" runat="server">
                                                    <ItemTemplate>
                                                        <li class="comment">
                                                            <div class="comment-block">
                                                                <a href="#" class="image-avatar">
                                                                    <img src="images/user.jpg" alt="" />
                                                                </a>
                                                                <div class="comment-text">
                                                                    <span class="time-stamp right">
                                                                        <asp:Label ID="lblCommentDate" runat="server" Text='<%# Convert.ToDateTime(Eval("commentDate")).ToString("dd MMMM yyyy")%>'></asp:Label>
                                                                    </span>
                                                                    <strong class="user-nick">
                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("visitorName")%>'></asp:Label>
                                                                    </strong>
                                                                    <div class="shortcode-content">
                                                                        <p>
                                                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("comment")%>'></asp:Label>
                                                                        </p>
                                                                    </div>
                                                                    <div id="divReply" runat="server" class="comment-block children" visible='<%# Eval("reply").ToString() == "" ? false : true %>'>
                                                                        <a href="#" class="image-avatar">
                                                                            <img src="images/logo.png" alt="" />
                                                                        </a>
                                                                        <div class="comment-text">
                                                                            <span class="time-stamp right">
                                                                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("replyDate").ToString() == "" ? "" : Convert.ToDateTime(Eval("replyDate")).ToString("dd MMMM yyyy")%>'></asp:Label>
                                                                            </span>
                                                                            <strong class="user-nick">The Village Stories<span class="user-label">Author</span></strong>
                                                                            <div class="shortcode-content">
                                                                                <p>
                                                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("reply")%>'></asp:Label>
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ol>
                                        </div>
                                    </div>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div class="composs-comments" id="commentForm">
                                                <div id="loader">
                                                    <img id="loader-image" src="cpanel/img/loading.gif" width="100" />
                                                </div>
                                                <div class="composs-secondary-title">
                                                    <!-- <a href="#comments" class="right composs-button">all responses</a> -->
                                                    <strong><i class="material-icons">mode_edit</i>Leave a comment</strong>
                                                </div>
                                                <div class="comment-form">
                                                    <div id="respond" class="comment-respond">
                                                        <div class="comment-form">
                                                            <div class="comment-info">
                                                                <strong>Your data will be safe!</strong>
                                                                <span>Your mobile number will not be published. Also other data will not be shared with third person.</span>
                                                            </div>

                                                            <div runat="server" id="pnlCommentAlert" visible="false" class="alert-message ot-shortcode-alert-message">
                                                                <button type="button" class="close" onclick="hideAlert()"><span aria-hidden="true">&times;</span></button>
                                                                <strong>
                                                                    <asp:Label ID="lblCommentAlert" runat="server"></asp:Label></strong>
                                                            </div>
                                                            <div class="contact-form-content">
                                                                <p class="contact-form-user">
                                                                    <label class="label-input">
                                                                        <span>Name<i class="required">*</i></span>
                                                                        <input id="txtName" runat="server" type="text" placeholder="Full Name" name="name" onkeypress="hideNamelbl()">
                                                                        <label id="lblName" class="error">Please enter your name.</label>
                                                                    </label>
                                                                </p>
                                                                <p class="contact-form-email">
                                                                    <label class="label-input">
                                                                        <span>Mobile Number<i class="required">*</i></span>
                                                                        <input id="txtMobile" runat="server" placeholder="Mobile Number" name="mobile" maxlength="10" onkeypress="javascript:return isNumberKey(event,this);">
                                                                        <label id="lblMobile" class="error">Please enter mobile number.</label>
                                                                        <label id="lblMobile1" class="error">Please enter valid mobile number.</label>
                                                                    </label>
                                                                </p>
                                                                <p class="contact-form-comment">
                                                                    <label class="label-input">
                                                                        <span>Comment text<i class="required">*</i></span>
                                                                        <textarea id="txtComment" runat="server" maxlength="500" name="comment" placeholder="Comment text" onkeypress="hideCommentlbl()"></textarea>
                                                                        <label id="lblComment" class="error">Please enter comment text..</label>
                                                                    </label>
                                                                </p>
                                                                <p class="form-submit">
                                                                    <asp:Button ID="btnComment" runat="server" CssClass="submit button" Text="Post a Comment" OnClientClick="return validateForm()" OnClick="btnComment_Click" />
                                                                </p>
                                                                <br />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>

                            </div>

                            <!-- END .composs-panel -->
                        </div>

                    </div>

                    <!-- END .composs-main-content -->
                </div>

                <!-- BEGIN #sidebar -->
                <aside id="sidebar" class="isfixedsidebar">

                    <div class="theiaStickySidebar">
                        <!-- BEGIN .widget -->
                        <div class="widget">
                            <h3>Tag Cloud</h3>
                            <div class="tagcloud">
                                <a href="blogs.aspx?category=चालू घडामोडी">चालू घडामोडी</a>
                                <a href="blogs.aspx?category=कृषीविषयक">कृषीविषयक</a>
                                <a href="blogs.aspx?category=संपादकीय">संपादकीय</a>
                                <a href="blogs.aspx?category=लोककथा">लोककथा</a>
                                <a href="blogs.aspx?category=भयकथा">भयकथा</a>
                                <a href="blogs.aspx?category=हास्यकथा">हास्यकथा</a>
                                <a href="blogs.aspx?category=शौर्यकथा">शौर्यकथा</a>
                                <a href="blogs.aspx?category=साहसकथा">साहसकथा</a>
                                <a href="blogs.aspx?category=रहस्यकथा">रहस्यकथा</a>
                                <a href="blogs.aspx?category=ललीतकथा">ललीतकथा</a>
                                <a href="blogs.aspx?category=मनोगत">मनोगत</a>
                                <a href="blogs.aspx?category=माहितीपट">माहितीपट</a>
                                <a href="blogs.aspx?category=चारोळी">चारोळी</a>
                                <a href="blogs.aspx?category=कविता">कविता</a>
                                <a href="blogs.aspx?category=कृषीविषयक">कृषीविषयक</a>
                            </div>
                        </div>
                        <!-- END .widget -->
                                                
                        
                    <!-- BEGIN .widget -->
                    <div class="widget">
                        <div class="widget-content">
                            <div id="advContainer" runat="server" class="adv-container" visible="false">
                                <a id="aVerticalAdv" runat="server" href="#" target="_blank">
                                    <span class="adv-notch">Ad</span>
                                    <img id="imgVerticalAdv" runat="server" class="adv-img" />
                                </a>
                            </div>
                            
                            <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                            <ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1115754064545893" data-ad-slot="5427981144" data-ad-format="auto" data-full-width-responsive="true" width: 300px; height: 250px"></ins>
                            <script> (adsbygoogle = window.adsbygoogle || []).push({}); </script>
                        </div>
                        <!-- END .widget -->
                    </div>

                        <!-- BEGIN .widget -->
                        <div class="widget">
                            <h3>Related articles</h3>
                            <div class="widget-content ot-w-article-list">
                                <asp:Repeater ID="rptRelatedPost" runat="server">
                                    <ItemTemplate>
                                        <div class="item">
                                            <div class="item-header">
                                                <strong class="slider-cat">
                                                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                </strong>
                                                <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                    <img src='<%#"cpanel/blogHeadingImg/" + (Eval("headingPhoto").ToString()  == "" ? "noImage.jpg" : Eval("headingPhoto"))  %>' class="small-heading-img" />
                                                </a>
                                            </div>
                                            <div class="item-content">
                                                <h4>
                                                    <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt32(Eval("postTitle").ToString().Length) >= 50 ? Eval("postTitle").ToString().Substring(0, 50) + "..." : Eval("postTitle").ToString() + "..." %>'></asp:Label>
                                                    </a>
                                                </h4>
                                                <span class="item-meta">
                                                    <span class="item-meta-item"><i class="material-icons">access_time</i>
                                                        <asp:Label ID="Label2" runat="server" Text='<%#Convert.ToDateTime(Eval("date")).ToString("dd MMMM yyyy") %>'></asp:Label>
                                                    </span>
                                                </span>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>                                
                            </div>
                            <!-- END .widget -->
                        </div>
                    </div>

                    <!-- END #sidebar -->
                </aside>

            </div>

            <!-- END .wrapper -->
        </div>

        <!-- BEGIN .content -->
    </div>
</asp:Content>
