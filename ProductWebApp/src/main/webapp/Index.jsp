<%@page import="login.CategoryDAO"%>
<%@ page import="login.Product"%>
<%@ page import="login.Category"%>
<%@ page import="login.ProductDAO"%>
<%@ page import="login.ProductServlet"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.lang.String"%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Homepage</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<style>
.header {
	background-color: #333;
	color: #fff;
	padding: 10px;
	text-align: center;
}

.carousel-item {
	height: 400px;
}

.carousel-item img {
	object-fit: cover;
	height: 100%;
	width: 100%;
}

.footer {
	background-color: #333;
	color: #fff;
	padding: 10px;
	text-align: center;
}

.card-img-top {
	height: 300px; /* Adjust the desired height */
	object-fit: cover;
	border-bottom: 0.5px solid blue;
	/* Add a black border to the card image */
}

.card {
	border: 1px solid black; /* Add a black border to the card */
	margin-bottom: 20px; /* Add margin to create space between cards */
	box-shadow: 0 0 4px rgba(0, 0, 0, 0.1);
	/* Add a box shadow for a subtle effect */
}

.card-divider {
	border-top: 1px solid #e9ecef;
	/* Add a top border to create the line */
}

.card-body {
	height: 200px; /* Adjust the desired height */
}

.card-title {
	margin-top: 10px; /* Adjust the spacing as needed */
}

.card-text {
	margin-bottom: 10px; /* Adjust the spacing as needed */
}

.btn-buy-now {
	margin-top: auto;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<a class="navbar-brand" href="#">Product Catalog</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="Index.jsp">All
							Products</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"> Categories </a>
						<div class="dropdown-menu" aria-labelledby="navbarDropdown">
							<%-- Fetch category data from the database using JDBC --%>
							<%
							Connection conn = null;
							PreparedStatement pstmt = null;
							ResultSet rs = null;

							try {
								Class.forName("com.mysql.jdbc.Driver");
								conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "root");

								String sql = "SELECT * FROM category";
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();

								while (rs.next()) {
									int catId = rs.getInt("catId");
									String catName = rs.getString("catName");
							%>
							<a class="dropdown-item" href="Index.jsp?category=<%=catId%>"><%=catName%></a>
							<%
							}
							} catch (ClassNotFoundException e) {
							e.printStackTrace();
							} catch (SQLException e) {
							e.printStackTrace();
							} finally {
							// Close resources
							try {
							if (rs != null)
								rs.close();
							if (pstmt != null)
								pstmt.close();
							if (conn != null)
								conn.close();
							} catch (SQLException e) {
							e.printStackTrace();
							}
							}
							%>
						</div></li>
				</ul>
			</div>
		</div>
	</nav>

	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="1.jpg" alt="Image 1">
			</div>
			<div class="carousel-item">
				<img src="2.jpg" alt="Image 2">
			</div>
			<div class="carousel-item">
				<img src="3.png" alt="Image 3">
			</div>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>

	<div class="container mt-4 align-text:center">
		<h2 class="text-center">Products</h2>
		<div class="row">

			<%
			// Establish the database connection
			String jdbcUrl = "jdbc:mysql://localhost:3306/login";
			String username = "root";
			String password = "root";

			Connection connection = null;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connection = DriverManager.getConnection(jdbcUrl, username, password);
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}

			// Create an instance of the ProductDAO
			ProductDAO productDAO = new ProductDAO(connection);

			// Fetch and display product data
			List<Product> products = productDAO.getAllProducts();
			for (Product product : products) {
				// Display product details

				// out.println("<h4>" + product.getProdName() + "</h4>");
				//out.println("<p>Product ID: " + product.getProdId() + "</p>");
				//out.println("<p>Category: " + product.getCategory() + "</p>");
				//out.println("<img src='" + product.getFileName() + "' alt='Product Image'>");
				//out.println("<hr>");
			%>
			<div class="col-lg-4 col-md-6 col-sm-12 mb-4">
				<div class="card">
					<img src="<%=product.getFileName()%>" class="card-img-top"
						alt="Product Image">
					<div class="card-body d-flex flex-column"">
						<h5 class="card-title"><%=product.getProdName()%></h5>
						<p class="card-text">Category:<%=product.getCatId()%></p>
						<p class="card-text"><%=product.getProdDesc()%></p>
						
					</div>
				</div>
			</div>


			<%
			}

			// Close the database connection
			try {
			if (connection != null && !connection.isClosed()) {
				connection.close();
			}
			} catch (SQLException e) {
			e.printStackTrace();
			}
			%>

		</div>
	</div>

	<div class="footer">
		<p>&copy; 2023 Homepage. All rights reserved.</p>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</body>
</html>
