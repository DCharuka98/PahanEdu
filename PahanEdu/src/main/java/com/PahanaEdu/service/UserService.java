package com.PahanaEdu.service;

import com.PahanaEdu.dao.UserDAO;
import com.PahanaEdu.model.User;

import java.sql.SQLException;

public class UserService {

    private UserDAO userDAO;

    public UserService() throws SQLException {
        this.userDAO = new UserDAO();
    }

    public boolean isUsernameTaken(String username) throws SQLException {
        return userDAO.usernameExists(username);
    }

    public boolean register(User user) throws SQLException {
        return userDAO.registerUser(user);
    }
}
