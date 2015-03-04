<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Cab Application</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/styles.css" rel="stylesheet">
	</head>
	<body onload="refreshDash();">
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
            <p class="navbar-text">Enterprise Project Cab</p>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
           <li><a href="Home.jsp">Dashboard</a></li>
			<li><a href="booking.htm">Booking</a></li>
            <li><a href="setting.htm">Settings</a></li>
            <li><a href="#">Help</a></li>
            <li><a href="logout">Logout</a></li>
          </ul>
         </div>
      </div>
</nav>
<%
boolean flag=false;
if(session.getAttribute("userid")!=null){
	flag=true; 
}
/* String UserId=session.getAttribute("userid").toString();
boolean isAdmin=false;
int count=0;
for(int i=0;i<UserId.length();i++)
{
	if(Character.isDigit(UserId.charAt(i))||Character.isLetter(UserId.charAt(i)))
	{
		count++;
	}
}
if(count<UserId.length())
{
	isAdmin=true;
} */
if(!flag)
{
%>
<form action="login">
	<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
   <div class="modal-dialog" id="modd">
      <div class="modal-content">
         <div class="modal-header">
		    
            <h4 class="modal-title" id="myModalLabel">
               <font size="3">Enterprise Project Cab</font>
            </h4>
         </div>
         <div class="modal-body">
            <table>
			<tr>
				<td><label><b>Enter your Associate Id<font color="red">*</font>&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;&nbsp;</b></label></td>
				<td><input type="text" name="userId" placeholder="Your Associate Id" class="form-control" style="width:250px;" /></td>
			</tr>
			</table>
			
         </div>
         <div class="modal-footer">
           <!--  <button type="button" class="btn btn-primary" data-dismiss="modal">
               Submit
            </button> -->
            <input type="submit" value="Submit" class="btn btn-primary" />
            
         </div>
      </div>
   </div>
</div>

	
</form>
<%}%>
<form class="form-dashboard">

<%
String name="";
if(session.getAttribute("username")!=null){
	name=(String)session.getAttribute("username"); 

%>
<font style="text-align: center;"><%="Welcome "+name%></font>
<%} %>
<br/>
	

    <div class="col-sm-8 col-md-12 main">
    
           <div class="row">
    
		 <div class="col-md-4 col-sm-4">
                    <div class="panel panel-info">
                        <div class="panel-heading">
                            DASHBOARD
                        </div>

                  <div class="panel-body scrollpanel" style="height:460px" id="dashboard">
              		

                  </div><!-- /panel-body -->
              </div><!-- /panel -->
	
          
          </div>
		   
		   <div class="col-lg-8 col-right">
		   <div id="page-wrapper" >
            <div id="page-inner">
                                        
            <div class="row">
                    <div class="panel panel-primary" style="height:500px;width:812px">
                        <div class="panel-heading">
                            CAB INFORMATION
                        </div>
                        <div class="panel-body scrollpanel" style="height:455px" >
						<table id="tbody">
							
								<!-- <tr>
								  <td><b>Cab Number : </b></td>
								  <td>9239</td>
								  <td>&nbsp;&nbsp;&nbsp;</td>
								  <td>&nbsp;&nbsp;&nbsp;</td>
								  <td><b>Cab Timing : </b></td>
								  <td>07:30 PM</td> 
								</tr> 
								<tr>
								  <td><b>Cab Driver Name : </b></td>
								  <td>Pappu</td>
								  <td>&nbsp;&nbsp;&nbsp;</td>
								  <td>&nbsp;&nbsp;&nbsp;</td>
								  <td><b>Cab Driver Number : </b></td>
								  <td>9876541230</td>
								</tr>
								<tr>
								  <td><b>Cab Direction : </b></td>
								  <td>South</td>
								  <td>&nbsp;&nbsp;&nbsp;</td>
								  <td>&nbsp;&nbsp;&nbsp;</td>
								  <td><b>Cab Route : </b></td>
								  <td>Ruby</td>
								</tr> -->
							
						</table>
							<br/>
						<table class="table" id="usertable">
						<!-- 	<tbody>
								<tr>
								  
								  <th>Associate Id</th>
								  <th>Associate Name</th>
								  <th>Associate Phone Number</th>
								  <th>Associate Email</th>
								  <th></th>
								</tr>
								<tr>
								  
								  <td>389777</td>
								  <td>Suresh Shivale</td>
								  <td>9869564272</td>
								  <td>example@cognizant.com</td>
								  <td></td>
								</tr>  
								<tr>
								  
								  <td>426169</td>
								  <td>Saikat Bhattacharya</td>
								  <td>9831791558</td>								  
								  <td>example1@cognizant.com</td>
								  <td></td>
								</tr>
								<tr>
								  
								  <td>426146</td>
								  <td>Subhodip Dutta</td>	 
								  <td>8272563698</td>
								  <td>example2@cognizant.com</td>	
								  <td>
								  <a href="booking.htm"><img class="addIcon" width="20" height="20" style="display:inline;" title="" alt="Add Icon" 
									src="images/add.png" data-original-title="Click to add Associate"></a>
								  </td>								  
								</tr>
							</tbody> -->	
						</table>
					       
					 </div>       
				 </div> 
			</div>
		  
		  
		  </div><!-- // page wraper -->
		</div>
	  </div>

     
	</div>
	
