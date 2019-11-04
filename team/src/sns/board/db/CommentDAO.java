package sns.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import sns.member.db.MemberDAO;
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
	
	public CommentDTO commentInsert(int bNum, String content, int m_num){
		String firstName="";
		String lastName="";
		CommentDTO cdto=new CommentDTO();
		MemberDAO mdao=new MemberDAO();
		int last_index=0;
		
		try {
			con=getCon();
			sql="select * from member where m_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, m_num);
			rs=pstmt.executeQuery();
			if(rs.next()){
				firstName=rs.getString("f_name");
				lastName=rs.getString("l_name");
			}
			
			//>>>>>sql update comment set re_ref=c_num<<<<<
			
			sql="insert into comment (c_m_num,b_num,c_content,re_seq,re_lev) values(?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, m_num);
			pstmt.setInt(2, bNum);
			pstmt.setString(3, content);
			pstmt.setInt(4, 0);//sequence
			
			pstmt.setInt(5, 0);//level
			pstmt.executeUpdate();
			
			sql="select last_insert_id()";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				
				last_index=rs.getInt(1);
				System.out.println("lastInsert: "+last_index);
			}
			
			sql="select c_num,b_num,c_content,c_date from comment where c_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, last_index);
			rs=pstmt.executeQuery();
			if(rs.next()){
				
				cdto.setC_num(rs.getInt("c_num"));
				cdto.setB_num(rs.getInt("b_num"));
				cdto.setC_content(rs.getString("c_content"));
				cdto.setC_date(rs.getTimestamp("c_date"));
				
				
								
			}
			cdto.setF_name(firstName);
			cdto.setL_name(lastName);
			cdto.setEmail(mdao.getEmail(m_num));
			
		} catch (Exception e) {			
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return cdto;
		//LAST_INSERT_ID() 찾아보기
				
	}
	
	public ArrayList<CommentDTO> commentRead(int bNum,int num) {
		ArrayList<CommentDTO> arr=new ArrayList<CommentDTO>();
		MemberDAO mdao=new MemberDAO();
				
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
				cdto.setC_m_num(rs.getInt("c_m_num"));
				
				cdto.setEmail(mdao.getEmail(cdto.getC_m_num()));
				
				cdto.setRe_seq(rs.getInt("re_seq"));
				cdto.setRe_lev(rs.getInt("re_lev"));
				
				sql="select f_name, l_name from member where email=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, cdto.getEmail());
				ResultSet rs2=pstmt.executeQuery();
				if(rs2.next()){
					cdto.setF_name(rs2.getString("f_name"));
					cdto.setL_name(rs2.getString("l_name"));
				}				
				arr.add(cdto);
				rs2.close();
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
	
	public CommentDTO commentReInsert(String content, int c_num, int m_num){
		//1. 이름가져오기용
		String firstName="";
		String lastName="";
		int last_index=0;	
		
		MemberDAO mdao=new MemberDAO();
				
		//2. 가지고 온 c_num으로 대댓글이 달리게 될 댓글의 정보를 조회
		CommentDTO cdto= new CommentDTO();
		
		//3. 기존의 seq 처리
		
		//4. 대댓글의 정보를 넣는다 
		
		try {
			con=getCon();
			con=getCon();
			sql="select * from member where m_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, m_num);
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
			
			
			
			//re_ref 같은 그룹,re_seq 기존의 값보다 큰 게 있으면 +1 증가 
			
			sql="update comment set re_seq = re_seq+1 where re_ref=? and re_seq>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cdto.getRe_ref());
			pstmt.setInt(2, cdto.getRe_seq());
			
			pstmt.executeUpdate();	
			
			sql="insert into comment (c_m_num,b_num,c_content,re_seq,re_lev,re_ref) values(?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, m_num);
			pstmt.setInt(2, cdto.getB_num());
			pstmt.setString(3, content);
			pstmt.setInt(4, cdto.getRe_seq()+1);//sequence
			
			pstmt.setInt(5, cdto.getRe_lev()+1);//level
			pstmt.setInt(6, cdto.getRe_ref());//reference
			pstmt.executeUpdate();
			
			sql="select last_insert_id()";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				
				last_index=rs.getInt(1);
				System.out.println("lastReInsert: "+last_index);
			}
			
			sql="select * from comment where c_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, last_index);
			rs=pstmt.executeQuery();
			if(rs.next()){
				
				cdto.setC_num(rs.getInt("c_num"));
				cdto.setB_num(rs.getInt("b_num"));
				cdto.setC_content(rs.getString("c_content"));
				cdto.setC_date(rs.getTimestamp("c_date"));
				cdto.setEmail(mdao.getEmail(m_num));
				cdto.setF_name(firstName);
				cdto.setL_name(lastName);
				cdto.setRe_lev(rs.getInt("re_lev"));
				cdto.setRe_ref(rs.getInt("re_ref"));
				cdto.setRe_seq(rs.getInt("re_seq"));}				
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return cdto;
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
