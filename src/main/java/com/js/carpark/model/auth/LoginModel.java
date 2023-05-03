package com.js.carpark.model.auth;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class LoginModel {
    private String account;
    private String password;
}
