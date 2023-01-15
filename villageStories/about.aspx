<%@ Page Title="About us" Language="C#" MasterPageFile="Master.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="villageStories.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>        
        function validateForm() {
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;   
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
            else if (document.getElementById('<%=txtEmail.ClientID%>').value == "") {
                document.getElementById("lblEmail").style.display = "block";
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }
            if (reg.test(document.getElementById('<%=txtEmail.ClientID%>').value) == false) {
                document.getElementById("lblEmail1").style.display = "block";
                document.getElementById('<%=txtEmail.ClientID%>').focus();
                return false;
            }
            else if(document.getElementById('<%=txtComment.ClientID%>').value == "") {
                document.getElementById("lblComment").style.display = "block";
                document.getElementById('<%=txtComment.ClientID%>').focus();
                return false;
            }
        }

        
        function hideNamelbl() {
            document.getElementById("lblName").style.display = "none";
        }

        function hideCommentlbl() {
            document.getElementById("lblComment").style.display = "none";
        }

        function hideEmaillbl() {
            document.getElementById("lblEmail").style.display = "none";
            document.getElementById("lblEmail1").style.display = "none";
        }

        function scrollToComment() {
            document.getElementById('commentForm').scrollIntoView();
        }

        function hideAlert() {            
            document.getElementById('<%=pnlCommentAlert.ClientID%>').style.display = "none";
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
    </script>
    <style>
        @media only screen and (max-width: 600px) {
            .ot-shortcode-paragraph-row > li:last-child, .ot-shortcode-paragraph-row > div:last-child, .paragraph-row > li:last-child, .paragraph-row > div:last-child {
                margin-bottom: 0;
                text-align: center !important;
            }
            h5 {
                font-size:22px !important;
            }
            .map-block .map-block-header {
                font-size:15px !important; 
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                            <strong>About us</strong>
                        </div>

                        <div class="composs-panel-inner">
                            <div class="map-block">
                                <div class="map-block-header" style="margin-bottom: 30px;">
                                    <h3>We are</h3>
                                    <div class="paragraph-row">
                                        <div class="column12">
                                            <p>खास ग्रामीण शैलीतील कथांची मेजवानी..!!</p>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="paragraph-row" style="border-bottom: 1px solid #cccccc; padding-bottom: 20px">
                                        <div class="column4" style="text-align: center;">
                                            <img src="images/nitesh.jpg" style="border-radius: 100px; width: 120px;" />
                                            <!-- <i class="material-icons large-icon">location_on</i> -->
                                        </div>
                                        <div class="column8">
                                            <h5>नितेश रणपिसे</h5>
                                            <p>Mechanical Engineering करून त्याच क्षेत्रात नोकरी करत सह्याद्री भटकंतीची आवड जपलीये, पण शेतकऱ्याचा मुलगा या नात्याने का म्हणाना पण गावच्या मातीशी, शेतीशी जुळलेली नाळ दिवसेंदिवस घट्ट होत जातीये, यातूनच लेखणीला आलेली थोडीफार धार.</p>
                                            <p class="about-media-icon">
                                                <a style="color:#8b949d; font-size:16px" href="mailto:nitesh.ranpise@thevillagestories.com">nitesh.ranpise@thevillagestories.com</a>                                                
                                                <a href="https://www.instagram.com/Clickz_nitesh/" target="_blank"><i class="fa fa-instagram"></i></a>
                                                <a href="https://twitter.com/nitesh2151" target="_blank"><i class="fa fa-twitter-square"></i></a>
                                                <a href="https://www.facebook.com/nitesh.ranpise" target="_blank"><i class="fa fa-facebook-square"></i></a>
                                            </p>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="paragraph-row" style="border-bottom: 1px solid #cccccc; padding-bottom: 20px">
                                        <div class="column4" style="text-align: center;">
                                            <img src="images/namdev.jpg" style="border-radius: 100px; width: 120px;" />
                                            <!-- <i class="material-icons large-icon">location_on</i> -->
                                        </div>
                                        <div class="column8">
                                            <h5>नामदेव गवळी</h5>
                                            <p>एका सालकर्याचा मुलगा ते स्वतः सालकरी ईथपर्यंतचा प्रवास फारच सुखासुखी होता असं अजिबात नाहीये.. गरीबीच्या , जातीभेदाच्या झळा नको तेवढ्या वाट्याला आलेल्या..तरीही कष्ट , जिद्द , चिकाटी आणि प्रामाणिकपणा या जीवनमूल्यांमुळे स्पर्धेच्या युगात कसाबसा तग धरुन उभा आहे..वाचनाची आवड बालपणापासूनच होती..जे मिळेल ते अधाशासारखं वाचून काढायचं..कौटुंबिक जबाबदाऱ्यांचं जोखडं सोळाव्या वर्षीच खांद्यावर असं रुतलयं की आता ते बाजूला केलं की भळभळती जखमं होईलं..या जगरहाटीत जी कलंदर आणि बिलंदर पात्र मला भेटत गेली त्यांना शब्दरुपात पुर्नजिवीत करण्याच्या नादात माझ्यातला लेखक जागा झाला. माझा पिंड गावकरी असल्याने ग्रामीण भागातील संपूर्ण घडामोडी कथास्वरुपात मांडण्याचा उद्देश या माध्यमातून सार्थ होत आहे.</p>
                                            <p class="about-media-icon">
                                               <a id="contact" style="color:#8b949d; font-size:16px" href="mailto:namdev.gavli@thevillagestories.com">namdev.gavli@thevillagestories.com</a>
                                                <a href="https://www.instagram.com/deva_2529/" target="_blank"><i class="fa fa-instagram"></i></a>
                                                <a href="https://twitter.com/@Namdevgavali11" target="_blank"><i class="fa fa-twitter-square"></i></a>
                                                <a href="https://www.facebook.com/namdev.gavali1" target="_blank"><i class="fa fa-facebook-square"></i></a>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- END .composs-panel -->
                    </div>

                    <!-- BEGIN .composs-panel -->
                    <div class="composs-panel">

                        <div class="composs-panel-title">
                            <strong>Contact us</strong>
                        </div>

                        <div class="row text-center">
                            <span style="border:1.5px solid #94be30;color:#94be30; border-radius:50px;padding:10px 12px">
                                <i class="fa fa-envelope"></i>
                            </span>                           
                            <a href="mailto:info@thevillagestories.com"><h5 style="margin-top:15px">info@thevillagestories.com</h5></a>
                            <a href="mailto:contact@thevillagestories.com"><h5>contact@thevillagestories.com</h5> </a>

                            <br />
                             <span style="border:1.5px solid #94be30;color:#94be30; border-radius:50px;padding:8px 12px">
                                <i class="fa fa-phone"></i>
                            </span>                           
                            <a href="tel:8698109777"><h5 style="margin-top:15px">+91 8698 10 9777</h5></a>
                            <a href="tel:8329872529"><h5 style="margin-top:15px">+91 8329 87 2529</h5></a>
                        </div>

                        <div class="composs-panel-title">
                            <strong>Enquiry</strong>
                        </div>

                        <div class="composs-panel-inner">
                            <div class="comment-form">
                                <div id="respond" class="comment-respond">

                                    <div id="loader">
                                        <img id="loader-image" src="cpanel/img/loading.gif" width="100" />
                                    </div>
                                    <div id="commentForm" class="comment-form">
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
                                            <p class="contact-form-email">
                                                <label class="label-input">
                                                    <span>Email<i class="required">*</i></span>
                                                    <input id="txtEmail" runat="server" placeholder="Email ID" name="email" onkeypress="hideEmaillbl()">
                                                    <label id="lblEmail" class="error">Please enter email id.</label>
                                                    <label id="lblEmail1" class="error">Please enter valid email id.</label>
                                                </label>
                                            </p>
                                            <p class="contact-form-comment">
                                                <label class="label-input">
                                                    <span>Comment text<i class="required">*</i></span>
                                                    <textarea id="txtComment" runat="server" maxlength="500" name="comment" placeholder="Message text" onkeypress="hideCommentlbl()"></textarea>
                                                    <label id="lblComment" class="error">Please enter comment text..</label>
                                                </label>
                                            </p>
                                            <p class="form-submit">
                                                <asp:Button ID="btnComment" runat="server" CssClass="submit button" Text="Send Message" OnClientClick="return validateForm()" OnClick="btnComment_Click" />
                                            </p>
                                        </div>
                                    </div>

                                </div>
                            </div>
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
