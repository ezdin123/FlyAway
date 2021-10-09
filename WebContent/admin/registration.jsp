<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="com.simplilearn.util.HibernateUtil" %>
<%@ page import="com.simplilearn.util.FormValidator" %>
<%@ page import="com.simplilearn.model.Flight" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>FlyAway - Registration</title>
    </head>
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light-fixed-top py-3">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/FlyAway/index.html">FlyAway</a>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" href="/FlyAway/datagen">Search  Flights</a></li>
                        <li class="nav-item"><a class="nav-link" href="/FlyAway/login.jsp">Admin Login</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <%
		String error = request.getParameter("error");
		
		if(error!=null){
			%>
			<section class="page-section bg-light" id="register">
				<div class="alert alert-danger" role="alert">
			<%
			if(error.indexOf("01")>=0){
				%>
		   			<b>First name has invalid characters or is blank.</b><br>
				<%
			}
			if(error.indexOf("02")>=0){
				%>
	   				<b>Last name has invalid characters or is blank.</b><br>
				<%
			}
			if(error.indexOf("03")>=0){
				%>
		   			<b>Date of birth is not a valid date or is blank.</b><br>
				<%
			}
			if(error.indexOf("04")>=0){
				%>
		   			<b>Street address is not a valid address or is blank.</b><br>
				<%
			}
			if(error.indexOf("05")>=0){
				%>
		   			<b>Gender is blank.</b><br>
				<%
			}
			if(error.indexOf("06")>=0){
				%>
		   			<b>ID type is blank.</b><br>
				<%
			}
			if(error.indexOf("07")>=0){
				%>
		   			<b>Id number contains illegal characters or is blank.</b><br>
				<%
			}
			if(error.indexOf("08")>=0){
				%>
		   			<b>Exp date is not a valid date or is blank.</b><br>
				<%
			}
			if(error.indexOf("09")>=0){
				%>
		   			<b>Capacity is not a valid number or is blank.</b><br>
				<%
			}
			if(error.indexOf("10")>=0){
				%>
		   			<b>flight_id is not a valid number or is blank.</b><br>
				<%
			}
			
			%>
				</div>
			</section>
			<%
		}
		try{
		Session se = HibernateUtil.getSessionFactory().openSession();
		int flight_id = Integer.parseInt(request.getParameter("flight_id"));
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		Flight f = se.load(Flight.class,flight_id);
		%>
        <!-- Customer Registration -->
        <section class="page-section bg-light" id="register">
            <div class="container px-5 px-lg-5">
                <div class="row gx-5 gx-lg-5 justify-content-center">
                    <div class="col-lg-12 text-center">
                        <h2 class="text-primary mt-0">Customer Registration</h2>
                        <hr class="divider divider-primary" />
                        <%
                        //error handling block here.
                        %>
                        <form class="row g-3 align-items-center" action="register?flight_id=<%=f.getFlightId() %>&capacity=<%=capacity %>" method="POST">
					    	<div class="col-auto">
					      		<input type="text" class="form-control" placeholder="First Name" name="firstName"  id="firstName">
					    	</div>
					    	<div class="col-auto">
					      		<input type="text" class="form-control" placeholder="Last Name" name="lastName"  id="lastName">
					    	</div>
					    	<div class="col-auto">
						    	<div class="input-group flex-nowrap">
								  <label for="birth_date" class="visually-hidden">Birth Date</label>
						    		<span class="input-group-text" id="addon-wrapping">
				                        <i class="fa fa-user-circle-o">
				                        </i>
				                    </span>
						    		<input class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="DOB - MM/DD/YYY" type="text" aria-label="date" aria-describedby="addon-wrapping"/>
								</div>
					    	</div>
					    	<div class="col-auto">
					      		<input type="text" class="form-control" placeholder="Street Address" name="st_address"  id="st_address">
					    	</div>
					    	<div class="col-auto">
					      		<input type="text" class="form-control" placeholder="Age" name="age"  id="age">
					    	</div>
					    	<div class="col-auto">
					      		<select class="form-select" aria-label="Gender" name="gender" id="gender">
									<option selected>Gender</option>
								  	<option value="Male">Male</option>
								  	<option value="Female">Female</option>
								  	<option value="Undisclosed">Prefer not to Say</option>
								</select>
							</div>
							<div class="col-auto">
					      		<select class="form-select" aria-label="ID Type" name="id_type" id="id_type">
									<option selected>ID Type</option>
								  	<option value="Drivers License">Drivers License</option>
								  	<option value="ID Card">ID Card</option>
								  	<option value="Military ID">Military ID</option>
								  	<option value="Passport">Passport</option>
								</select>
							</div>
							<div class="col-auto">
					      		<input type="text" class="form-control" placeholder="ID Number" name="id_num"  id="id_num">
					    	</div>
					    	<div class="col-auto">
						    	<div class="input-group flex-nowrap">
								  <label for="id_exp_date" class="visually-hidden">Exp Date</label>
						    		<span class="input-group-text" id="addon-wrapping">
				                        <i class="fa fa-id-card-o">
				                        </i>
				                    </span>
						    		<input class="form-control" id="id_exp_date" name="id_exp_date" placeholder="EXP - MM/DD/YYY" type="text" aria-label="date" aria-describedby="addon-wrapping"/>
								</div>
					    	</div>
					    	<button type="submit" class="btn btn-secondary col-auto">Submit</button>
						</form>
                    </div>
                </div>
            </div>
        </section>
        <!-- Flight Info -->
        <section class="page-section bg-light" id="flight_info">
            <div class="container px-5 px-lg-5">
                <div class="row gx-5 gx-lg-5 justify-content-center">
                    <div class="col-lg-12 text-center">
                        <h4 class="text-primary mt-0">Flight Information</h4>
                        <hr class="divider divider-primary" />
                        <table class="table table-striped table-hover">
							<thead>
								<tr>
						    		<th scope="col">Flight Number</th>
						      		<th scope="col">Airline Name</th>
						      		<th scope="col">Arrive City</th>
						      		<th scope="col">Arrive Airport</th>
						      		<th scope="col">Depart City</th>
						      		<th scope="col">Depart Airport</th>
						      		<th scope="col">Price</th>
						   		</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row"><%=f.getFlightId() %></th>
								    <td><%=f.getAirlineName() %></td>
								    <td><%=f.getArriveCity() %></td>
								    <td><%=f.getArriveAirport() %></td>
								    <td><%=f.getDepartCity() %></td>
								    <td><%=f.getDepartAirport() %></td>
								    <td><%=f.getPrice() %></td>
						    	</tr>
						   	</tbody>
						</table>
						<% 
						se.close();
						} catch (Exception e) {
							%>
							<div class="alert alert-danger" role="alert">
							<b>There was an error with your query or url parameters.</b>
							</div>
							<%
						}
						
						
						%>
                    </div>
                </div>
            </div>
        </section>
        
        <script>
		    $(document).ready(function(){
		        var date_input1=$('input[name="dateOfBirth"]'); //our date input has the name "date"
		        var date_input2=$('input[name="id_exp_date"]');
		        var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
		        date_input1.datepicker({
		            format: 'mm/dd/yyyy',
		            container: container,
		            todayHighlight: true,
		            autoclose: true,
		        })
		        date_input2.datepicker({
		            format: 'mm/dd/yyyy',
		            container: container,
		            todayHighlight: true,
		            autoclose: true,
		        })
		    })
		    
		</script>
    </body>
</html>