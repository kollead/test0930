package sns.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import sns.member.db.MemberDTO;

public class CommentDAO {
	
	Connection con = null;
	String sql = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private Connection getCon() throws Exception{
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/SnsProject");
		con = ds.getConnection();
	
		return con;
	}
	
	private void closeDB(){
		try{
			if(rs != null){ rs.close(); }
			if(pstmt != null){ pstmt.close(); }
			if(con != null){ con.close(); }
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//cdao.commentInsert(bNum,content,email);
	
	public String commentInsert(int bNum, String content, String email){
		String name="";
		try {
			con=getCon();
			sql="insert into comment (email,b_num,c_content,re_seq) values(?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, bNum);
			pstmt.setString(3, content);
			pstmt.setInt(4, 0);
			pstmt.executeUpdate();
			
			sql="select * from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()){
				name=rs.getString("firstName");
				name+=" "+rs.getString("lastName");
			}
		} catch (Exception e) {			
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return name;
				
	}

}
