package com.detail;

/**
 *
 * @author chetan
 */
public class AdminDetail {

    private String userName;
    private String password;
    private String email;  // ✅ New field added
    private String fullName;
    private String phone;

    // --- Getter and Setter for userName ---
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // --- Getter and Setter for password ---
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // --- ✅ Getter and Setter for email ---
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
// Phone

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
