package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login", "root", "root");

            // Prepare the SQL statement
            String sql = "INSERT INTO category (catName) VALUES (?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, categoryName);

            // Execute the SQL statement
            pstmt.executeUpdate();

            // Redirect to a success page or display a success message
            response.sendRedirect("success.jsp");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            // Handle any errors or display an error message
            response.sendRedirect("error.jsp");
        } finally {
            // Close resources
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
