package cn.benzfungus.forum.service;

import cn.benzfungus.forum.dao.LoginLogDao;
import cn.benzfungus.forum.dao.UserDao;
import cn.benzfungus.forum.domain.LoginLog;
import cn.benzfungus.forum.domain.User;
import cn.benzfungus.forum.exception.UserExistException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class UserService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private LoginLogDao loginLogDao;

    /**
     * 注册一个新用户, 如果用户名存在, 则抛出UserExistException异常
     * @param user
     * @throws UserExistException
     */
    
    public void register(User user) throws UserExistException {
        User u = getUserByUsername(user.getUsername());
        if (u != null) {
            throw new UserExistException("用户名已经存在");
        }else {
            user.setCredit(100);
            user.setType(1L);
            user.setLocked(0);
            userDao.insert(user);
        }
    }

    /**
     * 根据用户名获取User对象
     * @param username
     * @return
     */
    public User getUserByUsername(String username) {
        return userDao.getByName(username);
    }

    /**
     * 根据ID获取User对象
     * @param userId
     * @return
     */
    public User getUserById(long userId){
        return userDao.getById(userId);
    }

    /**
     * 将用户锁定, 锁定后用户无法登录
     * @param username
     */
    public void lockUser(String username){
        User user = getUserByUsername(username);
        user.setLocked(User.USER_LOCK);
        userDao.update(user);
    }

    /**
     * 解除用户锁定
     * @param username
     */
    public void unlockUser(String username){
        User user = getUserByUsername(username);
        user.setLocked(User.USER_UNLOCK);
        userDao.update(user);
    }

    /**
     * 登陆成功
     * @param user
     */
    @Transactional
    public void loginSuccess(User user) {
        user.setCredit( 5 + user.getCredit());
        LoginLog loginLog = new LoginLog();
        loginLog.setUser(user);
        loginLog.setIp(user.getLastIp());
        loginLog.setLoginTime(new Date());
        userDao.update(user);
        loginLogDao.insert(loginLog);
    }
    /**
     * 更新用户
     * @param user
     */
    public void update(User user){
        userDao.update(user);
    }

    /**
     * 获取所有用户
     * @return 所有用户
     */
    public List<User> getAllUsers(){
        return userDao.getAll();
    }

}
