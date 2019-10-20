package sns.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
		String firstName="";
		String lastName="";
		String name="";
		try {
			con=getCon();
			sql="select * from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()){
				firstName=rs.getString("firstName");
				lastName=" "+rs.getString("lastName");
			}
			
			sql="insert into comment (email,b_num,c_content,re_seq,firstName,lastName) values(?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, bNum);
			pstmt.setString(3, content);
			pstmt.setInt(4, 0);
			pstmt.setString(5, firstName);
			pstmt.setString(6, lastName);
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {			
			e.printStackTrace();
		}finally{
			closeDB();
		}
		name=firstName+" "+lastName;
		return name;
				
	}
	
	public ArrayList<CommentDTO> commentRead(int bNum) {
		ArrayList<CommentDTO> arr=new ArrayList<CommentDTO>();
		
		try {
			con=getCon();
			sql="select * from comment  where b_num=? order by c_num desc, re_seq asc";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bNum);
			rs=pstmt.executeQuery();
			while(rs.next()){
				CommentDTO cdto=new CommentDTO();
				cdto.setC_content(rs.getString("c_content"));
				cdto.setC_date(rs.getTimestamp("c_date"));
				cdto.setEmail(rs.getString("email"));
				cdto.setFirstName(rs.getString("firstName"));
				cdto.setLastName(rs.getString("lastName"));
				arr.add(cdto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		System.out.println(arr.toString());
		return arr;
	}
	
	public int commentLength(int bNum) {
		
		int num=0;
		try {
			con=getCon();
			sql="select count(*) from comment where b_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bNum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num=rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		return num;		
	}

}
