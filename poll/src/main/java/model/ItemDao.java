package model;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Item;
import dto.Question;
// Table : item
public class ItemDao {
	public void insertItem(Item item) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		String sql = "insert into item(qnum, inum, content) values(?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, item.getQnum());
		stmt.setInt(2, item.getInum());
		stmt.setString(3, item.getContent());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.insertItem - 입력성공");
		} else {
			System.out.println("ItemDao.insertItem - 입력실패");
		}
		conn.close();
	}
	
	public int getVoterCount(int qnum) throws SQLException, ClassNotFoundException {
	    int voterCount = 0;
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    // user_id가 존재하는 경우 1을 반환, 없으면 0을 반환
	    String sql = "SELECT COUNT(DISTINCT user_id) AS voterCount FROM item WHERE qnum = ?";
	    
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, qnum);  // 설문 번호(qnum)를 설정
	    
	    rs = stmt.executeQuery();
	    
	    if (rs.next()) {
	        // 유니크한 투표자가 있으면 1로 설정, 없으면 0
	        voterCount = rs.getInt("voterCount") > 0 ? 1 : 0;
	    }
	    
	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return voterCount;
	}
	
	public ArrayList<Item> selectItemList(int qnum) throws ClassNotFoundException, SQLException {
		ArrayList<Item> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "SELECT"
						+ " qnum,"
						+ " inum,"
						+ " content"
					+ " FROM Item"
					+ " where qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Item i = new Item();
			
			i.setQnum(rs.getInt("qnum"));
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			list.add(i);
		}
		
		conn.close();
		
		return list;
	}
}	
