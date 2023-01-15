<%@ Page Title="" Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeBehind="blogs.aspx.cs" Inherits="villageStories.blogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>        
        .slider-cat {
            padding: 5px 10px;
            color: #fff;
            position: absolute;
            z-index: 10;
            right: 0%;
            background-color:#94be30;
            font-size: 13px;
            font-weight: normal;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content">
        <!-- BEGIN .wrapper -->
        <div class="wrapper">

            <div class="content-wrapper">

                <!-- BEGIN .composs-main-content -->
                <div class="composs-main-content composs-main-content-s-1">

                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">

                        <div class="composs-panel-title">
                            <strong>
                                <asp:Label ID="lblCategory" runat="server"></asp:Label></strong>
                        </div>

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="composs-panel-inner">

                                    <div class="composs-blog-list lets-do-1">
                                        <div runat="server" id="pnlBlogAlert" visible="false">
                                            <strong>
                                                <asp:Label ID="lblBlogAlert" runat="server"></asp:Label>
                                            </strong>
                                        </div>
                                        <asp:Repeater ID="rptBlogs" runat="server">
                                            <ItemTemplate>
                                                <div class="item">
                                                    <div class="item-header">
                                                        <span class="slider-cat">
                                                            <asp:Label ID="Label5" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                        </span>
                                                        <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                            <img src='<%#"cpanel/blogHeadingImg/" +  Eval("headingPhoto") %>' alt=""/>
                                                        </a>
                                                    </div>
                                                    <div class="item-content">
                                                        <h2>
                                                            <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt32(Eval("postTitle").ToString().Length) >= 70 ? Eval("postTitle").ToString().Substring(0, 70) + "..." : Eval("postTitle").ToString() + "..." %>'></asp:Label>
                                                            </a>

                                                        </h2>
                                                        <span class="item-meta">
                                                            <span class="item-meta-item"><i class="material-icons">access_time</i>
                                                                <asp:Label ID="Label2" runat="server" Text='<%#Convert.ToDateTime(Eval("date")).ToString("dd MMMM yyyy") %>'></asp:Label>
                                                            </span>
                                                            <a href="javscript:voide(0);" class="item-meta-item"><i class="material-icons">chat_bubble_outline</i>
                                                                <asp:Label ID="Label4" runat="server" Text='<%#Eval("comments") %>'></asp:Label>
                                                            </a>
                                                        </span>
                                                        <p>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# (Convert.ToInt32(Eval("shortDescription").ToString().Length) >= 170 && Convert.ToInt32(Eval("shortDescription").ToString().Length) > 0) ? Eval("shortDescription").ToString().Substring(0,170) + "..." : Eval("shortDescription").ToString() + "..." %>'></asp:Label>
                                                        </p>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                </div>

                                <div class="composs-panel-pager">
                                    <a class="prev page-numbers" href="#"><i class="fa fa-angle-double-left"></i>Previous</a>
                                    <asp:Repeater ID="rptPager" runat="server">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>' CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page-numbers" : "page-numbers current"%>' OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <a class="next page-numbers" href="#">Next<i class="fa fa-angle-double-right"></i></a>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <!-- END .composs-panel -->
                    </div>

                    <!-- END .composs-main-content -->
                </div>

                <!-- BEGIN #sidebar -->
                <aside id="sidebar">
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
                        <!-- END .widget -->

                    </div>
                   
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
                        <h3>Socialize</h3>
                        <div class="widget-content ot-w-socialize">
                            <a href="https://www.facebook.com/TheVillageStories/" class="ot-color-hover-facebook"><i class="fa fa-facebook"></i><span>Facebook</span></a>
                            <a href="#" class="ot-color-hover-instagram"><i class="fa fa-instagram"></i><span>Instagram</span></a> 
                            <a href="#" class="ot-color-hover-twitter"><i class="fa fa-twitter"></i><span>Twitter</span></a>
                            <a href="#" class="ot-color-hover-google-plus"><i class="fa fa-google-plus"></i><span>Google+</span></a>
                            <a href="https://www.youtube.com/channel/UCtBf2EG_VKSS3VDdpIoW4Rg" target="_blank" class="ot-color-hover-youtube"><i class="fa fa-youtube-play"></i><span>Youtube</span></a>
                        </div>
                        <!-- END .widget -->
                    </div>

                </aside>
                <!-- END .wrapper -->
            </div>

            <!-- BEGIN .content -->
        </div>
    </div>
    <%--<div class="content">
        <!-- BEGIN .wrapper -->
        <div class="wrapper">

            <div class="content-wrapper">

                <!-- BEGIN .composs-main-content -->
                <div class="composs-main-content">

                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">

                        <div class="composs-panel-title">
                            <strong>
                                <asp:Label ID="lblCategory" runat="server"></asp:Label>
                            </strong>
                        </div>

                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="composs-panel-inner">
                                    <div class="composs-blog-list lets-do-2">
                                        <div runat="server" id="pnlBlogAlert" visible="false" class="ot-shortcode-alert-message alert-message">
                                            <strong>
                                                <asp:Label ID="lblBlogAlert" runat="server"></asp:Label>
                                            </strong>
                                        </div>
                                        <asp:Repeater ID="rptBlogs" runat="server">
                                            <ItemTemplate>
                                                <div class="item">
                                                    <div class="item-header">
                                                        <span class="slider-cat">
                                                            <asp:Label ID="Label5" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                        </span>
                                                        <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                            <img src='<%#"cpanel/blogHeadingImg/" +  Eval("headingPhoto") %>' alt="" />
                                                        </a>
                                                    </div>
                                                    <div class="item-content">
                                                        <h2>
                                                            <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt32(Eval("postTitle").ToString().Length) >= 70 ? Eval("postTitle").ToString().Substring(0, 70) + "..." : Eval("postTitle").ToString() + "..." %>'></asp:Label>
                                                            </a>

                                                        </h2>
                                                        <span class="item-meta">
                                                            <span class="item-meta-item"><i class="material-icons">access_time</i>
                                                                <asp:Label ID="Label2" runat="server" Text='<%#Convert.ToDateTime(Eval("date")).ToString("dd MMMM yyyy") %>'></asp:Label>
                                                            </span>
                                                            <a href="javscript:voide(0);" class="item-meta-item"><i class="material-icons">chat_bubble_outline</i>
                                                                <asp:Label ID="Label4" runat="server" Text='<%#Eval("comments") %>'></asp:Label>
                                                            </a>
                                                        </span>
                                                        <p>
                                                            <asp:Label ID="Label3" runat="server" Text='<%# (Convert.ToInt32(Eval("shortDescription").ToString().Length) >= 170 && Convert.ToInt32(Eval("shortDescription").ToString().Length) > 0) ? Eval("shortDescription").ToString().Substring(0,170) + "..." : Eval("shortDescription").ToString() + "..." %>'></asp:Label>
                                                        </p>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>

                                </div>

                                <div class="composs-panel-pager">
                                    <a class="prev page-numbers" href="#"><i class="fa fa-angle-double-left"></i>Previous</a>
                                    <asp:Repeater ID="rptPager" runat="server">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>' CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page-numbers" : "page-numbers current"%>' OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <a class="next page-numbers" href="#">Next<i class="fa fa-angle-double-right"></i></a>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <!-- END .composs-panel -->
                    </div>

                    <!-- END .composs-main-content -->
                </div>

            </div>

            <!-- END .wrapper -->
        </div>

        <!-- BEGIN .content -->
    </div>--%>
</asp:Content>
