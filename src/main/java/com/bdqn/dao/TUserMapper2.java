package com.bdqn.dao;

import com.bdqn.entity.TUser;

import java.util.List;

/**
 * Created by 大聪 on 2017/12/7.
 */
public interface TUserMapper2 {

    public TUser login(TUser tUser);

    public List<TUser> queryAll();

}
