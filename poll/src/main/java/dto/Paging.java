package dto;

public class Paging {
	private int currentPage;
	private int rowPerPage;
	private String searchType;	// subject, name...
	private String searchWord;
	private String orderBy;		// subject, regdate..
	private String orderDir;	// asc, desc
	private int totalRow;
	private int totalPage;
	
	public int getTotalRow() {
		return totalRow;
	}
	public void setTotalRow(int totalRow) {
		this.totalRow = totalRow;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageBlock() {
		return pageBlock;
	}

	private final int pageBlock = 5; // 한 블럭에 표시할 페이지 수
	
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
	    return (orderBy == null || orderBy.isEmpty()) ? "ref" : orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	public String getOrderDir() {
	    return (orderDir == null || orderDir.isEmpty()) ? "desc" : orderDir;
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

	public int getStartPage(int totalRow) {
	    int totalPage = getLastPage(totalRow);
	    int blockSize = 5;
	    return ((currentPage - 1) / blockSize) * blockSize + 1;
	}

	public int getEndPage(int totalRow) {
	    int totalPage = getLastPage(totalRow);
	    int blockSize = 5;
	    int endPage = getStartPage(totalRow) + blockSize - 1;
	    return endPage > totalPage ? totalPage : endPage;
	}
}
