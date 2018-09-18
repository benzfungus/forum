package cn.benzfungus.forum.service;

import cn.benzfungus.forum.dao.BoardDao;
import cn.benzfungus.forum.dao.PostDao;
import cn.benzfungus.forum.dao.TopicDao;
import cn.benzfungus.forum.dao.UserDao;
import cn.benzfungus.forum.domain.*;
import cn.benzfungus.forum.web.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class ForumService {
    @Autowired
    private TopicDao topicDao;
    @Autowired
    private BoardDao boardDao;
    @Autowired
    private PostDao postDao;
    @Autowired
    private UserDao userDao;
    private final Integer PAGE_SIZE = 5;
    /**
     * 发表一个主题帖子, 用户积分加10, 论坛版块主题帖子数加1
     * @param topic
     */
    @Transactional
    public void addTopic(Topic topic){
        Board board = boardDao.getById(topic.getBoard().getId());
        board.setTopicNum(board.getTopicNum()+ 1);
        topic.setBoard(board);
        topic.setViewNum(0);
        topic.setReplyNum(0);
        topic.setDigest(0);
        boardDao.update(board);
        topicDao.insert(topic);
        // 创建主题帖子
        topic.getMainPost().setTopic(topic);
        MainPost post = topic.getMainPost();
        post.setCreateTime(new Date());
        post.setUser(topic.getUser());
        post.setTitle(topic.getTitle());
        post.setBoard(topic.getBoard());
        post.setType(1);
        post.setTopic(topic);
        // 持久化主题帖子
        postDao.insert(post);
        // 更新用户积分
        User user = topic.getUser();
        user.setCredit(user.getCredit() + 10);
        userDao.update(user);
    }

    /**
     * 删除一个主题贴, 用户积分减50, 论坛的主题帖子数减一, 并删除所有关联的帖子
     * @param topicId
     */
    @Transactional
    public void removeTopic(int topicId){
        Topic topic = topicDao.getById(topicId);
        // 将板块的主题帖子数减一
        Board board = boardDao.getById(topic.getBoard().getId());
        board.setTopicNum(board.getTopicNum() - 1);
        boardDao.update(board);
        // 发表该主题的用户扣除50积分
        User user = userDao.getById(topic.getUser().getId());
        user.setCredit(user.getCredit() - 50);
        // 删除主题帖子及相关的帖子
        topicDao.deleteById(topicId);
        postDao.deleteTopicPosts(topicId);
        //更新用户信息
        userDao.update(user);
    }

    /**
     * 添加一个回复帖子, 用户积分加5, 主题帖子回复数加1, 并更新最后回复时间
     * @param post
     */
    @Transactional
    public void addPost(Post post){

        User user = post.getUser();
        post.setType(2);
        user.setCredit(user.getCredit() + 5);
        userDao.update(user);
        Topic topic = topicDao.getById(post.getTopic().getId());
        topic.setReplyNum(topic.getReplyNum() + 1);
        topic.setLastPost(new Date());
        postDao.insert(post);
        topicDao.update(topic);
    }

    /**
     * 获取所有的论坛版块
     * @return
     */
    public List<Board> getAllBoards(){
        return boardDao.getAll();
    }

    /**
     * 创建一个新的论坛版块
     *
     * @param board
     */
    public void addBoard(Board board) {
        board.setTopicNum(0);
        boardDao.insert(board);
    }

    /**
     * 根据boardId获取Board对象
     *
     * @param boardId
     */
    public Board getBoardById(int boardId) {
        return boardDao.getById(boardId);
    }

    public List<Topic> getAllTopicByBoardId(int boardId){
        List<Topic> topics = topicDao.getAll();
        List<Topic> needTopics = new ArrayList<>();
        for(Topic t : topics){
            if(t.getBoard().getId() == boardId){
                needTopics.add(t);
            }
        }
        return needTopics;
    }

    public List<Post> getAllPostByTopicId(int topicId){
        List<Post> posts = postDao.getAll();
        List<Post> needPosts = new ArrayList<>();
        for(Post p : posts){
            if(p.getTopic().getId().equals(topicId)){
                needPosts.add(p);
            }
        }
        return needPosts;
    }

    /**
     * 根据topicId获取Topic对象
     * @param topicId
     * @return Topic
     */
    public Topic getTopicByTopicId(int topicId) {
        return topicDao.getById(topicId);
    }

    /**
     * 获取回复帖子的对象
     * @param postId
     * @return 回复帖子的对象
     */
    public Post getPostByPostId(int postId){
        return postDao.getById(postId);
    }

//    /**
//     * 获取同主题每一页帖子，以最后回复时间降序排列
//     * @param
//     * @return
//     */
//    public Page getPagedPosts(int topicId, int pageNo, int pageSize){
//        return postDao.getPagedPosts(topicId,pageNo,pageSize);
//    }

    /**
     * 删除一个版块
     * @param boardId
     */
    public void removeBoard(int boardId){
        boardDao.deleteById(boardId);
    }

    /**
     * 将帖子置为精华主题帖
     * @param topicId 操作的目标主题帖ID
     */
    @Transactional
    public void makeDigestTopic(int topicId){
        Topic topic = topicDao.getById(topicId);
        topic.setDigest(Topic.DIGEST_TOPIC);
        User user = userDao.getById(topic.getUser().getId());
        user.setCredit(user.getCredit() + 100);
        topicDao.update(topic);
        userDao.update(user);
    }

    /**
     * 获取论坛版块某一页主题帖，以最后回复时间降序排列
     * @param boardId
     * @return
     */
    public Page getPagedTopics(int boardId, int pageNo){

        Integer total = topicDao.getAllByBoardId(boardId).size();
        PageHelper.startPage(pageNo, PAGE_SIZE, true);
        List<Topic> list = topicDao.getAllByBoardId(boardId);
        Page page = new Page(pageNo, total, PAGE_SIZE, list);
        return page;
    }

    /**
     * 获取同主题每一页帖子，以最后回复时间降序排列
     * @param topicId
     * @return
     */
    public Page getPagedPosts(int topicId,int pageNo){

        Integer total = postDao.getAllByTopicId(topicId).size();
        PageHelper.startPage(pageNo, PAGE_SIZE);
        List<Post> list = postDao.getAllByTopicId(topicId);
        Page page = new Page(pageNo, total, PAGE_SIZE, list);
        return page;
    }
}
