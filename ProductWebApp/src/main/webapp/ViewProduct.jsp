<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Data</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- Custom CSS -->
<style type="text/css">
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
	height: 210px; /* Adjust the desired height */
	flex: 1 0 auto;
}

.card-title {
	margin-top: 10px; /* Adjust the spacing as needed */
}

.card-text {
	margin-bottom: 10px; /* Adjust the spacing as needed */
}

.card-form-button {
	margin-top: auto;
	position: static; justify-content : center;
	align-items: center;
	justify-content: center;
}
</style>

</head>
<body>
	<!--
	<div class="container mt-4">
		<h1>View Data</h1>
		<div class="row">
	/*
			// JDBC connection parameters
			String jdbcUrl = "jdbc:mysql://localhost:3306/login";
			String username = "root";
			String password = "root";

			try {
				// Load the MySQL JDBC driver
				Class.forName("com.mysql.jdbc.Driver");

				// Establish the connection
				Connection conn = DriverManager.getConnection(jdbcUrl, username, password);

				// Create a statement
				Statement stmt = conn.createStatement();

				// Execute the query to retrieve data
				String sql = "SELECT products.prodId, products.prodName,  products.fileName, products.prodDesc,category.catName " +
                "FROM products INNER JOIN category  on products.catId = category.catId";
				ResultSet rs = stmt.executeQuery(sql);

				// Loop through the result set
				while (rs.next()) {
					String prodId = rs.getString("prodId");
					String prodName = rs.getString("prodName");
					String fileName = rs.getString("fileName");
					String description = rs.getString("prodDesc");
					String catName = rs.getString("catName");
					

					// Shorten the description if it exceeds 10 words
					if (description.split("\\s+").length > 10) {
				String[] words = description.split("\\s+");
				StringBuilder shortenedDescription = new StringBuilder();
				for (int i = 0; i < 10; i++) {
					shortenedDescription.append(words[i]).append(" ");
				}
				description = shortenedDescription.toString().trim() + "...";
					}
*/
// Display the data in Bootstrap cards
			%>
			<!--
			<div class="col-lg-4 col-md-6 col-sm-12 mb-4">
				<div class="card">
					<img src="<c:url value='<//%=fileName%>' />" class="card-img-top"
						alt="Product Image">
					<div class="card-body d-flex flex-column"">
						<h5 class="card-title"><//%=prodName%></h5>
						<p class="card-text">
							Category:<//%=catName%></p>
						<p class="card-text"><//%=description%></p>
						<form action="deleteProduct" method="post">
							<input type="hidden" name="prodId" value="<//%=prodId%>">
							<button type="submit" class="btn btn-danger mt-auto">Delete</button>
						</form>
					</div>
				</div>
			</div>
			-->
	<%
	/*}

	// Close the connection
	rs.close();
	stmt.close();
	conn.close();
	} catch (Exception e) {
	out.println("Error: " + e.getMessage());
	}
	*/
	%>
	<!-- 	</div>
	</div>
-->

	<!-- Navbar section -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="#">Product Catalog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="ViewProduct.jsp">All Products</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Categories
                    </a>
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
                        <a class="dropdown-item" href="ViewProduct.jsp?category=<%= catId %>"><%= catName %></a>
                        <% 
                                }
                            } catch (ClassNotFoundException e) {
                                e.printStackTrace();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            } finally {
                                // Close resources
                                try {
                                    if (rs != null) rs.close();
                                    if (pstmt != null) pstmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>
	
	<!-- Product display section -->
	<div class="container mt-4">
	<div class="row">
		<%-- Retrieve the selected category from the request parameter --%>
		<%
		String selectedCategory = request.getParameter("category");
		%>

		<%-- Fetch and display the products based on the selected category --%>
		<%
		// Fetch data from the database using JDBC

	

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "root");

			String sql;
			if (selectedCategory == null) {
				// If no category is selected, fetch all products
				sql = "SELECT products.prodId, products.prodName, products.fileName, products.prodDesc, category.catName "
				+ "FROM products  " + "INNER JOIN category  ON products.catId = category.catId";
				pstmt = conn.prepareStatement(sql);
			} else {
				// If a category is selected, fetch products for that category
				sql = "SELECT products.prodId, products.prodName, products.fileName, products.prodDesc, category.catName "
				+ "FROM products  " + "INNER JOIN category  ON products.catId = category.catId "
				+ "WHERE products.catId = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(selectedCategory));
			}

			rs = pstmt.executeQuery();
			// Check if there are any products available
			boolean productsAvailable = false;
			while (rs.next()) {
				int prodId = rs.getInt("prodId");
				String prodName = rs.getString("prodName");
				String prodPic = rs.getString("fileName");
				String description = rs.getString("prodDesc");
				String catName = rs.getString("catName");

				// Set the productsAvailable flag to true
				productsAvailable = true;
		%>
		<div class="col-lg-4 col-md-6 col-sm-12 mb-4">
				<div class="card">
					<img src="<c:url value='<%=prodPic%>' />" class="card-img-top"
						alt="Product Image">
					<div class="card-body d-flex flex-column"">
						<h5 class="card-title"><%=prodName%></h5>
						<p class="card-text">
							Category:<%=catName%></p>
						<p class="card-text"><%=description%></p>
						<form action="deleteProduct" method="post">
							<input type="hidden" name="prodId" value="<%=prodId%>">
							<button type="submit" class="btn btn-danger mt-auto">Delete</button>
						</form>
					</div>
				</div>
			</div>
		<%-- End of product iteration --%>
		<%
		}
		// Check if there are no products available for the selected category
		if (!productsAvailable && selectedCategory != null) {
		%>
		<div class="alert alert-warning" role="alert">No products
			available for the selected category.</div>
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
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
