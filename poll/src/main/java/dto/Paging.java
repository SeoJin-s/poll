package dto;

public class Paging {
	private int currentPage;
	private int rowPerPage;
	private String searchType;	// subject, name...
	private String searchWord;
	private String orderBy;		// subject, regdate..
	private String orderDir;	// asc, desc
	
	public int getCurrentPage() {
		return currentPage;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getOrderDir() {
		return orderDir;
	}
	public void setOrderDir(String orderDir) {
		this.orderDir = orderDir;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}

	public int getBeginRow() {
		return (this.currentPage -1) * this.rowPerPage;
	}
	
	public int getLastPage(int totalRow) {
		int lastPage = totalRow / this.rowPerPage;
		if(totalRow % this.rowPerPage != 0) {
			lastPage = lastPage+1;
		}
		return lastPage;
	}
}
