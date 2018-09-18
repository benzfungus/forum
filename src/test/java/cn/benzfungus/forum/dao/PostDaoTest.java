package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.Board;
import cn.benzfungus.forum.domain.Post;
import cn.benzfungus.forum.domain.Topic;
import cn.benzfungus.forum.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class PostDaoTest {
    @Autowired
    private PostDao pdao;

    @Test
    public void testGetAll(){
        System.out.println(pdao.getAll());
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
        topic.setId(24);
        topic.setUser(user);
        Post post = new Post();
        post.setTitle("SPRING DAY");
        post.setText("this is a spring day");
        post.setBoard(board);
        post.setType(1);
        post.setCreateTime(new Date());
        post.setTopic(topic);
        post.setUser(user);
        pdao.insert(post);
    }

    @Test
    public void testDelete(){
        pdao.deleteById(3);
    }

    @Test
    public void testUpdate(){
        Post post = new Post();
        post.setId(1);
        post.setTitle("BBXBBX");
        post.setText("BBXBBXBBX");
        pdao.update(post);
    }

    @Test
    public void testGetById(){
        System.out.println(pdao.getById(4));
    }
}
