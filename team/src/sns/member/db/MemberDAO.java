package sns.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
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
	
	public int emailCheck(String email) {
		int check=-1;
		try {
			con=getCon();
			sql="select * from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				check=1;
			}else {
				check=0;
			}
			System.out.println("IDCHECK---------");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return check;
	}
	
	public int login(String email, String pass) {
		int check=2;
		
		try {
			con=getCon();
			sql="select password from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("password").equals(pass)) {
					check=1;
				}else {
					check=0;
				}
			}else {
				check=-1;
			}
					
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return check;
	}
	
	public String getEmail(int m_num) {
		String email = "";
		
		try {
			con = getCon();
			
			sql = "select email from SnsProject.member where m_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, m_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				email = rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return email;
	}
	
public int getMyM_num(String email) {
		
		try {
			con = getCon();
			
			sql = "select m_num from SnsProject.member where email = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, email);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return 0;
	}
}
