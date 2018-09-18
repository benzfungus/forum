package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.Post;

import java.util.BitSet;
import java.util.List;

public interface PostDao extends BaseDao<Post> {
    /**
     * 删除主题相关联的帖子
     * @param topicId
     */
    void deleteTopicPosts(int topicId);

    List<Post> getAllByTopicId(int topicId);
}
