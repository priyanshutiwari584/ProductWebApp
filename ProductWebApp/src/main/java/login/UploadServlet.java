package login;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC connection parameters
    private static final String jdbcUrl = "jdbc:mysql://localhost:3306/login";
    private static final String username = "root";
    private static final String password = "root";
    private static final String imagePath = "C:\\Users\\HP\\eclipse-workspace\\ProductWebApp\\src\\main\\webapp"; // e.g., "C:/uploads/"

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String prodName = request.getParameter("prodName");
        int catId = Integer.parseInt(request.getParameter("category"));
        String prodDesc = request.getParameter("prodDesc");
        Part part = request.getPart("prodPic");
        String fileName = extractFileName(part);
        String filePath = imagePath + File.separator + fileName;
        
        
        
        part.write(filePath +File.separator);

        // Save the file to the specified location
        part.write(filePath);

        // Insert data into the database
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish the connection
            Connection conn = DriverManager.getConnection(jdbcUrl, username, password);

            // Create a prepared statement
            String query = "INSERT INTO products ( prodName,fileName,prodDesc,catId) VALUES ( ?, ?, ?,?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            
            pstmt.setString(1, prodName);
            pstmt.setString(2, fileName);
            pstmt.setString(3, prodDesc);
            pstmt.setInt(4, catId);

            // Execute the statement
            pstmt.executeUpdate();

            
            
            // Close the connection
            pstmt.close();
            conn.close();

            response.getWriter().println("Data inserted successfully!");
            
        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}
