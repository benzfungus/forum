package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.Board;
import cn.benzfungus.forum.domain.LoginLog;
import cn.benzfungus.forum.domain.Post;
import cn.benzfungus.forum.domain.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/spring-dao.xml")
public class BoardDaoTest {
    @Autowired
    private BoardDao bdao;

    @Test
    public void testGetAll(){
        System.out.println(bdao.getAll());
    }

    @Test
    public void testInsert(){
        Board board = new Board();
        board.setName("SpringSpring");
        board.setDesc("BBBBBXBBX");
        Post post = new Post();
        post.setId(1);
        board.setTopicNum(0);
        board.setMainPost(post);
        bdao.insert(board);
    }

    @Test
    public void testDelete(){
        bdao.deleteById(7);
    }

    @Test
    public void testUpdate(){
        Board board = new Board();
        board.setId(1L);
        board.setName("SpringSpring");
        Post post = new Post();
        post.setId(1);
        board.setMainPost(post);
        bdao.update(board);
    }

    @Test
    public void testGetById(){
        System.out.println(bdao.getById(1L));
    }
}
