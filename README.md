# LaunchAD
开屏广告页

涉及知识点总结：
-代码结构
controll 控制视图 与 business的融合  load方法监听程序启动 加载视图与广告数据

viewController 展示视图
business 业务逻辑

-程序运行需 pod install

sever 下发的展示数据 持久化方式为 归档 NSKeyedArchiver

新建window level > alert.level ，防止程序启动alert先于广告页弹出,广告页弹不出来

fileManager 创建file中的dir文件不存在，file将创建不成功


遇到问题描述： 搜狐墨客项目 中广告开屏页与锁屏页 window的展示bug?

广告页 windowLevel  = alert + 1;
锁屏页 windowLevel  = normal;

结果：广告页展示之后，锁屏页不展示

知识点： windowLevel 与 keyWindow的关系
level级别顺序，与makeKeyAndVisble顺序有关系
 如：
 A.windowLevel > B.windowLevel 或 A.windowLevel == B.windowLevel
 [A makeKeyAndVisble];
 [B makeKeyAndVisble];
 Bwindow正常显示，显示与Awindow之上
 
  A.windowLevel < B.windowLevel 
 [A makeKeyAndVisble];
 [B makeKeyAndVisble];
 Bwindow不显示
