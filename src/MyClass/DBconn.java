package MyClass;

import java.sql.*;

public class DBconn {
	private Connection conn = null; // 数据库连接
	private Statement stmt = null;  // 接口实例
	private ResultSet rs = null;    // 数据集
	private String DBDriver = "sun.jdbc.odbc.JdbcOdbcDriver"; // 驱动程序
	private String ConnString = "jdbc:odbc:banji"; // 数据库连接odbc
	private String username = ""; // 数据库用户名
	private String password = ""; // 数据库密码	

	private String RealPath = ""; //当前网页的物理路径

	// String RealPath = getServletContext().getRealPath("\\"); //当前物理路径
	// String dbPath = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ="
	// + RealPath + "Data\\student.mdb"; //数据库连接方式(1)：直接连接Access数据库文件
	// String dbPath = "jdbc:odbc:banji"; //数据库连接方式(2)：数据库连接odbc

	// Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); //加载驱动程序
	// Connection con = DriverManager.getConnection(dbPath); //连接数据库
	// Statement st = con.createStatement(); //创建接口st
	// String sql = "select * from student where number='" + number + "'";
	// **** ResultSet rs = st.executeQuery(sql); //1--执行查询
	// String sql = "update student set number='" + number + "'";
	// **** i = st.executeUpdate(sql); //2--执行插入、更改或删除操作，返回被影响的记录行数

	public void setConnString(String connString) {
		ConnString = connString;
	}

	public void setRealPath(String realPath) {
		RealPath = realPath;  //c:\opensource\Tomcat6.0\webapp\news\Data\student.mdb
		ConnString = "jdbc:odbc:driver={Microsoft Access Driver (*.mdb)};DBQ="
			+ RealPath + "Data\\book.mdb"; //数据库连接方式：直接连接Access数据库文件;
	}

	// 构造器：加载数据库驱动
	public DBconn() {
		try {
			Class.forName(DBDriver); // 加载驱动程序
			
		} catch (Exception e) {
			System.out.println("DBconn: " + e.getMessage()); //错误输出
		}
	}

	// 数据查询 活动游标接口stmt
	public ResultSet executeQuery(String sql) {
		rs = null;

		try {
			conn = DriverManager.getConnection(ConnString, username, password); // 连接数据库
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_READ_ONLY); // 创建接口stmt，数据游标能灵活前后移动，只读
			//stmt = conn.createStatement(); // 创建普通接口stmt
			rs = stmt.executeQuery(sql); // 执行查询，返回记录集ResultSet
			
		} catch (SQLException e) {
			System.out.println("executeQuery: " + e.getMessage());
		}
		
		return rs;
	}
	
	// 数据查询 普通接口stmt
	public ResultSet executeQueryCount(String sql) {
		rs = null;

		try {
			conn = DriverManager.getConnection(ConnString, username, password); // 连接数据库
			//stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
			//		ResultSet.CONCUR_READ_ONLY); // 创建接口stmt，数据游标能灵活前后移动，只读
			stmt = conn.createStatement(); // 创建普通接口stmt
			rs = stmt.executeQuery(sql); // 执行查询，返回记录集ResultSet
			
		} catch (SQLException e) {
			System.out.println("executeQuery: " + e.getMessage());
		}
		
		return rs;
	}
	
	// 数据插入、更新或删除
	public int executeUpdate(String sql) {
		int i = 0;

		try {
			conn = DriverManager.getConnection(ConnString, username, password);
			stmt = conn.createStatement();
			i = stmt.executeUpdate(sql); // 执行数据插入、更新或删除，得到被影响的记录数
			conn.close(); //立即关闭连接
			
		} catch (SQLException e) {
			System.out.println("executeUpdate: " + e.getMessage());
		}
		
		return i;
	}

	// 数据库连接关闭
	public void close() {
		try {
			if (conn != null && conn.isClosed() == false) //非空且连接中
				conn.close(); //关闭数据库连接
			
		} catch (SQLException e) {
			System.out.println("close: " + e.getMessage());
		}
	}

}
