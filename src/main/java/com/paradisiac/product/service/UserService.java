package com.paradisiac.product.service;

import com.paradisiac.product.dto.UserLoginRequest;
import com.paradisiac.product.dto.UserRegisterRequest;
import com.paradisiac.product.model.User;

public interface UserService {

    User getUserById(Integer userId);

    Integer register(UserRegisterRequest userRegisterRequest);

    User login(UserLoginRequest userLoginRequest);
}
