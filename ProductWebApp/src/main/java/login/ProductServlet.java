package login;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
/**
 * Servlet implementation class ProductServlet
 */

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    private Connection connection;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/login";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    public void init() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Connected to the database successfully!");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void dopost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	ProductDAO productDAO = new ProductDAO(connection);
    	try{// Fetch product data from the database
    		
        List<Product> products = productDAO.getAllProducts();

        // Set the products as an attribute in the request
        request.setAttribute("products", products);

        // Forward the request to index.jsp
        request.getRequestDispatcher("Index.jsp").forward(request, response);
    }
    catch(Exception e) {
    	e.printStackTrace();
    }
    }

    public void destroy() {
        try {
            if (connection != null) {
                connection.close();
                System.out.println("Connection to the database closed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
   
       

}

