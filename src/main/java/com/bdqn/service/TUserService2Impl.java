package com.bdqn.service;

import com.bdqn.dao.TUserMapper2;
import com.bdqn.entity.TUser;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 大聪 on 2017/12/7.
 */
@Service("tUserService2")
public class TUserService2Impl implements TUserService2 {
    @Resource
    private TUserMapper2 tUserMapper2;
    @Override
    public TUser login(TUser tUser) {
        return tUserMapper2.login(tUser);
    }

    @Override
    public PageInfo<TUser> queryAll(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<TUser> list = tUserMapper2.queryAll();
        PageInfo<TUser> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }
}
