package com.shop.db;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DataAccess {

    public Connection cn;
    public ResultSet rs;

    public DataAccess() {
    }

    public void connectToServer() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost/FootDB", "root", "narayan");
    }

    public void closeConnection() throws Exception {
        cn.close();
    }

    public int execute(String sql, String... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql);
        int i = 1;
        for (String prm : params) {
            ps.setString(i, prm);
            i++;
        }
        int result = ps.executeUpdate(); // Returns number of rows affected
        closeConnection();
        return result;
    }

    //  New executeSqlId() method to return generated OrderId
    public int executeSqlId(String sql, Object... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        int i = 1;
        for (Object prm : params) {
            if (prm instanceof Integer) {
                ps.setInt(i, (Integer) prm);
            } else {
                ps.setString(i, prm.toString());
            }
            i++;
        }
        ps.executeUpdate();
        
        ResultSet rs = ps.getGeneratedKeys();
        int id = 0;
        if (rs.next()) {
            id = rs.getInt(1);
        }
        rs.close();
        closeConnection();
        return id;
    }

    public int executeId(String sql, String... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        int i = 1;
        for (String prm : params) {
            ps.setString(i, prm);
            i++;
        }
        ps.executeUpdate(); 
        ResultSet rs = ps.getGeneratedKeys();
        rs.next();
        int id = rs.getInt(1);
        rs.close();
        closeConnection();
        return id;
    }

    public ResultSet getRows(String sql, String... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql);
        int i = 1;
        for (String prm : params) {
            ps.setString(i, prm);
            i++;
        }
        rs = ps.executeQuery();
        return rs;
    }

    public int execute(String sql, int fileindex, byte[] data, String... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql);
        int i = 1;
        for (String prm : params) {
            if (i == fileindex) {
                Blob blob = new javax.sql.rowset.serial.SerialBlob(data);
                ps.setBlob(i, blob);
            } else {
                ps.setString(i, prm);
            }
            i++;
        }
        int result = ps.executeUpdate();
        closeConnection();
        return result;
    }

    public int executeBytes2(String sql, String accid, byte[]... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql);
        int i = 1;
        for (byte[] prm : params) {
            Blob blob = new javax.sql.rowset.serial.SerialBlob(prm);
            ps.setBlob(i, blob);
            i++;
        }
        ps.setString(i, accid);
        int result = ps.executeUpdate();
        closeConnection();
        return result;
    }

    public boolean isExists(String sql, String... params) throws Exception {
        boolean flag = false;
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql);
        int i = 1;
        for (String prm : params) {
            ps.setString(i, prm);
            i++;
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            flag = true;
        }
        closeConnection();
        return flag;
    }

    public ResultSet getRows2(String sql, String... params) throws Exception {
        ResultSet rss;
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(sql);
        int i = 1;
        for (String prm : params) {
            ps.setString(i, prm);
            i++;
        }
        rss = ps.executeQuery();
        return rss;
    }

    public String getID(String fieldname, String tablename) throws Exception {
        connectToServer();
        ResultSet rs = getRows("SELECT IF(MAX(" + fieldname + ") IS NULL, 1, MAX(" + fieldname + ") + 1) FROM " + tablename);
        rs.next();
        String id = rs.getString(1);
        return id;
    }
    public int executeSql(String query, Object... params) throws Exception {
        connectToServer();
        PreparedStatement ps = cn.prepareStatement(query);
        int index = 1;
        
        for (Object param : params) {
            if (param instanceof Integer) {
                ps.setInt(index, (Integer) param);
            } else if (param instanceof String) {
                ps.setString(index, (String) param);
            } else {
                ps.setObject(index, param);
            }
            index++;
        }
        
        int rowsAffected = ps.executeUpdate();
        closeConnection();
        return rowsAffected;
    }

}
