package com.dao;

import com.detail.City;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CityDAO {
    private final Connection conn;

    public CityDAO(Connection conn) {
        this.conn = conn;
    }

    public List<City> getAllCities() {
        List<City> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM city";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                City city = new City();
                city.setId(rs.getInt("id"));
                city.setName(rs.getString("name"));
                list.add(city);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
