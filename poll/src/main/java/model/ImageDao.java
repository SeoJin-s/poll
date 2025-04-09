package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Image;
import dto.Paging;

public class ImageDao {
   public ArrayList<Image> selectImageList(Paging p) throws ClassNotFoundException, SQLException {
      ArrayList<Image> list = new ArrayList<Image>();
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = null;
      PreparedStatement stmt = null;
      ResultSet rs = null;
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
      
      String sql = "SELECT * FROM image order by num desc LIMIT ?, ?"; // 나중에 별포말고 전체적으로 적기 , num보단 date가 좋다
      
      stmt = conn.prepareStatement(sql);
      stmt.setInt(1,  p.getBeginRow());
      stmt.setInt(2,  p.getRowPerPage());
      rs = stmt.executeQuery();
      while(rs.next()) {
         Image img = new Image();
         img.setNum(rs.getInt("num"));
         img.setMemo(rs.getString("Memo"));
         img.setFilename(rs.getString("filename"));
         img.setCreatedate(rs.getString("Createdate"));
         list.add(img);
      }
      conn.close();
      
      return list;
      
// 비밀번호 나중에 추가해보기
      
   }
   
   public void insertImage(Image img) throws ClassNotFoundException, SQLException {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = null;
      PreparedStatement stmt = null;
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/poll", "root", "java1234");
      
      String sql = "INSERT INTO image(memo, filename) values(?, ?)";
      stmt = conn.prepareStatement(sql);
      stmt.setString(1,  img.getMemo());
      stmt.setString(2,  img.getFilename());
      int row2 = stmt.executeUpdate();
      
      conn.close();
   }
   
   public void deleteImage(int num) throws ClassNotFoundException, SQLException{
	    // 1. 드라이버 로딩
	    Class.forName("com.mysql.cj.jdbc.Driver");

	    // 2. DB 연결
	    Connection conn = DriverManager.getConnection(
	        "jdbc:mysql://localhost:3306/poll", "root", "java1234"
	    );

	    // 3. SQL 준비
	    String sql = "DELETE FROM image WHERE num = ?";

	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, num);

	    // 4. 실행
	    int row = stmt.executeUpdate();
	    System.out.println(row + "행 삭제됨");

	    // 5. 자원 정리
	    stmt.close();
	    conn.close();
	}
}
