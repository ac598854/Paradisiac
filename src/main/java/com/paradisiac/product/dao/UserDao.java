package com.paradisiac.product.dao;

import com.paradisiac.product.dto.UserRegisterRequest;
import com.paradisiac.product.model.User;

public interface UserDao {

    User getUserById(Integer userId);

    User getUserByEmail(String email);

    Integer createUser(UserRegisterRequest userRegisterRequest);
}
