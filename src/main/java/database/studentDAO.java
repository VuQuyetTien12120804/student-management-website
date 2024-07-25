package database;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import database.JDBCUtil;
import model.student;
import util.encryption;

public class studentDAO implements DAOInterface<student>{
	
	@Override
	public ArrayList<student> selectAll() {
		ArrayList<student> ketqua = new ArrayList<student>();
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "SELECT * FROM student";
			PreparedStatement st = con.prepareStatement(sql);
			
			// Bước 3: thực thi câu lệnh SQL
			System.out.println(sql);
			ResultSet rs = st.executeQuery();
			
			// Bước 4:
			while(rs.next()) {
				String studentID = rs.getString("studentID");
				String password = rs.getString("password");
				String fullName = rs.getString("fullName");
				String gender = rs.getString("gender");
				String dateOfBirth = rs.getString("dateOfBirth");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				
				student s = new student(studentID, password,fullName,gender, dateOfBirth, address, phone, email);
				ketqua.add(s);		
			}
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ketqua;
	}
	
	private int noOfRecords;

    public ArrayList<student> selectStudents(int offset, int noOfRecords) {
        ArrayList<student> list = new ArrayList<student>();
        Connection connection = JDBCUtil.getConnection();
        try {
            String query = "SELECT SQL_CALC_FOUND_ROWS * FROM students LIMIT ?, ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, offset);
            statement.setInt(2, noOfRecords);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                student s = new student();
                s.setStudentID(resultSet.getString("studentID"));
                s.setPassword(resultSet.getString("password"));
                // set other fields...
                list.add(s);
            }
            resultSet.close();

            resultSet = statement.executeQuery("SELECT FOUND_ROWS()");
            if (resultSet.next())
                this.noOfRecords = resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	JDBCUtil.closeConnection(connection);
        }
        return list;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }
	
	public ArrayList<student> selectByStudentID(String studentID) {
        ArrayList<student> studentList = new ArrayList<>();
        try {
            Connection con = JDBCUtil.getConnection();
            String sql = "SELECT * FROM student WHERE studentID LIKE ?";
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, "%" + studentID + "%");
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                String id = rs.getString("studentID");
                String password = rs.getString("password");
                String fullName = rs.getString("fullName");
                String gender = rs.getString("gender");
                String dateOfBirth = rs.getString("dateOfBirth");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String email = rs.getString("email");

                student s = new student(id, password, fullName, gender, dateOfBirth, address, phone, email);
                studentList.add(s);
            }

            JDBCUtil.closeConnection(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return studentList;
    }

	
	@Override
	public student selectById(student t) {
		student ketQua = null;
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "SELECT * FROM student WHERE studentID=?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, t.getStudentID());
			
			// Bước 3: thực thi câu lệnh SQL
			System.out.println(sql);
			ResultSet rs = st.executeQuery();
			
			// Bước 4:
			while(rs.next()) {
				String studentID = rs.getString("studentID");
				String password = rs.getString("password");
				String fullName = rs.getString("fullName");
				String gender = rs.getString("gender");
				String dateOfBirth = rs.getString("dateOfBirth");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				
				ketQua = new student(studentID, password,fullName,gender, dateOfBirth, address, phone , email );
				break;	
			}
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ketQua;
	}
	
	public student selectByIdAndPassword(student t) {
		student ketQua = null;
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "SELECT * FROM student WHERE studentID=? and password=?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, t.getStudentID());
			st.setString(2, t.getPassword());
			
			// Bước 3: thực thi câu lện h SQL
			System.out.println(sql);
			ResultSet rs = st.executeQuery();
			
			// Bước 4:
			while(rs.next()) {
				String studentID = rs.getString("studentID");
				String password = rs.getString("password");
				String fullName = rs.getString("fullName");
				String gender = rs.getString("gender");
				String dateOfBirth = rs.getString("dateOfBirth");
				String address = rs.getString("address");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				password = encryption.toSHA1(password);
				
				ketQua = new student(studentID, password,fullName,gender, dateOfBirth, address, phone , email );
				break;	
			}
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ketQua;
	}
	@Override
	public int insert(student t) {
		int ketQua = 0;
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "INSERT INTO student (studentID, password, fullName, gender, dateOfBirth, address, phone, email) "+
					" VALUES (?,?,?,?,?,?,?,?)";
			
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, t.getStudentID());
			st.setString(2, t.getPassword());
			st.setString(3, t.getFullName());
			st.setString(4, t.getGender());
			st.setString(5, t.getDateOfBirth());
			st.setString(6, t.getAddress());
			st.setString(7, t.getPhone());
			st.setString(8, t.getEmail());
			
			// Bước 3: thực thi câu lệnh SQL
			ketQua = st.executeUpdate();
			
			// Bước 4:
			System.out.println("Bạn đã thực thi: "+ sql);
			System.out.println("Có "+ ketQua+" dòng bị thay đổi!");
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ketQua;
	}

	@Override
	public int insertAll(ArrayList<student> arr) {
		int dem = 0;
		for(student s : arr) {
			dem+= this.insert(s);
		}
		return dem;
	}

	@Override
	public int delete(student s) {
		int ketQua = 0;
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "DELETE from student "+
					 " WHERE studentID=?";
			
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, s.getEmail());
			
			// Bước 3: thực thi câu lệnh SQL
			System.out.println(sql);
			ketQua = st.executeUpdate();
			
			// Bước 4:
			System.out.println("Bạn đã thực thi: "+ sql);
			System.out.println("Có "+ ketQua+" dòng bị thay đổi!");
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ketQua;
	}
	
	public int deleteStudents(ArrayList<String> studentIds) {
	        int ketQua = 0;
	        try {
	            Connection con = JDBCUtil.getConnection();
	            String sql = "DELETE FROM student WHERE studentID = ?";
	            PreparedStatement st = con.prepareStatement(sql);

	            for (String studentID : studentIds) {
	                st.setString(1, studentID);
	                ketQua += st.executeUpdate();
	            }

	            JDBCUtil.closeConnection(con);
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return ketQua;
	    }

	
	@Override
	public int deleteAll(ArrayList<student> arr) {
		int dem = 0;
		for(student s : arr) {
			dem+= this.delete(s);
		}
		return dem;
	}

	@Override
	public int update(student s) {
		int ketQua = 0;
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "UPDATE student "+
					 " SET " +
					 " password=?"+
					 " fullName=?"+
					 " gender=?"+
					 " dateOfBirth=?"+
					 " address=?"+
					 " phone=?"+
					 " email=?"+
					 " WHERE studentID=?";
			
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, s.getStudentID());
			st.setString(2, s.getPassword());
			st.setString(3, s.getFullName());
			st.setString(4, s.getGender());
			st.setString(5, s.getDateOfBirth());
			st.setString(6, s.getAddress());
			st.setString(7, s.getPhone());
			st.setString(8, s.getEmail());
			// Bước 3: thực thi câu lệnh SQL

			System.out.println(sql);
			ketQua = st.executeUpdate();
			
			// Bước 4:
			System.out.println("Bạn đã thực thi: "+ sql);
			System.out.println("Có "+ ketQua+" dòng bị thay đổi!");
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ketQua;
	}

	public boolean checkStudentID(String studentID) {
		boolean ketQua = false;
		try {
			// Bước 1: tạo kết nối đến CSDL
			Connection con = JDBCUtil.getConnection();
			
			// Bước 2: tạo ra đối tượng statement
			String sql = "SELECT * FROM student WHERE studentID=?";
			PreparedStatement st = con.prepareStatement(sql);
			st.setString(1, studentID);
			
			// Bước 3: thực thi câu lệnh SQL
			System.out.println(sql);
			ResultSet rs = st.executeQuery();
			
			// Bước 4:
			while(rs.next()) {
				ketQua = true;
			}
			
			// Bước 5:
			JDBCUtil.closeConnection(con);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ketQua;
	}
	public static void main(String[] args) {
		studentDAO std = new studentDAO();
//		ArrayList<student> kq = std.selectAll();
//		for(student s : kq) {
//			System.out.println(s.toString());
//		}
		
		student s = std.selectById(new student("223630726", "nguyen99", "Dinh Quoc Nguyen", "male", "2004-07-05", "Ha Noi", "0987596350", "nguyen@gmail.com"));
		System.out.println(s);
		
//		student s_new = new student("223630725", "nguyen99", "Dinh Quoc Nguyen", "male", "2004-07-05", "Ha Noi", "0987596350", "nguyen@gmail.com");
//		std.insert(s_new);
		
//		student tg_new = new student("tung123@gmail.com", "5678");
//		std.delete(tg_new);
		
//		student s = std.selectById(new student("hoang@12345", "55555"));
//		System.out.println(s);
//		s.setPassword("password da bi thay doi ");
//		std.update(s);
}

}