</form>
<hr>
<footer>

  <p class="text-center">�2014 Cognizant Technology Solutions</p>
</footer>
        
	<!-- script references -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/scripts.js"></script>
		
<script>
   $(function () { 
    $('#myModal').modal({});
     var winH = $(window).height();
	 var winW = $(window).width();

	// Set the popup window to center
	$('#modd').css('top', winH / 3.5 - $('#modd').height()/2);
	$('#modd').css('left', (winW / 2 - $('#modd').width())-($('#modd').width()/7));
	 
   
   });
   function refreshDash() {
	  
	     $.ajax({
	       url : 'refreshdash',
	       method : 'get',
	       ContentType : 'json',
	       data : {
	    	 
	       },
	       success : function(response) {
	    	   
	    	   var div = '';
	    	   var width=0;
		         if (response != null) {
		           $(response).each(function(index, value) {
		        	   var info=value.cabNum+"|"+value.cabTime+"|"+value.cabRoute;
		 			width=(value.seatCount/value.cabCapacity)*100;
		             div = div +'<button type="button" class="btn btn-link btn-sm" onclick="getCabClickInfoUser(\'' + info + '\');"><font size="2">'+value.cabNum+' - <font color="green">'+value.cabTime+' PM</font> - <font color="#ed9c28">'+value.cabRoute+'</font></font></button>'+ 
         			'<div class="progress">'+
    				 '<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width:'+width+'%">'+
         			 '</div>'+'</div>'
		             
		             
		           });
		           div=div+'<button type="button" class="btn btn-warning btn-sm" onclick="refresh()">Refresh Dashboard</button>';
		           $('#dashboard').html(div);
		          
		         }
		         refreshCabTableData();
		         refreshUserTableData();
	       }
	     });
	   }
   function refreshCabTableData()
   {
	   
	   $.ajax({
	       url : 'refreshCabTableData',
	       method : 'get',
	       ContentType : 'json',
	       data : {
	    	 
	       },
	  success : function(response) {
		    	   
		    	   var div = '';
			         if (response != null) {
			          
			          var obj=JSON.parse(JSON.stringify(response));
			          div='<tr>'+
					  '<td><b>Cab Number : </b></td>'+
					  '<td>'+obj.cabNumber+'</td><td>&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td><td><b>Cab Timing : </b></td>'+
					  '<td>'+obj.cabTime+' PM</td>' +'</tr>'+
					  '<tr>'+
					  '<td><b>Cab Driver Name : </b></td>'+
					  '<td>'+obj.cabDriverName+'</td><td>&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td><td><b>Cab Driver Number : </b></td>'+
					  '<td>'+obj.cabDriverPhone+'</td>' +'</tr>'+
					  '<tr>'+
					  '<td><b>Cab Direction : </b></td>'+
					  '<td>'+obj.cabDirection+'</td><td>&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td><td><b>Cab Route :: </b></td>'+
					  '<td>'+obj.cabRoute+'</td>' +'</tr>'; 
			          $('#tbody').html(div);
			          
			         }
		       }
		    });
   }
	function refreshUserTableData()
	{
		 $.ajax({
		       url : 'refreshUserTableData',
		       method : 'get',
		       ContentType : 'json',
		       data : {
		    	 
		       },
		  success : function(response) {
			    	   
			    	   var div = '';
			    	   var data='';
			    	   var tab='<tr><th>Associate Id</th><th>Associate Name</th><th>Associate Phone Number</th><th>Associate Email</th><th></th></tr>';
				         if (response != null) 
				         {
				        	 
				        	 $(response).each(function(index, value) {
				        		 div=div+'<tr><td>'+value.userId+'</td><td>'+value.userName+'</td><td>'+value.userPhone+'</td><td>'+value.userEmail+'</td><td></td></tr>' 
				        	 });
				        	 data=tab+div;
				        	 $('#usertable').html(data);
				         }
				         else
				        	{
				        		data=tab;
				        		$('#usertable').html(data);
				        	}
			       }
			    });
	}
	function getCabClickInfoUser(s)
	{
		 var cabnum=s.substr(0,s.indexOf("|"));
		 var rest=s.substr(s.indexOf("|")+1);
		 var cabTime=rest.substr(0,rest.indexOf("|"));
		 var cabRoute=rest.substr(rest.indexOf("|")+1);
		 $.ajax({
		       url : 'getCabClickInfoUser',
		       method : 'get',
		       ContentType : 'json',
		       data :"cabNum="+cabnum+"&cabRoute="+cabRoute+"&cabTime="+cabTime,
		  	   success : function(response) { 
		  		 var div = '';
		    	 var data='';
		    	 var tab='<tr><th>Associate Id</th><th>Associate Name</th><th>Associate Phone Number</th><th>Associate Email</th><th></th></tr>';
				        if (response != null) 
				         {
				        	$('#usertable').html('');
				        	 $(response).each(function(index, value) {
				        		 div=div+'<tr><td>'+value.userId+'</td><td>'+value.userName+'</td><td>'+value.userPhone+'</td><td>'+value.userEmail+'</td><td></td></tr>' 
				        	 });
				        	 data=tab+div;
				        	 $('#usertable').html(data);
				         }
				        else
				        	{
				        		data=tab;
				        		$('#usertable').html(data);
				        	}
			       }
		 		
			    });
		 getCabClickInfoCab(s);
	}
	function getCabClickInfoCab(s)
	{
		 var cabnum=s.substr(0,s.indexOf("|"));
		 var rest=s.substr(s.indexOf("|")+1);
		 var cabTime=rest.substr(0,rest.indexOf("|"));
		 var cabRoute=rest.substr(rest.indexOf("|")+1);
		 $.ajax({
		       url : 'getCabClickInfoCab',
		       method : 'get',
		       ContentType : 'json',
		       data :"cabNum="+cabnum+"&cabRoute="+cabRoute+"&cabTime="+cabTime,
		  	   success : function(response) { 
		  		 		var div = '';
				        if (response != null) 
				         {
				        	$('#tbody').html('');
				        	var obj=JSON.parse(JSON.stringify(response));
					          div='<tr>'+
							  '<td><b>Cab Number : </b></td>'+
							  '<td>'+obj.cabNumber+'</td><td>&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td><td><b>Cab Timing : </b></td>'+
							  '<td>'+obj.cabTime+' PM</td>' +'</tr>'+
							  '<tr>'+
							  '<td><b>Cab Driver Name : </b></td>'+
							  '<td>'+obj.cabDriverName+'</td><td>&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td><td><b>Cab Driver Number : </b></td>'+
							  '<td>'+obj.cabDriverPhone+'</td>' +'</tr>'+
							  '<tr>'+
							  '<td><b>Cab Direction : </b></td>'+
							  '<td>'+obj.cabDirection+'</td><td>&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td><td><b>Cab Route :: </b></td>'+
							  '<td>'+obj.cabRoute+'</td>' +'</tr>'; 
					          $('#tbody').html(div);
				         }
			       }
			    });
		
	}
</script>
	</body>
</html>
