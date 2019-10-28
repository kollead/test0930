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
				firstName=rs.getString("f_name");
				lastName=rs.getString("l_name");
			}
			
			//>>>>>sql update comment set re_ref=c_num<<<<<
			
			sql="insert into comment (email,b_num,c_content,re_seq,f_name,l_name,re_lev) values(?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, bNum);
			pstmt.setString(3, content);
			pstmt.setInt(4, 0);//sequence
			pstmt.setString(5, firstName);
			pstmt.setString(6, lastName);
			pstmt.setInt(7, 0);//level
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {			
			e.printStackTrace();
		}finally{
			closeDB();
		}
		name=lastName+" "+firstName;
		return name;
		//LAST_INSERT_ID() 찾아보기
				
	}
	
	public ArrayList<CommentDTO> commentRead(int bNum,int num) {
		ArrayList<CommentDTO> arr=new ArrayList<CommentDTO>();
		
		try {
			con=getCon();
			
			sql="update comment set re_ref=c_num where re_ref is null";
			pstmt=con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql="select * from comment  where b_num=? order by re_ref desc, re_seq desc limit ?,5";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bNum);
			pstmt.setInt(2, num);			
			rs=pstmt.executeQuery();
			while(rs.next()){
				CommentDTO cdto=new CommentDTO();
				cdto.setC_num(rs.getInt("c_num"));
				cdto.setB_num(bNum);
				cdto.setC_content(rs.getString("c_content"));
				cdto.setC_date(rs.getTimestamp("c_date"));
				cdto.setEmail(rs.getString("email"));
				cdto.setF_name(rs.getString("f_name"));
				cdto.setL_name(rs.getString("l_name"));
				cdto.setRe_seq(rs.getInt("re_seq"));
				cdto.setRe_lev(rs.getInt("re_lev"));
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
		}finally {
			closeDB();
		}
			
		return num;		
	}
	
	public ArrayList commentReInsert(String content, int c_num, String email){
		//1. 이름가져오기용
		String firstName="";
		String lastName="";
		String name="";
		int re_lev=0;
		ArrayList arr=new ArrayList();
		
		//2. 가지고 온 c_num으로 대댓글이 달리게 될 댓글의 정보를 조회
		CommentDTO cdto= new CommentDTO();
		
		//3. 기존의 seq 처리
		
		//4. 대댓글의 정보를 넣는다 
		
		try {
			con=getCon();
			con=getCon();
			sql="select * from member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()){
				firstName=rs.getString("f_name");
				lastName=rs.getString("l_name");
			}
			
			sql="select * from comment where c_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				cdto.setB_num(rs.getInt("b_num"));
				cdto.setRe_seq(rs.getInt("re_seq"));
				cdto.setRe_ref(rs.getInt("re_ref"));
				cdto.setRe_lev(rs.getInt("re_lev"));
			}
			
			re_lev=cdto.getRe_lev()+1;
			
			//re_ref 같은 그룹,re_seq 기존의 값보다 큰 게 있으면 +1 증가 
			
			sql="update comment set re_seq = re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cdto.getRe_ref());
			pstmt.setInt(2, cdto.getRe_seq());
			
			pstmt.executeUpdate();	
			
			sql="insert into comment (email,b_num,c_content,re_seq,f_name,l_name,re_lev,re_ref) values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setInt(2, cdto.getB_num());
			pstmt.setString(3, content);
			pstmt.setInt(4, cdto.getRe_seq()+1);//sequence
			pstmt.setString(5, firstName);
			pstmt.setString(6, lastName);
			pstmt.setInt(7, cdto.getRe_lev()+1);//level
			pstmt.setInt(8, cdto.getRe_ref());//reference
			pstmt.executeUpdate();
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		name=lastName+" "+firstName;
		arr.add(name);
		arr.add(re_lev);
		return arr;
	}
	
	public void commentDelete(int c_num) {
		
		try {
			con=getCon();
			sql="delete from comment where c_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, c_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}
	
	public void commentUpdate(int c_num, String content) {
		try {
			con=getCon();
			sql="update comment set c_content=? where c_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, c_num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}

}
