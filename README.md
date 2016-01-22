# SliderMenu
1、写的简单的上下对应菜单，可以在rootView里面添加自己想要的View，初步是使用Delegate方法来刷新，随后优化时考虑使用通知来处理。

2、舍弃单例模式，如果使用单例模式多次进入会出现界面堆砌的情况，故舍弃单例模式，使用init创建view
3、rootView和TopView之间通信采用了通知的形式，舍弃通过单例使用Set方法来改变属性
4、在viewcontroller中释放资源
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView *view in self.view.subviews)
    {
        [view removeFromSuperview];
    }
    [self.view removeFromSuperview];

}
