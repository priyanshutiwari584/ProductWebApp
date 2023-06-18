package login;
public class Product {
    private int prodId;
    private String prodName;
    private String fileName;
    private String prodDesc;
    private String catId;
    
    
	public Product(int prodId, String prodName,String fileName, String prodDesc,String catId) {
		this.prodId=prodId;
		this.prodName=prodName;
		this.fileName=fileName;
		this.prodDesc=prodDesc;
		this.catId=catId;
	}
	public int getProdId() {
		return prodId;
	}
	public void setProdId(int prodId) {
		this.prodId = prodId;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getProdDesc() {
		return prodDesc;
	}
	public void setProdDesc(String prodDesc) {
		this.prodDesc = prodDesc;
	}
	public String getCatId() {
		return catId;
	}
	public void setCatId(String catId) {
		this.catId = catId;
	}
	

   
}
