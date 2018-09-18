package cn.benzfungus.forum.dao;

import java.util.List;

public interface BaseDao<T> {
    /**
     * 通过Id获取对象
     * @param id
     * @return
     */
    T getById(long id);

    /**
     * 通过name获取对象
     * @param name
     * @return
     */
    T getByName(String name);


    /**
     * 获取所有
     * @return
     */
    List<T> getAll();

    /**
     * 添加
     * @param object
     */
    void insert(T object);

    /**
     * 删除
     * @param id
     */
    void deleteById(long id);

    /**
     * 更新
     * @param object
     */
    void update(T object);
}
