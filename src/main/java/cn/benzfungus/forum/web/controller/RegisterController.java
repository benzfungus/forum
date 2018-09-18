package cn.benzfungus.forum.web.controller;

import cn.benzfungus.forum.domain.User;
import cn.benzfungus.forum.exception.UserExistException;
import cn.benzfungus.forum.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class RegisterController extends BaseController {
    @Autowired
    private UserService userService;

    @RequestMapping(value="/register", method = RequestMethod.POST)
    public ModelAndView register(HttpServletRequest request, User user){
        ModelAndView view = new ModelAndView();
        view.setViewName("/success");
        try {
            userService.register(user);
        } catch(UserExistException e){
            view.addObject("errorMsg", "用户名已经存在, 请选择其他名字!");
            view.setViewName("forward:/register.jsp");
        }
        setSessionUser(request, user);
        return view;
    }
}
