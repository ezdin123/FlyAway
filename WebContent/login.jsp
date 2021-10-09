<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Ready to FlyAway  - New Place</title>
    </head>
    <body id="page-top">
        <!-- Navigation-->
			<a href="/FlyAway/index.html">Home page</a>|
			<a href="/FlyAway/datagen">Generate Flights</a>|
			<a  href="/FlyAway/login.jsp">Admin Login</a>|
        <!-- Masthead-->
        <header class="masthead">
            <div class="container px-4 px-lg-5 h-100">
                <div class="row gx-4 gx-lg-5 h-75 align-items-center justify-content-center text-center">
                    <div class="col-lg-8 align-self-end">
                        <h1 class="text-white font-weight-bold">Admin Login</h1>
                    
                    </div>
                    <%
                    String error = request.getParameter("error");
                    String success = request.getParameter("success");
                    
                    if(error!=null){
                    	if(error.equals("1")){
                    	%>
                    	<div class="alert alert-danger" role="alert">
							<b>Login Unsuccessful. Please contact admin services to validate your login.<b><br> 
						</div>
                    	
                    	<%
                    	} else if(error.equals("2")){
                    	%>
                    		<div class="alert alert-danger" role="alert">
							<b>Credentials already exist.<b><br> 
                    		Use username 'admin' and password 'admin' to access the admin portal.
						</div>
                    	<%
                    	}
                    }
                    
                    if(success!=null){
                    	
                    	%>
                    	<div class="alert alert-success" role="alert">
                    	<%
                    	if(success.equals("1")){
                    		%>
							<b>Credentials Created!<b><br>
							<% 
                    	}
                    	if(success.equals("2")){
                    		%>
							<b>Credentials Updated!<b><br>
							<% 
                    	}
							%>
                    		Use username 'admin' and password 'admin' to access the admin portal.
						</div>
                    	<%
                    }
                    
                    %>
                    <div class="card">
						<article class="card-body">
							<h4 class="card-title text-center mb-4 mt-1">Sign in</h4>
							<hr>
							<p class="text-center"><a href="/FlyAway/adminOps?op=1" class="btn btn-primary btn-block mb-3">change Credentials</a></p>
							<h6>Enter your admin credentials.</h6>
							<form method="post" action="/FlyAway/adminOps?op=2">
								<div class="input-group-prepend">
								    <span class="input-group-text"> <i class="fa fa-user"></i> </span>
								 </div>
								<input name="username" class="form-control" placeholder="username" type="text">
								<div class="input-group-prepend">
								    <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
								 </div>
							    <input class="form-control mb-5" placeholder="password" type="password" name="password">
							<button type="submit" class="btn btn-primary btn-block mb-3"> Login </button>
							</form>
						</article>
					</div>  
                </div>
            </div>
        </header>
       
    
    </body>
</html>