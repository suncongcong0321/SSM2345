package com.bdqn.service;

import com.bdqn.entity.TUser;
import com.github.pagehelper.PageInfo;

/**
 * Created by 大聪 on 2017/12/7.
 */
public interface TUserService2 {

    public TUser login(TUser tUser);

    public PageInfo<TUser> queryAll(Integer pageNum, Integer pageSize);
}
