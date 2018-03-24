# LaunchAD
开屏广告页

涉及知识点总结：
-代码结构
controll 控制视图 与 business的融合  load方法监听程序启动 加载视图与广告数据

viewController 展示视图
business 业务逻辑

-程序运行需 pod install

sever 下发的展示数据 持久化方式为 归档 NSKeyedArchiver

新建window level > alert.level ，防止程序启动alert先于广告页弹出

fileManager 创建file中的dir文件不存在，file将创建不成功
