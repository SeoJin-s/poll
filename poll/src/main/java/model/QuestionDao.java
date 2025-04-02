package model;
import java.sql.*;
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
}
