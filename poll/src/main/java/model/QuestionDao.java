package model;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import dto.*;
import java.util.ArrayList;

import dto.*;

import dto.Question;
// Table : question CRUD 담당
public class QuestionDao {
	
	// 입력 후 자동으로 생성된 키값을 반환
	public int insertQuestion(Question question) throws ClassNotFoundException, SQLException {
		int pk = 0;
		int row = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;			// INSERT 지만 KEY 값을 받아와야해서 사용
		
		// 라이브러리를 추가 : projcet 우클릭 -> build-path 항목에서 추가
		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "INSERT INTO question(title, startdate, enddate, type) VALUES(?,?,?,?)";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		// Statement.RETURN_GENERATED_KEYS 옵션 : insert 후 SELECT MAX(pk) FROM ... 실행
		stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		stmt.setString(1, question.getTitle());
		stmt.setString(2, question.getStartdate());
		stmt.setString(3, question.getEnddate());
		stmt.setInt(4, question.getType());
		
		System.out.println(stmt);
		
		row = stmt.executeUpdate();		// INSERT
		rs = stmt.getGeneratedKeys();	// SELECT MAX(num) FROM question -> 가장 최근 키
		
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		conn.close();
		
		return pk;
	}
	
	// 설문 데이터 리스트 가져오기
	public ArrayList<Question> selectQuestionList(Paging p) throws ClassNotFoundException, SQLException{
		ArrayList<Question> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "SELECT"
						+ " num,"
						+ " title,"
						+ " startdate AS startDate,"
						+ " enddate AS endDate,"
						+ " createdate AS createDate,"
						+ " type"
					+ " FROM question"
					+ " ORDER BY num DESC"
					+ " LIMIT ?,?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getbeginRow());
		stmt.setInt(2, p.getRowPerPage());
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Question q = new Question();
			
			q.setNum(rs.getInt("num"));
			q.setTitle(rs.getString("title"));
			q.setStartdate(rs.getString("startDate"));
			q.setEnddate(rs.getString("endDate"));
			q.setCreatedate(rs.getString("createDate"));
			q.setType(rs.getInt("type"));
			
			list.add(q);
		}
		
		conn.close();
		
