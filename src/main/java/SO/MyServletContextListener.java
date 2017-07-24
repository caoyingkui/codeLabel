package SO;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class MyServletContextListener implements ServletContextListener{



    public void contextDestroyed(ServletContextEvent sce) {

        System.out.println("this is last destroyeed");

    }

    // 实现其中的初始化函数，当有事件发生时即触发

    public void contextInitialized(ServletContextEvent sce) {
        try {
            ItemAnnotator annorator = new ItemAnnotator();
            ServletContext sct=sce.getServletContext();
            sct.setAttribute(PageParameter.iniAnnotator , null);
            sct.setAttribute(PageParameter.currentAnnotator , null);
            System.out.println("======listener test is beginning=========");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}