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

	
	// 투표하기에서 itemList를 보여주기 위해 사용 and UpdateItemForm, questionOneResult 에서도 쓰임
	public ArrayList<Item> selectItemListByQnum(int qnum) throws ClassNotFoundException, SQLException {
		ArrayList<Item> list = new ArrayList<Item>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select * from item where qnum = ? order by inum asc";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		// JDBC API ( 라이브러리 ) 에 의존하는 ResultSet 을 ArrayList타입으로 변경
		while(rs.next()) {
			Item i = new Item();		// 지역변수로 만들때 임시데이터
			i.setQnum(qnum);
			i.setInum(rs.getInt("inum"));
			i.setContent(rs.getString("content"));
			i.setCount(rs.getInt("count"));
			list.add(i);
		}
		
		
		return list;
	}
	
	public void updateItemCountPlus(int qnum, int inum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "UPDATE item SET count = count + 1 WHERE qnum=? and inum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		stmt.setInt(2, inum);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("ItemDao.updateItemCountPlus#입력성공");
		} else {
			System.out.println("ItemDao.updateItemCountPlus#입력실패");
		}
		
	}
	
    public int selectItemCountByQnum(int qnum) throws ClassNotFoundException, SQLException {
		int count = 0;
    	Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		 String sql = "SELECT SUM(`count`) AS cnt FROM item WHERE qnum = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnum);
		rs = stmt.executeQuery();
		if(rs.next()) {
			count = rs.getInt("cnt"); // rs.getInt(1)
		}
		
		return count;
    	
    }
    
    private void close(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();  // ResultSet 닫기
            }
            if (stmt != null) {
                stmt.close();  // PreparedStatement 닫기
            }
            if (conn != null) {
                conn.close();  // Connection 닫기
            }
        } catch (SQLException e) {
            e.printStackTrace();  // 예외 출력
        }
    }
    public int getVoteCount(int qnum) throws SQLException {
        int voteCount = 0;
        String sql = "SELECT SUM(count) AS voterCount FROM item WHERE qnum = ?";  // 설문 항목별 선택 수 합산

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, qnum);  // qnum을 바인딩하여 특정 설문에 대한 투표 수를 계산

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            voteCount = rs.getInt("voterCount");  // 합산된 투표 수
        }

        rs.close();
        stmt.close();
        conn.close();

        return voteCount;  // 투표자 수 반환
    }

	private Connection getConnection() {
		// TODO Auto-generated method stub
		return null;
	}
}