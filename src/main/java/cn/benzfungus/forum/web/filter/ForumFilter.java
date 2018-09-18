package cn.benzfungus.forum.web.filter;

import cn.benzfungus.forum.domain.User;
import org.apache.commons.lang.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

import static cn.benzfungus.forum.cons.CommonConstant.LOGIN_TO_URL;
import static cn.benzfungus.forum.cons.CommonConstant.USER_CONTEXT;

public class ForumFilter implements Filter {
    private static final String FILTERED_REQUEST = "@@session_context_filtered_request";

    // 不需要登录即可访问的URI
    private static final String[] INHERENT_ESCAPE_URIS =
            {"/index.jsp", "/index.html", "/login.jsp",
            "/login/doLogin.html", "/register.jsp", "/register.html", "/board/listBoardTopics-",
            "/board/listTopicPosts-"};

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    /**
     * 过滤, 需要用户登录
     * @param request
     * @param response
     * @param filterChain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        // 保证过滤器一次请求中只调用一次
        if (request != null && request.getAttribute(FILTERED_REQUEST) != null){
            filterChain.doFilter(request, response);
        }else {
            // 设置过滤标识, 防止一次请求多次过滤
            request.setAttribute(FILTERED_REQUEST, Boolean.TRUE);
            HttpServletRequest httpServletRequest = (HttpServletRequest) request;
            User userContext = getSessionUser(httpServletRequest);
            // 用户未登录, 且当前URI资源需要登录才能访问
            if (userContext == null && !isURILogin (httpServletRequest.getRequestURI(), httpServletRequest)){
                String toUrl = httpServletRequest.getRequestURL().toString();
                if (!StringUtils.isEmpty(httpServletRequest.getQueryString())){
                    toUrl += "?" + httpServletRequest.getQueryString();
                }
                // 将用户请求的URL保存到Session中, 用于登录成功后跳到目标URL
                httpServletRequest.getSession().setAttribute(LOGIN_TO_URL, toUrl);
                // 转发到登录页面
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            filterChain.doFilter(request, response);
        }
    }

    /**
     * 当前资源是否需要登录才能访问
     * @param requestURI
     * @param request
     * @return
     */
    private boolean isURILogin(String requestURI, HttpServletRequest request) {
        if(request.getContextPath().equalsIgnoreCase(requestURI) || (request.getContextPath() + "/")
                .equalsIgnoreCase(requestURI)){
            return true;
        }
        for(String uri : INHERENT_ESCAPE_URIS) {
            if(requestURI != null && requestURI.indexOf(uri) >= 0) {
                return true;
            }
        }
        return false;
    }

    protected User getSessionUser(HttpServletRequest request) {
        return (User) request.getSession().getAttribute(USER_CONTEXT);
    }

    @Override
    public void destroy() {

    }
}
