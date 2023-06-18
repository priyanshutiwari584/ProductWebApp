package login;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    // Method to fetch all categories from the database
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();

        // Database connection and query
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM category");
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int catId = rs.getInt("catId");
                String catName = rs.getString("catName");

                // Create a Category object and add it to the list
                Category category = new Category(catId, catName);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }
}
 class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/login";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}





