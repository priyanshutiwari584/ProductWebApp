package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // JDBC connection parameters
    private static final String URL = "jdbc:mysql://localhost:3306/login";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the product ID from the request parameter
        String prodId = request.getParameter("prodId");

        // Delete the product from the database
        try (Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            String query = "DELETE FROM products WHERE prodId = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, prodId);
            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                // Product successfully deleted
                response.sendRedirect("ViewProduct.jsp");
            } else {
                // Product not found or deletion failed
                response.getWriter().println("Failed to delete the product.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred while deleting the product.");
        }
    }
}
