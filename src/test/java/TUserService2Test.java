import com.bdqn.entity.TUser;
import com.bdqn.service.TUserService2;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 大聪 on 2017/12/7.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TUserService2Test {
    @Resource
    private TUserService2 tUserService2;
    @Test
    public void login() throws Exception {
        TUser tUser = new TUser();
        tUser.setUserName("admin");
        tUser.setPassword("abc");
        tUserService2.login(tUser);
        System.out.println(tUser);
    }

    @Test
    public void queryAll(){
        PageInfo<TUser> pageInfo = tUserService2.queryAll(1,3);
        List<TUser> list= pageInfo.getList();
        if (list != null) {
            for (TUser tUser : list) {
                System.out.println(tUser);
            }
        }
    }

}