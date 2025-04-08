package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import dto.Board;
import dto.Paging;

public class BoardDao {
	// 답글 입력
	public void insertBoardReplay(Board b) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
		// 트랜잭션 (2개이상의 (CUD)쿼리 한묶음처럼 처리하고자 할때 사용한다.
		conn.setAutoCommit(false); // executeUpdate() 시 마다 자동 커밋기능을 false
		
		// ref 같고 pos 값이 현재글보다 크거나 같다면 +1 pos=pos+1
		PreparedStatement stmt2 = null;
		String sql2 = "update board set pos = pos+1 where ref=? and pos >= ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, b.getRef());
		stmt2.setInt(2, b.getPos());
		int row2 = stmt2.executeUpdate();
		
		// 답글 입력
		PreparedStatement stmt = null;
		String sql = "insert into board(name, subject, content, ref, pos, depth, pass, ip) values (?,?,?,?,?,?,?,?)";
		
		stmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS); // ref == 0이면 입력 직후 에 PK 값을 반환 받기 위한 코드 ( Statement.RETURN_GENERATED_KEYS )
		stmt.setString(1, b.getName());
		stmt.setString(2, b.getSubject());
		stmt.setString(3, b.getContent());
		
		stmt.setInt(4, b.getRef());
		stmt.setInt(5, b.getPos());
		stmt.setInt(6, b.getDepth());
		
		stmt.setString(7, b.getPass());
		stmt.setString(8, b.getIp());
		
		int row = stmt.executeUpdate(); // ref == 0이면 입력 직후 에 PK 값을 받아서 ref 값을 동일하게 해야한다 
		
		conn.commit();
		conn.close();
		}
	
	// 새글 입력(부모글)
		public void insertBoard(Board b) throws ClassNotFoundException, SQLException {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null; // 입력직후 PK값을 반환 받기 위해
			String sql = "insert into board(name, subject, content, ref, pass, ip) values (?,?,?,?,?,?)";
			
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll","root","java1234");
			conn.setAutoCommit(false); // executeUpdate()시마다 자동 커밋기능을 false
			
			stmt= conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // ref==0면 입력직후 pk을 반환받기 위해
			stmt.setString(1, b.getName());
			stmt.setString(2, b.getSubject());
			stmt.setString(3, b.getContent());
			stmt.setInt(4, b.getRef());
			stmt.setString(5, b.getPass());
			stmt.setString(6, b.getIp());
			
			int row = stmt.executeUpdate(); 
			// ref==0면 입력직후 pk을 반환 받아서 ref값을 동일하게
			rs = stmt.getGeneratedKeys();
			int pk = 0;
			if(rs.next()) {
				pk = rs.getInt(1);
			}
			
			System.out.println("BoardDao.insertBoard#pk: "+pk);
			
			PreparedStatement stmt2 = null;
			String sql2 = "update board set ref = ? where num = ?";
			
			stmt2 = conn.prepareStatement(sql2);
			// update쿼리가 실패하면 이전의 insert도 롤백 : conn.rollback();
			
			stmt2.setInt(1, pk);
			stmt2.setInt(2, pk);
			stmt2.executeUpdate();

			
			conn.commit(); // conn.setAutoCommit(false); 코드때문에 필요
			conn.close();
		}
	
	
	
		public ArrayList<Board> selectBoardList(Paging p) throws ClassNotFoundException, SQLException {
		    ArrayList<Board> list = new ArrayList<>();
		    Class.forName("com.mysql.cj.jdbc.Driver");

		    String baseSql = "SELECT * FROM board";
		    String where = "";
		    if (p.getSearchWord() != null && !p.getSearchWord().isEmpty()) {
		        where = " WHERE " + p.getSearchType() + " LIKE ?";
		    }

		    // 정렬 기준과 방향을 디폴트 값으로 설정 (보안 체크)
		    String orderBy = p.getOrderBy() != null && !p.getOrderBy().isEmpty() ? p.getOrderBy() : "ref";
		    String orderDir = p.getOrderDir() != null && !p.getOrderDir().isEmpty() ? p.getOrderDir() : "DESC";

		    // 허용된 필드만 사용 (보안적 측면에서 체크)
		    List<String> allowedOrderBy = Arrays.asList("ref", "subject", "count");
		    if (!allowedOrderBy.contains(orderBy)) {
		        orderBy = "ref"; // 기본값 ref로 설정
		    }

		    List<String> allowedOrderDir = Arrays.asList("asc", "desc");
		    if (!allowedOrderDir.contains(orderDir)) {
		        orderDir = "desc"; // 기본값 desc로 설정
		    }

		    // ORDER BY, LIMIT 문자열 생성
		    String order = " ORDER BY " + orderBy + " " + orderDir + ", pos ASC";
		    String limit = " LIMIT ?, ?";

		    String sql = baseSql + where + order + limit;

		    try (
		        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		        PreparedStatement stmt = conn.prepareStatement(sql);
		    ) {
		        int idx = 1;

		        // 검색어가 있을 경우 처리
		        if (!where.isEmpty()) {
		            stmt.setString(idx++, "%" + p.getSearchWord() + "%");
		        }

		        // 페이징 처리: 시작 행과 한 페이지당 행 개수
		        stmt.setInt(idx++, p.getBeginRow());
		        stmt.setInt(idx, p.getRowPerPage());

		        ResultSet rs = stmt.executeQuery();
		        while (rs.next()) {
		            Board b = new Board();
		            b.setNum(rs.getInt("num"));
		            b.setName(rs.getString("name"));
		            b.setSubject(rs.getString("subject"));
		            b.setContent(rs.getString("content"));
		            b.setRegdate(rs.getString("regdate"));
		            b.setRef(rs.getInt("ref"));
		            b.setPos(rs.getInt("pos"));
		            b.setDepth(rs.getInt("depth"));
		            b.setCount(rs.getInt("count"));
		            list.add(b);
		        }
		        rs.close();
		    }

		    return list;
		}

	public Board selectBoardOne(int num) throws ClassNotFoundException, SQLException {
		Board b = null;

		Class.forName("com.mysql.cj.jdbc.Driver");

		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
		String sql = "SELECT * FROM board WHERE num = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		ResultSet rs = stmt.executeQuery();

		if (rs.next()) {
			b = new Board();
			b.setNum(rs.getInt("num"));
			b.setName(rs.getString("name"));
			b.setSubject(rs.getString("subject"));
			b.setContent(rs.getString("content")); // 필요 시
			b.setPos(rs.getInt("pos"));
			b.setRef(rs.getInt("ref"));
			b.setDepth(rs.getInt("depth"));
			b.setCount(rs.getInt("count"));
			b.setRegdate(rs.getString("regdate")); // 필요 시
			b.setIp(rs.getString("ip")); // 필요 시
		

		rs.close();
		stmt.close();
		conn.close();
		}
		return b;
	}

	public void deleteBoard(int num) throws ClassNotFoundException, SQLException {
	    Class.forName("com.mysql.cj.jdbc.Driver");

	    // 연결 객체 선언
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    PreparedStatement stmt1 = null;
	    PreparedStatement stmt2 = null;

	    // 트랜잭션 시작
	    conn.setAutoCommit(false);

	    // 1. DELETE 쿼리: 특정 num에 해당하는 게시글 삭제
	    String sql1 = "DELETE FROM board WHERE num = ?";
	    stmt1 = conn.prepareStatement(sql1);
	    stmt1.setInt(1, num);
	    stmt1.executeUpdate();

	    // 2. UPDATE 쿼리: 삭제된 부모글(ref)과 같은 ref를 가진 다른 게시글들의 content를 변경
	    String sql2 = "UPDATE board SET subject = '삭제된 글입니다.' WHERE ref = ?";
	    stmt2 = conn.prepareStatement(sql2);
	    stmt2.setInt(1, num); // 삭제된 부모글의 ref 값을 사용
	    stmt2.executeUpdate();

	    // 트랜잭션 커밋
	    conn.commit();

	    // 자원 해제
	    stmt1.close();
	    stmt2.close();
	    conn.close();
	}
	public int updateBoard(Board b) throws SQLException {
	String sql = "UPDATE board SET name = ?, subject = ?, content = ? WHERE num = ?";
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, b.getName());
	pstmt.setString(2, b.getSubject());
	pstmt.setString(3, b.getContent());
	pstmt.setInt(4, b.getNum());
	
	int result = pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
	return result;
	}
	
	
	public int getTotalRow(Paging p) throws Exception {
	    int total = 0;
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT COUNT(*) FROM board WHERE 1=1";
	    if (p.getSearchType() != null && !p.getSearchType().isEmpty() &&
	        p.getSearchWord() != null && !p.getSearchWord().isEmpty()) {
	        sql += " AND " + p.getSearchType() + " LIKE ?";
	    }

	    stmt = conn.prepareStatement(sql);

	    if (p.getSearchType() != null && !p.getSearchType().isEmpty() &&
	        p.getSearchWord() != null && !p.getSearchWord().isEmpty()) {
	        stmt.setString(1, "%" + p.getSearchWord() + "%");
	    }

	    rs = stmt.executeQuery();
	    if (rs.next()) {
	        total = rs.getInt(1);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();
	    return total;
	}
	
}	