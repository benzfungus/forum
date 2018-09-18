package cn.benzfungus.forum.web.controller;

import cn.benzfungus.forum.domain.User;
import cn.benzfungus.forum.service.UserService;
import com.alibaba.druid.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

import static cn.benzfungus.forum.cons.CommonConstant.LOGIN_TO_URL;
import static cn.benzfungus.forum.cons.CommonConstant.USER_CONTEXT;

@Controller
@RequestMapping("/login")
public class LoginController extends BaseController{
    @Autowired
    private UserService userService;

    /**
     * 用户登录
     * @param request
     * @param user
     * @return
     */
    @RequestMapping("/doLogin")
    public ModelAndView login(HttpServletRequest request, User user){
        User dbUser = userService.getUserByUsername(user.getUsername());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("forward:/login.jsp");
        if(dbUser == null){
            mav.addObject("errorMsg", "用户名不存在");
        }else if(!dbUser.getPassword().equals(user.getPassword())){
            mav.addObject("errorMsg", "用户密码不正确");
        }else if (dbUser.getLocked() == User.USER_LOCK){
            mav.addObject("errorMsg", "用户已经被锁定, 无法登录!");
        }else {
            dbUser.setLastIp(request.getRemoteAddr());
            dbUser.setLastVisit(new Date());
            userService.loginSuccess(dbUser);
            setSessionUser(request, dbUser);
            String toUrl = (String) request.getSession().getAttribute(LOGIN_TO_URL);
            // 如果当前会话中没有保存登录之前的请求URL, 则跳转到主页
            if(StringUtils.isEmpty(toUrl)){
                toUrl = "/index.html";
            }
            mav.setViewName("redirect:"+toUrl);
        }
        return mav;
    }

    @RequestMapping("/doLogout")
    public String logout(HttpSession session){
        session.removeAttribute(USER_CONTEXT);
        session.removeAttribute(LOGIN_TO_URL);
        return "forward:/index.jsp";
    }


}
