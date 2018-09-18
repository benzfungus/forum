package cn.benzfungus.forum.domain;

import java.util.Date;

public class Topic extends BaseDomain{
    /**
     * 精华主题帖子
     */
    public static final int DIGEST_TOPIC = 1;
    /**
     * 普通的主题帖子
     */
    public static final int NOT_DIGEST_TOPIC = 0;

    private Integer id;
    private Board board;
    private String title;
    private Date createTime;
    private Date lastPost;
    private Integer viewNum;
    private Integer replyNum;
    private Integer digest;
    private User user;
    private MainPost mainPost = new MainPost();

    public MainPost getMainPost() {
        return mainPost;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Board getBoard() {
        return board;
    }

    public void setBoard(Board board) {
        this.board = board;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getLastPost() {
        return lastPost;
    }

    public void setLastPost(Date lastPost) {
        this.lastPost = lastPost;
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public Integer getReplyNum() {
        return replyNum;
    }

    public void setReplyNum(Integer replyNum) {
        this.replyNum = replyNum;
    }

    public Integer getDigest() {
        return digest;
    }

    public void setDigest(Integer digest) {
        this.digest = digest;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
