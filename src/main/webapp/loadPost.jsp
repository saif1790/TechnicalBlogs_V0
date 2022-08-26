<%@page import="com.tech.blogs.dao.LikeDAO"%>
<%@page import="com.tech.blogs.entities.User"%>
<%@page import="com.tech.blogs.dao.UserDAO"%>
<%@page import="com.tech.blogs.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blogs.helper.DBConnection"%>
<%@page import="com.tech.blogs.dao.PostDAO"%>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>

<div class="row">
	<%
	Thread.sleep(1000);
	PostDAO postDao = new PostDAO(DBConnection.getDBConnection());
	List<Post> listPost = null;
	int catId = Integer.parseInt(request.getParameter("category_Id"));
	if (catId == 0) {
		listPost = postDao.getAllPost();
	} 
	else {
		listPost = postDao.getPostByCategoryId(catId);
	}
	if (listPost.size() == 0) {
		out.println("<h3 class='display-3 text-center'>No Post in this category...</h3>");
		return;
	}

	for (Post p : listPost) {
	%>

	<div class="col-md-6 mt-1">
		<div class="card">
			<img class="card-img-top" src="Blog_pics/<%=p.getPostPic()%>">
			<div class="card-body">
				<b><%=p.getPostTitle()%></b>
				<p><%=p.getPostContent()%></p>
				<p>
					
					<%
					int userId =p.getUserId();
					UserDAO  userDAO = new UserDAO(DBConnection.getDBConnection());
					User postByUser =(User)userDAO.getUser_ByUserID(userId);
					LikeDAO likeDAO = new LikeDAO(DBConnection.getDBConnection());
					%>
					Posted By:<%=postByUser.getName()%></p>
				<p>
					Posted On:<%=p.getPostDate().toLocaleString()%></p>
			</div>
			<div class="card-footer primary-background text-center">
				<a href="#!" onclick="doLike(<%=p.getPostId()%>,<%=postByUser.getId() %>)"  class="btn btn-outline-light btn-sm"><i
					class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=likeDAO.countLikesOnPost(p.getPostId())%></span></a> <a href="show-blogContent-page.jsp?postId=<%=p.getPostId()%>"
					class="btn btn-outline-light btn-sm">Read More...</a> <a
					href="#!" class="btn btn-outline-light btn-sm"><i
					class="fa fa-commenting-o"></i><span>20</span></a>
			</div>
		</div>
	</div>

	<%
	}
	%>
</div>

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
   <script src="https://checkout.razorpay.com/v1/checkout.js"></script>