package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.Board;
import cn.benzfungus.forum.domain.Topic;
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
public class TopicDaoTest {
    @Autowired
    private TopicDao tdao;

    @Test
    public void testGetAll(){
        System.out.println(tdao.getAll());
    }

    @Test
    public void testInsert(){
        Topic topic = new Topic();
        Board board = new Board();
        topic.setTitle("Spring spring");
        board.setId(1L);
        topic.setBoard(board);
        topic.setCreateTime(new Date());
        topic.setLastPost(new Date());
        topic.setDigest(1);
        topic.setViewNum(5);
        topic.setReplyNum(5);
        User user = new User();
        user.setId(2);
        topic.setUser(user);
        tdao.insert(topic);
    }

    @Test
    public void testDelete(){
        tdao.deleteById(3);
    }

    @Test
    public void testUpdate(){
        Topic topic = new Topic();
        topic.setId(2);
        topic.setTitle("BBXBBX");
        tdao.update(topic);
    }

    @Test
    public void testGetById(){
        System.out.println(tdao.getById(6L));
    }
}
