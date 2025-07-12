package com.kv.app.core.entity;

import com.kv.app.core.encryption.EncryptConverter;
import com.kv.app.core.encryption.EncryptUtil;
import jakarta.persistence.*;

import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "users")
@NamedQueries({
        @NamedQuery(name = "User.FindAll",query = "select u from User u"),
        @NamedQuery(name = "User.findByUserName",query = "select u from User u where u.username =:username"),
        @NamedQuery(name = "User.findByNic",query = "select u from User u where u.nic =:nic"),
        @NamedQuery(name = "User.findByEmail",query = "select u from User u where u.email =:email")
})
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Column(name = "fname") @Convert(converter = EncryptConverter.class)
    private String fname;
    @Column(name = "lname") @Convert(converter = EncryptConverter.class)
    private String lname;
    @Column(name = "email",unique = true) @Convert(converter = EncryptConverter.class)
    private String email;
    @Column(name = "mobile") @Convert(converter = EncryptConverter.class)
    private String mobile;
    @Column(name = "nic",unique = true) @Convert(converter = EncryptConverter.class)
    private String nic;
    @Column(name = "username") @Convert(converter = EncryptConverter.class)
    private String username;
    @Column(name = "password")
    private String password;
    @Column(name = "userType")
    @Enumerated(EnumType.STRING)
    private UserType userType = UserType.USER;
    @Column(name = "verificationCode")
    private String verificationCode;
    @OneToMany(mappedBy = "user",cascade = CascadeType.ALL,fetch = FetchType.LAZY)
    private List<Account> accounts;

    public User() {
    }

    public User(String fname, String lname, String email, String mobile, String nic) {
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.mobile = mobile;
        this.nic = nic;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public List<Account> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<Account> accounts) {
        this.accounts = accounts;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }
}
