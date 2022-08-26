<%@page import="com.tech.blogs.entities.Category"%>
<%@page import="com.tech.blogs.dao.PostDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blogs.helper.DBConnection"%>
<%@page import="com.tech.blogs.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.tech.blogs.entities.User"%>
<%@ page errorPage="error.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>

<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
	<%
	User user = (User) session.getAttribute("currentUser");
	if (user == null) {
		response.sendRedirect("login.jsp");
	}
	%>

	<!-- starting navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-asterisk"></span>Technical Blogs</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="fa fa-bell-o"></span> Learn Code<span class="sr-only">(current)</span></a>
				</li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="	fa fa-check-square-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Data Structure</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Project Implementation</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="	fa fa-address-book-o"></span> Contact</a></li>
				<li class="nav-item"><button type="submit" data-toggle="modal"
						data-target="#add-post-modal"
						class="btn btn-danger text-dark nav-link" href="#"
						style="width: 70px; height: 35px;">
						<span class="fa fa-external-link"></span> Post
					</button></li>
			</ul>

			<ul class="navbar-nav mr-right">
				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile_Model"><img
						src="pics/<%=user.getProfilePic()%>" class="img-fluid"
						style="border-radius: 50%; max-width: 25px;"> <%=user.getName()%></a></li>
				<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
						class="fa fa-sign-out"></span>Logout</a></li>
			</ul>
		</div>
	</nav>

	<!--  end of navbar -->

	<%
	Message m = (Message) session.getAttribute("msg");

	if (m != null) {
	%>
	<div class="alert <%=m.getCssClass()%>" role="alert">
		<%=m.getContent()%>
	</div>

	<%
	session.removeAttribute("msg");
	}
	%>


	<!--  start of main body of the page -->

	<main>
		<div class="container">
			<div class="row">
				<div class="col-md-4 mt-4">

					<div class="list-group ">
						<a href="#" onclick="getPost(0,this)"  class="c-link list-group-item list-group-item-action active">
							All Posts </a>
					</div>
					<%
				PostDAO daoPost =new PostDAO(DBConnection.getDBConnection());
				ArrayList<Category> list1 = daoPost.getAllCategory();
					for (Category c : list1) {
					%>
					<div class="list-group">
						<a href="#" onclick="getPost(<%=c.getCategoryId()%>,this)"  class=" c-link list-group-item list-group-item-action"> <%=c.getCategoryName()%>
						</a>
					</div>
					<%
					}
					%>
					
				
					<div class="container mt-4 text-center form-control primary-background">
					  <div class="card form-control">
					  <div class="card-header primary-background ">Donate Us</div>
					  <div class="card-body">
					    <input type="text" name="payment" id="payment_field" placeholder="Enter amount to Pay" class="form-control">
					  </div> 
					  <div class="card-footer primary-background ">
					    <button type="submit" onclick="paymentStart()"  class="btn btn-success" style="text-align: center;"><span class="form-control fa fa-rupee"/> Pay</button>
					  </div>
					  </div>	  
					</div>

				</div>
				<div class="col-md-8 text-center">
					<!-- 	 All posts -->
					<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3 class="mt-2">Loading...</h3>
					</div>
					<div class="container-fluid text-center mt-4" id="post-Container"></div>

				</div>
			</div>
		</div>
	</main>


	<!--end of main body of the page -->



	<!-- start of profile model -->


	<!-- Button trigger modal -->
	<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>
 -->
	<!-- Modal -->
	<div class="modal fade" id="profile_Model" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title ">User Profile</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfilePic()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 100px;"> <br>
						<h5 class="modal-title "><%=user.getName().toUpperCase()%></h5>
						<div id="profileDetail">
							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID:</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email:</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender:</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">About Yourself:</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered On:</th>
										<td><%=user.getDateTimestamp()%></td>
									</tr>
								</tbody>
							</table>
						</div>


						<!-- edit profile -->

						<div id="editProfile" style="display: none;">
							<h4>Edit Profile</h4>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>Id:</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Name:</td>
										<td><input type="text" class="form-control"
											name="editName" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Email:</td>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<td>Gender:</td>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<td>About:</td>
										<td><textarea class="form-control" name="editAbout"><%=user.getAbout()%></textarea>
										</td>
									</tr>
									<tr>
										<td><div>Select Pic:</div></td>
										<td><input type="file" class="form-control" name="pic">
										</td>
									</tr>
								</table>

								<div class="container">
									<button type="submit" class="btn btn-success">Save</button>
								</div>
							</form>
						</div>

					</div>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-btn" type="button" class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>


	<!-- end of profile model -->


	<!-- start of post modal -->


	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide Post
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="add-post-form" action="AddPost" method="post"
						enctype="multipart/form-data">

						<div class="form-group">
							<select class="form-control" name="categoryId">
								<option selected="disabled">---Select Category---</option>
								<%
								PostDAO postDAO = new PostDAO(DBConnection.getDBConnection());
								ArrayList<Category> list = postDAO.getAllCategory();
								for (Category c : list) {
								%>
								<option value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>

								<%
								}
								%>

							</select>

						</div>

						<div class="form-group">
							<input type="text" class="form-control" name="postTitle"
								placeholder="Enter title for post" />
						</div>
						<div class="form-group">
							<textarea class="form-control" name="postContent"
								placeholder="Enter content for post"></textarea>
						</div>
						<div class="form-group">
							<textarea class="form-control" name="postCode"
								placeholder="Enter program(if any) for post"></textarea>
						</div>
						<label>Select pic for Post</label>
						<div class="form-group">
							<input type="file" class="form-control" name="postPic" />
						</div>
						<div class="container text-center">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary text-center">Post</button>
						</div>
					</form>
				</div>
				<!-- <div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Post</button>
				</div> -->
			</div>
		</div>
	</div>



	<!-- end of post modal -->




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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
	<script src="js/myjavascript.js" type="text/javascript"></script>

	<script>
	$(document).ready(function() {
	    let editStatus = false
	    $("#edit-btn").click(function() {

		if (editStatus == false) {
		    $("#profileDetail").hide()
		    $("#editProfile").show()
		    editStatus = true
		    $(this).text("Back")
		} else {
		    $("#profileDetail").show()
		    $("#editProfile").hide()
		    editStatus = false
		    $(this).text("Edit")
		}

	    })

	})
    </script>

	<!-- add post JS -->

	<script>
	$(document)
		.ready(
			function() {

			    $("#add-post-form")
				    .on(
					    "submit",
					    function(event) {

						/*  this block of code get executed when form submitted */
						event.preventDefault();
						console
							.log("you clicked on submit post")
						let form = new FormData(this);

						//now requesting to server through ajax 
						$
							.ajax({
							    url : "AddPost",
							    type : 'POST',
							    data : form,
							    success : function(
								    data,
								    textStatus,
								    jqXHR) {
								//call when success
								console
									.log(data);
								if (data.trim() == 'done') {
								    swal(
									    "Good job!",
									    "Post has been successfully saved!!",
									    "success");
								} else {
								    swal(
									    "Error!!",
									    "Something went wrong!!",
									    "error");
								}
							    },
							    error : function(
								    jqXHR,
								    textStatus,
								    errorThrown) {
								// error
								swal(
									"Error!!",
									"Something went wrong!!",
									"error");

							    },
							    processData : false,
							    contentType : false
							})
					    })
			})
    </script>

	<!--  loading post through Ajax -->

	<script>
	
	function getPost(categoryId,tempLink) {

		$("#loader").show()
	    $("#post-Container").hide();
		
		$(".c-link").removeClass("active")
		$.ajax({

		    url : "loadPost.jsp",
		    data: {category_Id:categoryId},
		    success : function(data, textStatus, jqXHR) {
			console.log(data);
			$("#loader").hide();
			$("#post-Container").show();
			$("#post-Container").html(data);
			$(tempLink).addClass("active");
		    }

		})
	    }
	
	
	$(document).ready(function() {
	    /* alert("loading"); */
      let allPostReference = $(".c-link")[0];
	    getPost(0,allPostReference);
	})
    </script>
    
    <!-- create payment order -->
    <script type="text/javascript">
       
  
	
	const paymentStart = ()=>{
	    
	    console.log("payment started...")
	    let amount =$("#payment_field").val();
	    console.log(amount);
	    if(amount=='' || amount==null)
		{
		alert("Please enter amount")
		return;
		}
	    
	    $.ajax(
		    {
			url: 'PaymentServlet',
			data: {amount:amount,info:'order_request'},
			type: 'POST',
			success: function (response) {
			    console.log(response);
			    console.log(response.status);
			    if(response.status=="created")
				{
				//open payment form
				var options={
					
					key: "rzp_test_djE6sP6oJJMaf6",
					amount: response.amount,
					currency: 'INR',
					name: 'Technical Blogs',
					description: 'Donation',
					image:'http://localhost:8080/TechnicalBlogs/img/TechnicalBogs.jpg',
					order_id: response.id,
					handler: function (response){
					    console.log(response.razorpay_payment_id);
					    console.log(response.razorpay_order_id);
					    console.log(response.razorpay_signature);
					    console.log("Payment Successful");
					    swal(
						    "Good job!",
						    "Payment has been successfully done!!",
						    "success");
				},
				prefill: {
				    name: "SAIF ALAM",
				    email: "saif.tech1790@gmail.com",
				    contact: "7290859582"
				    },
				    notes: {
				    address: "Technical Blogs"
				    },
				    theme: {
				    color: "#3399cc"
				    }
				
				} ;
				var rzp1 = new Razorpay(options);
				rzp1.on('payment.failed', function (response){
				 console.log(response.error.code);
				 console.log(response.error.description);
				 console.log(response.error.source);
				 console.log(response.error.step);
				 console.log(response.error.reason);
				 console.log(response.error.metadata.order_id);
				 console.log(response.error.metadata.payment_id);
				});
				rzp1.open();
               }
			},
			error: function (error) {
			    console.log(error);
			}
		    });
	};
        
    </script>

</body>
</html>