		return list;
	}

	// 설문 데이터 하나 가져오기
	public HashMap<String,Object> selectQuestion(int id) throws ClassNotFoundException, SQLException{
		HashMap<String,Object> map = new  HashMap<String,Object>();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "SELECT "
					+ " num, "
					+ " title, "
					+ " startdate,"
					+ " enddate,"
					+ " type "
				+ " FROM question "
				+ " WHERE num = ?";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, id);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			 map.put("num",rs.getObject("num"));
			 map.put("title",rs.getObject("title"));
			 map.put("startdate",rs.getObject("startdate"));
			 map.put("enddate",rs.getObject("enddate"));
			 map.put("type",rs.getObject("type"));
		}
		
		conn.close();
		
		return map;
	}
	
	public int getTotalDataCount() throws ClassNotFoundException, SQLException{
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		
		String sql = "SELECT "
						+ " COUNT(*) AS count"
					+ " FROM question";
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		stmt = conn.prepareStatement(sql);
		
		// 디버깅
		//System.out.println(stmt);
		
		rs = stmt.executeQuery();
		rs.next();
		
		count = rs.getInt("count");
		
		conn.close();
		
		return count;
	}
	
	public Map<Integer, Boolean> checkDeletableQuestions() throws SQLException, ClassNotFoundException {
	    Map<Integer, Boolean> deletableQuestions = new HashMap<>();
	    
	    String checkVoteSql = "SELECT qnum, SUM(count) FROM item GROUP BY qnum HAVING SUM(count) = 0";
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");

	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    stmt = conn.prepareStatement(checkVoteSql);
	    rs = stmt.executeQuery();
	    
	    while (rs.next()) {
	        int qnum = rs.getInt("qnum");
	        deletableQuestions.put(qnum, true);  
	    }
	    
	    rs.close();
	    stmt.close();
	    conn.close();
	    
	    return deletableQuestions;  
	}
    
    public boolean deleteQuestion(int qnum) throws SQLException, ClassNotFoundException {
    boolean isDeleted = false;
    Connection conn = null;
    PreparedStatement stmt = null;
    String deleteSql = "DELETE FROM question WHERE num = ?";
    
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
    stmt = conn.prepareStatement(deleteSql);
    stmt.setInt(1, qnum);
            
    int rowsAffected = stmt.executeUpdate(); // 삭제 실행
            
    if (rowsAffected > 0) {
         isDeleted = true; // 삭제 성공
      }
            
     stmt.close();
     conn.close();
            
     return isDeleted;
     }
    
    public boolean deleteItemByQnum(int qnum) throws SQLException, ClassNotFoundException {
        boolean isDeleted = false;
        Connection conn = null;
        PreparedStatement stmt = null;
        String deleteSql = "DELETE FROM item WHERE qnum = ?";
        
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        stmt = conn.prepareStatement(deleteSql);
        stmt.setInt(1, qnum);
                
        int rowsAffected = stmt.executeUpdate(); // 삭제 실행
                
        if (rowsAffected > 0) {
            isDeleted = true; // 삭제 성공
        }
                
        stmt.close();
        conn.close();
                
        return isDeleted;
    }

    public boolean isVoteEmpty(int qunm)throws SQLException, ClassNotFoundException {
    	boolean isEmpty = false;
    	Connection conn = null;
    	PreparedStatement stmt = null;
    	ResultSet rs = null;
    	
    	Class.forName("com.mysql.cj.jdbc.Driver");
    	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");

    	String sql = "SELECT SUM(count) AS totalVotes FROM item WHERE qnum = ?";
    	stmt = conn.prepareStatement(sql);
    	stmt.setInt(1, qunm);
    	
    	rs = stmt.executeQuery();
    	
    	if (rs.next()) {
    		isEmpty = rs.getInt("totalVotes") == 0;
    	}
    	rs.close();
    	stmt.close();
    	conn.close();
    	
    	return isEmpty;
    }
    

    private Connection getConnection() throws SQLException, ClassNotFoundException {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
        }

    public boolean updateEndDate(int questionId, String newEndDate) throws SQLException, ClassNotFoundException {
            boolean isUpdated = false;
            String sql = "UPDATE question SET enddate = ? WHERE num = ?";

            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, newEndDate);
                stmt.setInt(2, questionId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    isUpdated = true;
                }
            }

            return isUpdated;
        }
    
    public Question selectQuestionById(int questionId) throws SQLException, ClassNotFoundException {
            Question question = null;
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            String sql = "SELECT num, title, startdate, enddate, createdate, type FROM question WHERE num = ?";
            
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, questionId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                question = new Question();
                question.setNum(rs.getInt("num"));
                question.setTitle(rs.getString("title"));
                question.setStartdate(rs.getString("startdate"));
                question.setEnddate(rs.getString("enddate"));
                question.setCreatedate(rs.getString("createdate"));
                question.setType(rs.getInt("type"));
            }

            // 자원 정리
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
            
            return question;
        }
    
    
    public ArrayList<HashMap<String,Object>> selectQuestionList() throws ClassNotFoundException, SQLException {
    	 ArrayList<HashMap<String,Object>>list = new ArrayList<>();
    	 Class.forName("com.mysql.cj.jdbc.Driver");
    	 Connection conn = null;
 		PreparedStatement stmt = null;
 		ResultSet rs = null;
 		
 		String sql = "SELECT q.num, q.title, q.startdate, q.enddate, t.cnt FROM question q INNER JOIN (SELECT qnum,SUM(COUNT) cnt FROM item group BY qnum) tON q.num = t.qnum";	
 		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
 		stmt = conn.prepareStatement(sql);
 		rs = stmt.executeQuery();
 		while(rs.next()) {
 			HashMap<String,Object> m = new HashMap<String, Object>();
 			m.put("num",rs.getInt("num"));
 			m.put("title",rs.getString("title"));
 			m.put("startdate",rs.getString("startdate"));
 			m.put("enddate",rs.getString("enddate"));
 			m.put("cnt",rs.getInt("cnt"));
 		}
 		return list;
    }
}