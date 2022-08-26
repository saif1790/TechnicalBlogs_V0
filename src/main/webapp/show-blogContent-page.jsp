<%@page import="com.tech.blogs.entities.Like"%>
<%@page import="com.tech.blogs.dao.LikeDAO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blogs.dao.UserDAO"%>
<%@page import="com.tech.blogs.helper.DBConnection"%>
<%@page import="com.tech.blogs.dao.PostDAO"%>
<%@page import="com.tech.blogs.entities.Post"%>
<%@page import="com.tech.blogs.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page errorPage="error.jsp"%>
<%@page import="com.tech.blogs.entities.Category"%>
<%@page import="java.util.ArrayList"%>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>

<%
int postId = Integer.parseInt(request.getParameter("postId"));
PostDAO postDAO = new PostDAO(DBConnection.getDBConnection());
Post post = postDAO.getPost_ByPostID(postId);
int userId = post.getUserId();
UserDAO userDAO = new UserDAO(DBConnection.getDBConnection());
User postByUser = (User) userDAO.getUser_ByUserID(userId);
%>

<html>
<head>
<title><%=post.getPostTitle()%>||Technical Blogs</title>
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 100%, 66% 96%, 30% 100%, 0 95%, 0 0
		);
}

.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-content {
	font-weight: 100;
	font-size: 25px;
}

.post-user-info {
	font-size: 20px;
	font-weight: 200;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}
</style>

<!-- //facebook comment plugin -->
<!-- <div id="fb-root"></div>
<script async defer crossorigin="anonymous"
	src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v14.0&appId=755600397875063&autoLogAppEvents=1"
	nonce="jzHhR9Ce"></script>
</head> -->
<body>

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
				<li class="nav-item active"><a class="nav-link"
					href="profile.jsp"><span class="fa fa-bell-o"></span> Learn
						Code<span class="sr-only">(current)</span></a></li>
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


	<!-- main content of the body -->

	<div class="container ">
		<div class="row my-4">
			<div class="col-md-6 offset-md-3">
				<div class="card">

					<div class="card-header  primary-background  text-center">
						<h3 class="post-title"><%=post.getPostTitle()%></h3>
					</div>
					<div class="card-body">
						<img class="card-img-top" src="Blog_pics/<%=post.getPostPic()%>"
							alt="Card image cap"></br>

						<div class="row">
							<div class="col-md-7">
								<p class="post-user-info">
									Posted By :<span><img
										src="pics/<%=postByUser.getProfilePic()%>" class="img-fluid"
										style="border-radius: 50%; max-width: 25px;"></span><a href="#"><%=postByUser.getName()%></a>
								</p>

							</div>
							<div class="col-md-5">
								<p class="post-date">
									Posted On :
									<%=post.getPostDate().toLocaleString()%></p>

							</div>
						</div>
						<p class="post-content"><%=post.getPostContent()%></p>
						</br> </br>
						<div class="post-code">
							<pre><%=post.getPostCode()%></pre>
						</div>
					</div>
					<%
					LikeDAO likeDAO = new LikeDAO(DBConnection.getDBConnection());
					%>
					<div class="card-footer primary-background text-left">
						<a href="#!"
							onclick="doLike(<%=post.getPostId()%>,<%=user.getId()%>)"
							class="btn btn-outline-light btn-sm"> <i
							class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=likeDAO.countLikesOnPost(post.getPostId())%></span></a>
						<%-- <a
							href="show-blogContent-page.jsp?postId=<%=post.getPostId() %>"
							class="btn btn-outline-light btn-sm">Read More...</a> --%>
						<a href="#!" class="btn btn-outline-light btn-sm"><i
							class="fa fa-commenting-o"></i><span>20</span></a>
					</div>
					<%-- <div class="card-footer primary-background">
						<div class="fb-comments"
							data-href="http://localhost:8080/TechnicalBlogs/show-blogContent-page.jsp?postId=<%=post.getPostId()%>"
							data-width="" data-numposts="5"></div>

					</div> --%>

				</div>

			</div>
		</div>
	</div>




	<!--end of main body -->




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
										<td><input type="email" class="form-control"
											name="editEmail" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Gender:</td>
										<td><div class="text-left">
												<input type="radio" id="gender" name="gender" value="Male">Male
												<input type="radio" id="gender" name="gender" value="Female">Female
											</div></td>
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
						<label>Select your pic</label>
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

	<!-- js for likes -->
	<script type="text/javascript">
    
        function doLike(postId,userId)
        {
	       console.log(postId,userId);
	       const d=
	       {
		      postId: postId,
		      userId: userId,
		      operation: 'like'
	       }
	       
	       $.ajax({
		    
		   url: "LikeServlet",
		   data: d,
		   success: function (data,textStatus,jqXHR) {
		    console.log(data);
		    if(data.trim()== "true")
			{
			let c = $(".like-counter").html();
			    c++;
			$(".like-counter").html(c);
			}
		    else{
			$(".like-counter").html("Liked");
		    }
		},
		error: function (jqXHR,textStatus,errorThrown) {
		    console.log(data);
		}
		   
	       })
	   } 
    </script>

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
</body>
</html>