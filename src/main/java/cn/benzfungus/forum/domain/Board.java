package cn.benzfungus.forum.domain;

public class Board extends BaseDomain {
    private Long id;
    private String name;
    private String desc;
    private Integer topicNum;
    private Post mainPost;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Integer getTopicNum() {
        return topicNum;
    }

    public void setTopicNum(Integer topicNum) {
        this.topicNum = topicNum;
    }

    public Post getMainPost() {
        return mainPost;
    }

    public void setMainPost(Post mainPost) {
        this.mainPost = mainPost;
    }
}
