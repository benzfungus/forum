package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.User;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class UserDaoTest {
    @Autowired
    private UserDao udao;

    @Test
    @Ignore
    public void testGetAll(){
        System.out.println(udao.getAll());
    }

    @Test
    @Ignore
    public void testInsert(){
        User user = new User();
        user.setUsername("bbx");
        user.setPassword("123456");
        user.setLocked(0);
        user.setCredit(110);
        user.setType(2L);
        udao.insert(user);
    }

    @Test
    @Ignore
    public void testDelete(){
        udao.deleteById(3);
    }

    @Test
    @Ignore
    public void testUpdate(){
        User user = new User();
        user.setId(1);
        user.setPassword("123456");
        udao.update(user);
    }

    @Test
    public void testGetById(){
        System.out.println(udao.getById(1L));
    }

    @Test
    public void testGetByName(){
        System.out.println(udao.getByName("ccs"));
    }
}
