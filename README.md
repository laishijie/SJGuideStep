# SJGuideStep
App Guide Step

```
1、半透明view，
2、在指定位置抠空、添加图片
3、可以添加N个步骤
```

App 引异提示

![图片](https://jaylsj.oss-cn-shenzhen.aliyuncs.com/0216BB81-B864-4229-9574-5F7567B36DAC.png?Expires=1566981782&OSSAccessKeyId=TMP.hVe6TDVxusToUmSR16PasoFdLdmHHcRWeRTQJYXr1YTBZ5AN7WUXwQh857rdebtWYvJX9vTY6ZUQK8z4trijuyQfe1NkusUXXWVCPYrqSSk4QFDT7SvNrJoBVXMhm3.tmp&Signature=jauI21bHT9612JGxTZuqadithLg%3D "示例")

使用
```
    SJGuideStep *step = [SJGuideStep new];
    [step addImage:image frame:frame];
    [step addEmptyCornerWithConers:UIRectCornerAllCorners cornerRadius:10 emptyFrame:emptyFrame];
    
    [SJPublicGuideView showGuideSteps:@[step] identifier:@"sj_guide_mine_recommended"];
    
```
