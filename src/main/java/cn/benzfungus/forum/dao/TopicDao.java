package cn.benzfungus.forum.dao;

import cn.benzfungus.forum.domain.Topic;

import java.util.List;


public interface TopicDao extends BaseDao<Topic> {
    List<Topic> getAllByBoardId(Integer boardId);
}
