<%@page import="java.sql.*"%>
<!DOCTYPE html>

<html>
<head>
    <title>Upload Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Upload Product</h1>
        <form action="UploadServlet" method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Product Name:</label>
                <input type="text" class="form-control" id="productName" name="prodName" required>
            </div>
            <div class="form-group">
                <label for="category">Category:</label>
                <select class="form-control" id="category" name="category" required>
                    <option value="">Select Category</option>
                    <%-- Fetch and display the category options --%>
                    <%
                        // Fetch data from the database using JDBC
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "root");
                            stmt = conn.createStatement();
                            String sql = "SELECT catId, catName FROM category";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                int catId = rs.getInt("catId");
                                String catName = rs.getString("catName");
                    %>
                    <option value="<%= catId %>"><%= catName %></option>
                    <%-- End of category iteration --%>
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
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="productImage">Product Image:</label>
                <input type="file" class="form-control-file" id="productImage" name="prodPic" required>
            </div>
            <div class="form-group">
                <label for="productDescription">Product Description:</label>
                <textarea class="form-control" id="productDescription" name="prodDesc" rows="4" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Upload Product</button>
        </form>
        <br>
        <a href="addCategory.jsp" class="btn btn-link">Add Category</a>
    </div>
    <br>
	<div align="center"><a href="ViewProduct.jsp"><button>View Data</button></a></div>
	<br>
</body>
</html>
