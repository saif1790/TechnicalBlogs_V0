<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Page</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 66% 96%, 30% 100%, 0 95%, 0 0
		);
}
</style>
</head>
<body>
	<!-- navbar -->

	<%@include file="normal_navbar.jsp"%>

	<main class="primary-background banner-background p-5"
		style="padding-bottom: 80px">
		<div class="container">
			<div class="col-md-6 offset-md-3">
				<div class="card">

					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-3x fa-user-plus"></span> </br>Register here
					</div>
					<div class="card-body">
						<form action="register" method="post" id="reg">
							<div class="form-group">
								<label for="user_name">Username</label> <input type="text"
									class="form-control" id="exampleInputEmail1" name="username"
									aria-describedby="emailHelp" placeholder="Enter userName" required="required">
							</div>

							<div class="form-group">
								<label for="user_email">Email address</label> <input
									name="email" type="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email" required="required"> <small id="emailHelp"
									class="form-text text-muted">We'll never share your
									email with anyone else.</small>
							</div>


							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									name="password" type="password" class="form-control"
									id="exampleInputPassword1" placeholder="Password" required="required">
							</div>

							<div class="form-group">
								<label for="user_gender">Select Gender</label> </br> <input
									type="radio" id="gender" name="gender" value="Male" required="required">Male
								<input type="radio" id="gender" name="gender" value="Female" required="required">Female
							</div>
							<div class="form-group">
								<label for="user_info"></label> </br>
								<textarea class="form-control" rows="5" name="about"
									placeholder="Enter something about yourelf" value="null"></textarea>

							</div>

							<div class="form-check">
								<input type="checkbox" class="form-check-input" name="agreement"
									id="exampleCheck1"> <label
									class="form-check-label text-dark" for="exampleCheck1">agree
									trems & conditiont</label>
							</div>
							<div class="container text-center" id="loader"
								style="display: none;">
								<span class="fa fa-refresh fa-spin fa-3x text=center"></span>
								<h4>Please wait...</h4>
							</div>
							</br>
							<button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="js/myjavascript.js" type="text/javascript"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js">
	</script>


	<script>

	/*   $(document).ready(function () {
	      
	      console.log("loaded..")
	      $('#reg').on('submit',function(event){
		  event.preventDefault();
		  
		  let form = new FormData(this);
		   console.log(form);
		   
		   $.ajax({
		       url : "RegisterServlet", 
		       type : 'POST',
			    data : form,
		       success : function (data,textStatus, jqXHR) {
			   console.log(data);
			   $("#submit-btn").show();
			   $("#loader").hide();
			   swal("Registration Successfully Submitted!!! & we are redireting to Login.jsp page")
			   .then((value) => {
			       window.location="login.jsp";
			   });
		    },
		    error :function (jqXHR,textStatus, errorThrown) {
			console.log(jqXHR);
			   $("#submit-btn").show();
			   $("#loader").hide();
			   swal("Something went wrong!!")
		    },
		    processData : false,
		    contentData : false
		   });
		  
	      });
	}); */ 
	  var form = $('#reg');
	  form.submit(function (event) {
	      event.preventDefault(); 
	   $("#submit-btn").hide();
	   $("#loader").show()
	      
	  $.ajax({
	  type: 'POST',
	  url: "RegisterServlet",
	  data: form.serialize(),
	  success : function (data,textStatus, jqXHR) {
	      
	      if(data.trim()=="not checked")
		  {
		  swal(
			    "Error!!",
			    "Please accept terms n condition!!",
			    "error");
		  $("#submit-btn").show();
		   $("#loader").hide()
		  }
	      else{
		   console.log(data);
		   $("#submit-btn").show();
		   $("#loader").hide();
		   swal("Registration Successfully Submitted!!! & we are redireting to Login.jsp page")
		   .then((value) => {
		       window.location="login.jsp";
		   });
		      
	    }},
	    error :function (jqXHR,textStatus, errorThrown) {
		console.log(jqXHR);
		   $("#submit-btn").show();
		   $("#loader").hide();
		   swal("Something went wrong!!")
	    },
	    processData : false,
	    contentData : false
	  
	  });
	   
	  });
    </script>
</body>
</html>