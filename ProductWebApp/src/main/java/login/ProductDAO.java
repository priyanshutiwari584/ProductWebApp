package login;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private Connection connection;

    public ProductDAO(Connection connection) {
        this.connection = connection;
    }

    public void addProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (prodId, prodName, Category, ) VALUES (?, ?, ?, ?)";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, product.getProdId());
            statement.setString(2, product.getProdName());
            //statement.setString(3, product.getCatId());
            
            

            statement.executeUpdate();
        }
    }

    public List<Product> getAllProducts() throws SQLException {
        String query = "select * from products";
        List<Product> products = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                int prodId = resultSet.getInt("prodId");
                String prodName = resultSet.getString("prodName");
                String fileName = resultSet.getString("fileName");
                String prodDesc = resultSet.getString("prodDesc");
                String catId = resultSet.getString("catId");

               Product product = new Product(prodId,prodName,fileName,prodDesc,catId);
                products.add(product);
            }
        }

        return products;
    }
    // Method to fetch products based on the selected category
    public List<Product> getProductsByCategory(int categoryId) {
        List<Product> products = new ArrayList<>();
        // Database connection and query
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE categoryId = ?");
        ) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int prodId = rs.getInt("prodId");
                String prodName = rs.getString("prodName");
                String fileName = rs.getString("fileName");
                String prodDesc = rs.getString("prodDesc");
                String catId = rs.getString("catId");

                // Create a Product object and add it to the list
                Product product = new Product(prodId, prodName,fileName, prodDesc, catId);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
}

