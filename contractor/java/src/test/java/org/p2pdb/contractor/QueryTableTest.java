package org.p2pdb.contractor;

import org.junit.Test;
import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import org.apache.calcite.adapter.jdbc.JdbcSchema;
import org.apache.calcite.jdbc.CalciteConnection;
import org.apache.calcite.schema.SchemaPlus;

/**
 * This class demonstrates Calcite able to recognize tables in Postgres.
 * 
 * Before you run this class, you must create the user and database in 
 * Postgres by executing the following SQL:
 * 
 *    create user johnsnow with password 'password';
 *    create database db1 with owner johnsnow;
 * 
 */
public class QueryTableTest {
    @Test
    public void testTimeScaleDB() throws SQLException, ClassNotFoundException {
        final String dbUrl = "jdbc:postgresql://localhost:5433/db1";

        Connection con = DriverManager.getConnection(dbUrl, "johnsnow", "password");
        Statement stmt1 = con.createStatement();
        stmt1.execute("drop table if exists table1");
        stmt1.execute("create table table1(id varchar not null primary key, field1 varchar)");
        stmt1.execute("insert into table1 values('a', 'aaaa')");
        con.close();

        Connection connection = DriverManager.getConnection("jdbc:calcite:");
        CalciteConnection calciteConnection = connection.unwrap(CalciteConnection.class);
        SchemaPlus rootSchema = calciteConnection.getRootSchema();
        final DataSource ds = JdbcSchema.dataSource(dbUrl, "org.postgresql.Driver", "johnsnow", "password");
        rootSchema.add("DB1", JdbcSchema.create(rootSchema, "DB1", ds, null, null));

        Statement stmt3 = connection.createStatement();
        ResultSet rs = stmt3.executeQuery("select * from db1.\"table1\"");

        while (rs.next()) {
            System.out.println(rs.getString(1) + '=' + rs.getString(2));
        }
    }
}
