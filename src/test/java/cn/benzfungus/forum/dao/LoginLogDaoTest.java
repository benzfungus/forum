package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.LoginLog;
import cn.benzfungus.forum.domain.User;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class LoginLogDaoTest {
    @Autowired
    private LoginLogDao ldao;

    @Test
    public void testGetAll(){
        System.out.println(ldao.getAll());
    }

    @Test
    public void testInsert(){
        LoginLog log = new LoginLog();
        log.setIp("172.18.104.22");
        log.setLoginTime(new Date());
        User user = new User();
        user.setId(4);
        log.setUser(user);
        ldao.insert(log);
    }

    @Test
    public void testDelete(){
        ldao.deleteById(3);
    }

    @Test
    public void testUpdate(){
        LoginLog log = new LoginLog();
        log.setId(1);
        log.setIp("199.99.99.1");
        ldao.update(log);
    }

    @Test
    public void testGetById(){
        System.out.println(ldao.getById(1L));
    }
}
