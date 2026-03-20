<!-- section footer start -->
    <%@page import="java.time.LocalDate"%>
<div class="section_footer mt-5">
    	<div class="container">
    		<div class="mail_section">
    			<div class="row">
    				<div class="col-sm-6 col-lg-3">
    					<div><a href="#"><img src="/footware/images/devansh.jpg"></a></div>
    				</div>
    				<div class="col-sm-6 col-lg-3">
    					<div class="footer-logo"><img src="/footware/images/phone-icon.png"><span class="map_text">(91) 9372105075</span></div>
    				</div>
    				<div class="col-sm-6 col-lg-3">
    					<div class="footer-logo"><img src="/footware/images/email-icon.png"><span class="map_text">devansh@gmail.com</span></div>
    				</div>
    				<div class="col-sm-2"></div>
    			</div>
    	    </div> 
    	    <div class="footer_section_2">
		        <div class="row">
    		        <div class="col-sm-4 col-lg-2">
    		        	<h2 class="shop_text">Address </h2>
    		        	<div class="image-icon"><img src="images/map-icon.png"><span class="pet_text">AT/POST: HELGOAN NEAR BY GANESH TEMPLE TAL: KARAD DIS: SATARA</span></div>
    		        </div>
    		        <div class="col-sm-4 col-md-6 col-lg-3">
    				    <h2 class="shop_text">Our Company </h2>
    				    <div class="delivery_text">
    				    	<ul>
    				    		<li>Delivery</li>
    				    		<li>Legal Notice</li>
    				    		<li>About us</li>
    				    		<li>Secure payment</li>
    				    		<li>Contact us</li>
    				    	</ul>
    				    </div>
    		        </div>
    			<div class="col-sm-6 col-lg-3">
    				<h2 class="adderess_text">Products</h2>
    				<div class="delivery_text">
    				    	<ul>
    				    		<li>Sports Shoes</li>
    				    		<li>Running Shoes</li>
    				    		<li>Best sales</li>
    				    		<li>Contact us</li>
    				    		<li>Sitemap</li>
    				    	</ul>
    				    </div>
    			</div>
    			</div>
    	        </div> 
	        </div>
    	</div>
    </div>
	<!-- section footer end -->
	<div class="copyright"><%=LocalDate.now().getYear() %> All Rights Reserved By Sahil & Avishkar</div>


      <!-- Javascript files-->
      <script src="/footware/js/jquery.min.js"></script>
      <script src="/footware/js/popper.min.js"></script>
      <script src="/footware/js/bootstrap.bundle.min.js"></script>
      <script src="/footware/js/jquery-3.0.0.min.js"></script>
      <script src="/footware/js/plugin.js"></script>
      <!-- sidebar -->
      <script src="/footware/js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="/footware/js/custom.js"></script>
      <!-- javascript --> 
      <script src="/footware/js/owl.carousel.js"></script>
      <script src="https:cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>
      <script src="/footware/js/jquery.validate.js"></script>
    <script src="/footware/js/additional-methods.js"></script>
      
      <script>
         $(document).ready(function(){
         $(".fancybox").fancybox({
         openEffect: "none",
         closeEffect: "none"
         });
         
         
$('#myCarousel').carousel({
            interval: false
        });

        //scroll slides on swipe for touch enabled devices

        $("#myCarousel").on("touchstart", function(event){

            var yClick = event.originalEvent.touches[0].pageY;
            $(this).one("touchmove", function(event){

                var yMove = event.originalEvent.touches[0].pageY;
                if( Math.floor(yClick - yMove) > 1 ){
                    $(".carousel").carousel('next');
                }
                else if( Math.floor(yClick - yMove) < -1 ){
                    $(".carousel").carousel('prev');
                }
            });
            $(".carousel").on("touchend", function(){
                $(this).off("touchmove");
            });
        });
      </script> 
   </body>
</html>