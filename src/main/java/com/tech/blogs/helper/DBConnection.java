package com.tech.blogs.helper;

import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {

	private static Connection connection;

	public static Connection getDBConnection() {

		try {

			FileInputStream fileInputStream = new FileInputStream(
					"D:\\Study\\java\\NewIDE\\TechnicalBlogs_V0\\src\\main\\java\\db.properties");

			Properties props = new Properties();
			props.load(fileInputStream);

			// properties to connect with DB
			String driver = props.getProperty("driver");
			
			System.out.println(driver);
			String url = props.getProperty("url");
			String dbUserName = props.getProperty("user");
			String dbPassword = props.getProperty("password");
			
			System.out.println(dbPassword);

			if (connection == null) {
				// load driver class

				Class.forName(driver);

				// established connection with DB
				connection = DriverManager.getConnection(url, dbUserName, dbPassword);
				System.out.println(connection);
			 }
			else {
				System.out.println("connection already created");
				return connection;
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		return connection;
	}

}
