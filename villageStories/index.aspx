<%@ Page Title="The Village Stories" Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="villageStories.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">   
    <meta id="head_twtTitle" property="twitter:title" content="The Village Stories" />
    <meta id="head_twtDesc" property="twitter:description" content="खास ग्रामीण शैलीतील कथांची मेजवानी..!!" />
    <meta id="head_twtImg" property="twitter:image" content="https://thevillagestories.com/images/logo.png" />    
    <meta id="head_twtURL" property="twitter:url" content="https://thevillagestories.com" />    
    <meta property="twitter:image:width" content="1200" />
    <meta property="twitter:image:height" content="630" />

    <meta id="head_ogTitle" property="og:title" content="The Village Stories" />
    <meta id="head_ogDesc" property="og:description" content="खास ग्रामीण शैलीतील कथांची मेजवानी..!!" />
    <meta id="head_ogImg" property="og:image" content="https://thevillagestories.com/images/logo.png" />
    <meta id="head_ogURL" property="og:url" content="https://thevillagestories.com" />
    <meta property="og:image:width" content="1200" />
    <meta property="og:image:height" content="630" />

    <style>
        .composs-panel-pager {
            border-top:0;
            padding-top:0;
        }
        .slider-cat {
            padding: 5px 10px;
            color: #fff;
            position: absolute;
            z-index: 10;
            right: 0%;
            background-color:#94be30;
            font-size: 16px;
            font-weight: normal;
        }
        .recent .owl-carousel .owl-item {
            width:239px !important;
        }
        .small-heading-img {
            width:90px !important;
            height:63px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BEGIN .main-slider -->
    <div class="main-slider main-slider-smaller">
        <!-- BEGIN .wrapper -->
        <div class="wrapper">
            <div class="main-slider-owl">
                <div runat="server" id="pnlMainSliderAlert" visible="false" class="ot-shortcode-alert-message alert-message">
                    <strong><asp:Label ID="lblMainSliderError" runat="server"></asp:Label></strong>
                </div>
                <asp:Repeater ID="rptMainSlider" runat="server">
                    <ItemTemplate>
                        <div class="item">
                            <strong class="slider-cat">
                                <asp:Label ID="Label3" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                            </strong>
                            <a runat="server" href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>' class="main-slider-owl-title">    
                                <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt32(Eval("postTitle").ToString().Length) >= 70 ? Eval("postTitle").ToString().Substring(0, 70) + "..." : Eval("postTitle").ToString() + "..." %>'></asp:Label>
                            </a>
                            <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>' class="main-slider-owl-calendar">
                                <strong>
                                    <i class="material-icons">access_time</i>
                                    <asp:Label ID="Label2" runat="server" Text='<%#Convert.ToDateTime(Eval("date")).ToString("dd MMMM yyyy") %>'></asp:Label>
                                </strong>
                            </a>
                            <img src='<%#"cpanel/blogHeadingImg/" +  (Eval("headingPhoto").ToString() == "" ? "noImage.jpg" : Eval("headingPhoto")) %>' height="420 " alt="" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <!-- END .wrapper -->
        </div>
        <!-- BEGIN .main-slider -->
    </div>

    <!-- BEGIN .content -->
    <div class="content">
        <!-- BEGIN .wrapper -->
        <div class="wrapper">
            <div class="content-wrapper">
                <!-- BEGIN .composs-main-content -->
                <div class="composs-main-content composs-main-content-s-1">
                    
                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">
                        <div class="composs-panel-title">
                            <strong style="border-bottom: 0px !important">Most recent articles</strong>
                        </div>
                        <div class="composs-panel recent">
                            <div class="composs-panel-tab">
                                <div class="composs-article-list lets-do-3 lets-do-slider">
                                    <div runat="server" id="pnlRecentPostAlert" visible="false" class="ot-shortcode-alert-message alert-message">
                                        <strong>
                                            <asp:Label ID="lblRecentPostError" runat="server"></asp:Label>
                                        </strong>
                                    </div>
                                    <asp:Repeater ID="rptRecentPost" runat="server">
                                        <ItemTemplate>
                                            <div class="item">
                                                <div class="item-header">
                                                    <span class="slider-cat">
                                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                    </span>
                                                    <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>' class="main-slider-owl-calendar">
                                                        <img src='<%#"cpanel/blogHeadingImg/" +  (Eval("headingPhoto").ToString() == "" ? "noImage.jpg" : Eval("headingPhoto")) %>' alt="" height="180"/>
                                                    </a>
                                                </div>
                                                <div class="item-content">
                                                    <h2>
                                                        <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>' class="main-slider-owl-calendar">                                                            
                                                            <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt32(Eval("postTitle").ToString().Length) >= 70 ? Eval("postTitle").ToString().Substring(0, 70) + "..." : Eval("postTitle").ToString() + "..." %>'></asp:Label>
                                                        </a>
                                                    </h2>
                                                    <span class="item-meta">
                                                        <span class="item-meta-item"><i class="material-icons">access_time</i>
                                                            <asp:Label ID="Label2" runat="server" Text='<%#Convert.ToDateTime(Eval("date")).ToString("dd MMMM yyyy") %>'></asp:Label>
                                                        </span>
                                                        <a href="javascript:void(0);" class="item-meta-item"><i class="material-icons">chat_bubble_outline</i>
                                                            <asp:Label ID="Label4" runat="server" Text='<%#Eval("comments") %>'></asp:Label>
                                                        </a>
                                                    </span>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        
                        <%--<div id="btnRecentMore" runat="server" class="composs-panel-pager">
                            <a href="blog" class="composs-pager-button" title="View More"><i class="fa fa-angle-double-down" aria-hidden="true"></i></a>
                        </div>--%>
                        <!-- END .composs-panel -->
                    </div>
                    
                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">
                        <div class="composs-panel-title">
                            <strong>चालू घडामोडी</strong>
                        </div>
                        <div class="composs-panel-inner">
                            <div class="composs-blog-list lets-do-1">
                                <div runat="server" id="pnlThirdAlert" visible="false" class="ot-shortcode-alert-message alert-message">
                                    <strong>
                                        <asp:Label ID="lblThirdAlert" runat="server"></asp:Label>
                                    </strong>
                                </div>
                                <asp:Repeater ID="rptThird" runat="server">
                                    <ItemTemplate>
                                        <div class="item">
                                            <div class="item-header">
                                                <span class="slider-cat">
                                                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                </span>
                                                <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                    <img src='<%#"cpanel/blogHeadingImg/" + (Eval("headingPhoto").ToString()  == "" ? "noImage.jpg" : Eval("headingPhoto"))%>' height="175"/>
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
                                                    <a href="javascript:void(0);" class="item-meta-item"><i class="material-icons">chat_bubble_outline</i>
                                                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("comments") %>'></asp:Label>
                                                    </a>
                                                </span>
                                                <p>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# (Convert.ToInt32(Eval("shortDescription").ToString().Length) >= 300 && Convert.ToInt32(Eval("shortDescription").ToString().Length) > 0) ? Eval("shortDescription").ToString().Substring(0, 300) + "..." : Eval("shortDescription").ToString() + "..." %>'></asp:Label>
                                                </p>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                        </div>

                        <div class="composs-panel-pager">
                            <a id="btnThirdMore" runat="server" href="blogs.aspx?category=चालू घडामोडी" class="composs-pager-button" title="View More"><i class="fa fa-angle-double-down" aria-hidden="true"></i></a>
                        </div>
                        <!-- END .composs-panel -->
                    </div>

                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">

                        <div class="composs-panel-title">
                            <strong style="border-bottom: 0px !important">कथा</strong>
                        </div>

                        <div class="composs-panel">
                            <div class="composs-panel-tab">
                                <div class="composs-article-split-block">
                                    <div runat="server" id="pnlSecondAlert" visible="false" class="ot-shortcode-alert-message alert-message">
                                        <strong>
                                            <asp:Label ID="lblSecondAlert" runat="server"></asp:Label>
                                        </strong>
                                    </div>
                                    <div id="divSecondLarge" runat="server" class="item-large">
                                        <div class="item">
                                            <div class="item-header">
                                                <strong class="slider-cat">
                                                    <asp:Label ID="lblSeconCategory" runat="server"></asp:Label>
                                                </strong>
                                                <a id="aSecondimgURL" runat="server">
                                                    <img runat="server" id="imgSecond" /></a>
                                            </div>
                                            <div class="item-content">
                                                <h2>
                                                    <a id="aSecondLink" runat="server">
                                                        <asp:Label ID="lblSecondTitle" runat="server"></asp:Label>
                                                    </a>
                                                </h2>
                                                <span class="item-meta">
                                                    <span class="item-meta-item"><i class="material-icons">access_time</i>
                                                        <asp:Label ID="lblSecondDate" runat="server"></asp:Label>
                                                    </span>
                                                    <a href="#" runat="server" class="item-meta-item"><i class="material-icons">chat_bubble_outline</i>
                                                        <asp:Label ID="lblSecondComment" runat="server"></asp:Label>
                                                    </a>
                                                </span>
                                                <p>
                                                    <asp:Label ID="lblSecondDetail" runat="server"></asp:Label>
                                                </p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="item-small">
                                        <asp:Repeater ID="rptSecond" runat="server">
                                            <ItemTemplate>
                                                <div class="item">
                                                    <div class="item-header">
                                                        <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>' class="img-read-later-button rm-btn-small">
                                                            <asp:Label ID="Label3" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                        </a>

                                                        <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                            <img src='<%#"cpanel/blogHeadingImg/" + (Eval("headingPhoto").ToString()  == "" ? "noImage.jpg" : Eval("headingPhoto"))  %>' class="small-heading-img" />
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
                                                        </span>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>                        

                        <div class="composs-panel-pager">
                            <a id="btnSecondMore" runat="server" href="story-blogs.aspx" class="composs-pager-button" title="View More"><i class="fa fa-angle-double-down" aria-hidden="true"></i></a>
                        </div>
                        <!-- END .composs-panel -->
                    </div>
                    
                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">

                        <div class="composs-panel-title">
                            <strong style="border-bottom: 0px !important">कृषीविषयक</strong>
                        </div>
                        <div class="composs-panel-inner">
                            <div class="composs-article-split-block">
                                <div class="item-large">
                                    <div runat="server" id="pnlFourthAlert" visible="false" class="ot-shortcode-alert-message alert-message">
                                        <strong>
                                            <asp:Label ID="lblFourthAlert" runat="server"></asp:Label>
                                        </strong>
                                    </div>
                                    <asp:Repeater ID="rptFourth" runat="server">
                                        <ItemTemplate>
                                            <div class="item">
                                                <div class="item-header">
                                                    <span class="slider-cat">
                                                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("category") %>'></asp:Label>
                                                    </span>
                                                    <a href='<%#"blog_details.aspx?ID=" +  Eval("postID") %>'>
                                                        <img src='<%#"cpanel/blogHeadingImg/" + (Eval("headingPhoto").ToString()  == "" ? "noImage.jpg" : Eval("headingPhoto"))%>'/>
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
                                                        <a href="javascript:void(0);" class="item-meta-item"><i class="material-icons">chat_bubble_outline</i>
                                                            <asp:Label ID="Label4" runat="server" Text='<%#Eval("comments") %>'></asp:Label>
                                                        </a>
                                                    </span>
                                                    <p>
                                                        <asp:Label ID="Label5" runat="server" Text='<%# (Convert.ToInt32(Eval("shortDescription").ToString().Length) >= 200 && Convert.ToInt32(Eval("shortDescription").ToString().Length) > 0) ? Eval("shortDescription").ToString().Substring(0, 200) + "..." : Eval("shortDescription").ToString() + "..." %>'></asp:Label>
                                                    </p>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>

                            </div>

                        </div>

                        <div class="composs-panel-pager">
                            <a id="btnFourthMore" runat="server" href="blogs.aspx?category=कृषीविषयक" class="composs-pager-button" title="View More"><i class="fa fa-angle-double-down" aria-hidden="true"></i></a>
                        </div>
                        <!-- END .composs-panel -->
                    </div>

                    <!-- END .composs-main-content -->
                </div>

                <!-- BEGIN #sidebar -->
                <aside id="sidebar">
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

                    <!-- BEGIN .widget -->
                    <div class="widget">
                        <div class="widget-content">
                            <div id="advContainer" runat="server" class="adv-container" visible="false">
                                <a id="aVerticalAdv" runat="server" href="#" target="_blank">
                                    <span class="adv-notch">Ad</span>
                                    <img id="imgVerticalAdv" runat="server" class="adv-img" style="width: 100%" />
                                </a>
                            </div>
                            
                            <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                            <ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1115754064545893" data-ad-slot="5427981144" data-ad-format="auto" data-full-width-responsive="true" width: 300px; height: 250px"></ins>
                            <script> (adsbygoogle = window.adsbygoogle || []).push({}); </script>
                        </div>
                        <!-- END .widget -->
                    </div>

                    <!-- BEGIN .widget -->
                    
                    
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

                    <!-- END #sidebar -->
                </aside>

            </div>

            <!-- END .wrapper -->
        </div>

        <!-- BEGIN .content -->
    </div>
</asp:Content>
