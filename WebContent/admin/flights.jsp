<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Query" %>
<%@ page import="org.hibernate.HibernateException" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="org.hibernate.criterion.Restrictions" %>
<%@ page import="javax.persistence.criteria.Predicate" %>
<%@ page import="javax.persistence.criteria.CriteriaBuilder" %>
<%@ page import="javax.persistence.criteria.CriteriaQuery" %>
<%@ page import="javax.persistence.criteria.Root" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.simplilearn.util.HibernateUtil" %>
<%@ page import="com.simplilearn.util.FormValidator" %>
<%@ page import="com.simplilearn.model.Flight" %>
 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>FlyAway - Flights</title>
    </head>
    <body id="page-top">
                		<a href="/FlyAway/index.html">FlyAway</a>
                       <a  href="/FlyAway/datagen">search Flights</a> 
                        <a href="/FlyAway/login.jsp">Admin Login</a> 
        <!-- Masthead-->
        <section class="page-section bg-light" id="book">
            <div class="container px-5 px-lg-5">
                <div class="row gx-5 gx-lg-5 justify-content-center">
                    <div class="col-lg-12 text-center">
						<% 
							String dateCheck = request.getParameter("date");
							String arriveCheck = request.getParameter("arrive");
							String departCheck = request.getParameter("depart");
							String capacityCheck = request.getParameter("capacity");
						  if(capacityCheck.equals("Number of Passengers")){
								capacityCheck=null;
							}  
							
							//ERROR CHECK
							if(!FormValidator.isAlphabet(departCheck)||
								!FormValidator.isAlphabet(arriveCheck)||
								!FormValidator.isDateTime(dateCheck)||
								!FormValidator.isInt(capacityCheck)){
								
									%>
		                    		<div class="alert alert-danger" role="alert">
		                    		<% 
			                    	if( !FormValidator.isAlphabet(departCheck) ){
			                    		%>
										<b>Departure city has invalid characters or is blank.</b><br>
			                    		<%
			                    	}
		                    		if ( !FormValidator.isAlphabet(arriveCheck) ) {
			                    		%>
										<b>Arrival city has invalid characters or is blank.</b><br>
			                    		<%
			                    	}
		                    		if ( !FormValidator.isDateTime(dateCheck) ) {
			                    		%>
										<b>Date is invalid or is blank.</b><br>
			                    		<%
			                    	}
		                    		if ( !FormValidator.isInt(capacityCheck) ) {
			                    		%>
										<b>Selected number of passengers is not a number.</b><br>
			                    		<%
			                    	}
			                    	%>
									</div>
		                    		<%
							} else {
							
							try{
							String in = request.getParameter("date");
							SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
							Date convertDate = sdf.parse(in);
							SimpleDateFormat queryDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							String date = queryDate.format(convertDate);
							Date date1 = queryDate.parse(date);
							Date date2 = queryDate.parse(date);
							
							Calendar c = Calendar.getInstance();
	    					c.setTime(date2);
	    					c.add(Calendar.HOUR, 23);
	    			        c.add(Calendar.MINUTE, 59);
	    			        c.add(Calendar.SECOND, 59);
	    			        
	    			        date2 = c.getTime();
							
							String depart = request.getParameter("depart");
							String arrive = request.getParameter("arrive");
							Integer capacity = Integer.parseInt(request.getParameter("capacity"));
							
							Session se = HibernateUtil.getSessionFactory().openSession();
					    	se.beginTransaction();
							CriteriaBuilder cb = se.getCriteriaBuilder();
							CriteriaQuery<Flight> cr = cb.createQuery(Flight.class);
							Root<Flight> root = cr.from(Flight.class);
							Predicate equalsArriveCity = cb.equal(root.get("arriveCity"),arrive);
							Predicate equalsDepartCity = cb.equal(root.get("departCity"),depart);
							Predicate hasCapacity = cb.ge(root.<Integer>get("capacity"),capacity);
							Predicate gtDate = cb.greaterThanOrEqualTo(root.<Date>get("dateTime"),date1);
							Predicate ltDate = cb.lessThanOrEqualTo(root.<Date>get("dateTime"),date2);
							
							cr.select(root).where(cb.and(equalsArriveCity,equalsDepartCity,hasCapacity,gtDate,ltDate));
							Query<Flight> query = se.createQuery(cr);
				            List<Flight> flights = query.getResultList();
				            
				        %>
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
						      	<th scope="col"></th>
						      	
						   	</tr>
						</thead>
						<tbody>
				        <%
				            for(Flight f : flights) {
		            	%>
						
						<tr>
					      <th scope="row"><%=f.getFlightId() %></th>
					      <td><%=f.getAirlineName() %></td>
					      <td><%=f.getArriveCity() %></td>
					      <td><%=f.getArriveAirport() %></td>
					      <td><%=f.getDepartCity() %></td>
					      <td><%=f.getDepartAirport() %></td>
					      <td><%=f.getPrice() %></td>
					      
					      <td><a class="btn btn-primary btn-sm" href="registration.jsp?flight_id=<%=f.getFlightId() %>&capacity=<%=capacity %>">Choose Flight</a></td>
					    </tr>
						
						<%		
							} 
				           
					    	se.close();
						  
						%>
						  </tbody>
						</table>
				<%
					if(flights.size()<1){
						%>
                		<div class="alert alert-danger" role="alert">
                		<b>Sorry, no results found for that search.</b>
                		</div>
                		<% 
					}
				}catch(Exception e){
					%>
					<div class="alert alert-danger" role="alert">
					<b>There was an error with your query or url parameters.</b>
					</div>
					<%
				}
				
				} 	    
				%>	
					
                    </div>
                </div>
            </div>
        </section>
        <script>
		    $(document).ready(function(){
		        var date_input=$('input[name="date"]'); 
		        var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
		        date_input.datepicker({
		            format: 'mm/dd/yyyy',
		            container: container,
		            todayHighlight: true,
		            autoclose: true,
		        })
		    })
		</script>
    </body>
</html>