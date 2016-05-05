## QYLocalization

最近接触到iOS应用本地化的相关使用，于是花了点时间研究了一下，下面把成果分享给大家。

###一、简介
* 使用本地化功能，可以轻松地将应用程序翻译成多种语言，甚至可以翻译成同一语言的多种方言
* 如果要添加本地化功能，需要为每种支持的语言创建一个子目录，称为”本地化文件夹”，通常使用.lproj作为拓展名
* 当本地化的应用程序需要载入某一资源时，如图像、属性列表、nib文件，应用程序会检查用户的语言和地区，并查找相匹配的本地化文件夹。如果找到了相应的文件夹，就会载入这个文件夹中的资源
* 当前项目环境为Xcode7.3、iOS9.3，涉及的代码可以去我们github上下载：<span style="color: #0000ff;">[https://github.com/peanutNote/QYLocalization.git](https://github.com/peanutNote/QYLocalization.git) 
* 为了节约时间本文大致基于[李明杰老师的博客](http://blog.csdn.net/q199109106q/article/details/8564615)进行写作

###二、创建项目

工程目录结构

![image](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418201256929-174214643.png)

运行效果图(因为没有使用本地化功能，所以不管用户选择什么语言环境，运行的效果都是一样的)

![image](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418202058820-1508814125.png)
![image](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418202134054-914477904.png)
![image](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418202149554-232771392.png)

现在想在中文语言环境下，换另一套实现，其中包括：
  
* 更改storyboard文件中的文字（nib本地化,storyboard也是nib的一种
* 更改登录按钮下面的图片（图片本地化）   
* 更改对话框中的文字(Tip和Ok)（字符串本地化）   
* 更改应用名称（应用名称本地化，即本地化Info.plist文件） 

###三、本地化前的准备

其实就是先创建好中文的本地化文件夹（zh-Hans.lproj），让应用程序支持中文语言环境

![image](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418202225804-1224327948.png) 

其中Base.lproj就是指的勾选的本地化，也就是说我们项目创建默认使用的是Base的本地化。这也是为什么每次创建项目Main.storyboard会在一个Base.lproj的文件夹中的原因。同时鼠标指的是系统默认创建的一个英文本地化配置(里面有两个文件正好跟Base.lproj中的对应，目前可以理解Base也是英文的一种本地化)。这里为了不影响说明我们去掉这个勾选，只用中文和英文本地化来进行说明。当我去掉勾时会删除Main.storyboard和LaunchScreen.stroyboard，因此我们需要先在英文换件中添加这两个文件然后再去掉Base，具体办法就是选中Main.storyboard,勾选下图的English这两个文件就会拷贝一份到en.lproj中。

![image](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418201538476-1545911645.png)

我们来看此时的项目文件结构

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160419112705866-1631692328.png)

进入正题：因为英文Localization系统已经帮我们创建好了，我们在这里只需要创建中文Localization即可

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418202335132-261429544.png)

选择Finish后我们的项目文件结果为：

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418202823288-1344437197.png)

zh-Hans.lproj文件夹已经为我们创建好了，与en.lproj文件夹一样包含一个Main.storyboard表示在中文环境会启用这里面的资源。这里有的同学可能在zh-Hans中生成的不是Main.storyboard而是Main.strings,这是因为你没有去掉Base这个本地化(也就是上文中的勾)，不过这时候也可以自己选择

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418203407101-752360795.png)

至于这里的Main.strings文件也是关于storyboard本地化的一种方法。需要我们先在nib中添加好控件弄好布局以后在执行本地化，然后Main.strings中就会生成类似字符串本地化(后面会介绍，因为这种方法只能修改控件的title，所以我这里没有使用这个来说明)一样的文件,修改对应的地方就可以修改storyboard中的控件title了

```objc
/* Class = "UILabel"; text = "Password"; ObjectID = "6Jw-lK-yZp"; */
"6Jw-lK-yZp.text" = "Password";

/* Class = "UIButton"; normalTitle = "Login"; ObjectID = "M8g-w0-oLf"; */
"M8g-w0-oLf.normalTitle" = "Login";

/* Class = "UILabel"; text = "UserName"; ObjectID = "io8-3O-gpY"; */
"io8-3O-gpY.text" = "UserName";
```

同时Xcode中的Main.storyboard左边会出现一个三角，展开可以发现分别都有2个版本的文件。到此我们的项目就支持英文和中文环境了，本地化准备完毕

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418203259366-1538073848.png)

###四、nib文件的本地化 
打开Main.storyboard(Simplified)文件，修改里面的文字信息(这里不修改图片) 
![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418203904398-1855906145.png) 

###五、应用程序名称本地化(Info.plist本地化)
知识背景：Info.plist中有个叫CFBundleDisplayName的key决定了应用程序的名称  

1.为Info.plist添加一个key-value，让应用程序支持名称本地化，Info.plist就会去InfoPlist.strings加载CFBundleDisplayName对应的字符串,（这里需要注意不能直接本地化Info.plist，因为这样做之后Info.plist文件会存在各自的本地化文件夹中(像en.lproj)中，这样系统会报Info.plist文件不存在的问题，虽然可以去指定Info.plist文件的位置，但是这样就不能实现本地化的目的了，所以需要用到InfoPlist.strings文件）。 
![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418211850835-2136615719.png) 

用这种方法分别为英文和中文本地化添加InfoPlist.strings文件并且在Info.plst中添加Application has localized display name字段，赋值为YES 

![](http://img.my.csdn.net/uploads/201302/02/1359770541_8270.png) 

在对应的InfoPlist.strings文件中添加各自的应用名 InfoPlist.strings(English):

`CFBundleDisplayName="Localization";`


在InfoPlist.strings(Simplifid):

`CFBundleDisplayName="本地化";`

###六、图片本地化 
1.直接拖拽到项目的图片本地化(这里演示本地化home.png，nib文件中登录按钮下面的房子图片) 用上面添加InfoPlist.strings的方法添加该图片的本地化，分别为英文和中文环境添加home.png文件 

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418212858913-1447783158.png)

查看下项目文件中home.png的情况 

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418213135726-220025052.png) 

在代码中使用`[UIImage imageNamed:@"home.png"];`  即可   

<span style="color: #ff0000; background-color: #ffffff;">注意：本地化完图片文件，记得Clean一下项目，而且最好先删除应用程序，再重新安装</span> 

2.使用Assets.xcassets或者Images.xcassets管理图片本地化  因为iOS暂不支持.xcassets的本地化，所以这里需要结合字符串的本地化来处理(这里也放在后面介绍) 

###七、字符串的本地化 
1.创建一个字符串资源文件 文件名最好是Localizable.strings，如果使用其他文件名，使用字符串时的调用会有些区别 
2.依旧按照上面的方法为Localizable.strings添加多语言支持 
3.在Localizable.strings(English)文件加入：

```objc
Tip="Tip";
 
Ok="Ok";
 
"Please input your userName"="Please input your userName";
```

4.在Localizable.strings(Chinese)文件加入：

```objc
Tip="提示";
 
Ok="好的";
 
"Please input your userName"="请输入用户名";
``` 

5.在代码中使用NSLocalizedString(key, comment)来读取本地化字符串，key是Localizable.strings文件中等号左边的字符串，comment纯粹是注释。同时上文中提到的.xcassets本地化也需要用到这个。首先添加各自的图片并命名如：image1，image2，本地化一个字符串imageName用作图片的名字，然后在各自的Localizable.strings中对应到各自的实际图片名称即可。  
 
6.在Localizable.strings(English)文件加入：

```objc
"imageName" = "image1";
```

7.在Localizable.strings(Chinese)文件加入：

```objc
"imageName" = "image2";
```

<span style="color: #ff0000; background-color: #ffffff;">如果没有对字符串进行本地化 或者 找不到key对应的值，NSLocalizedString将直接返回key这个字符串</span>  

注意：如果你的字符串资源文件名不是Localizable.strings，如qy.strings，那么你就得使用NSLocalizedStringFromTable()来读取本地化字符串：

```objc
NSLocalizedStringFromTable(@"Tip", @"qy", nil);
```

补充：生成字符串资源文件的另一种方式(通过终端命令genstrings，可以自行补充)

1.首先添加获取字符串的代码，比如在ViewController.m。(其实这里就是方便我们不用针对每一个需要本地化字符串的地方都去上面Localizable.strings文件中一一添加，我们只需要使用NSLocalizedString取字符串然后用genstrings命令就可以帮我们完善Localizable.strings文件啦)

```objc
NSString *tip = NSLocalizedString(@"Tip", @"dialog title"); 
NSString *ok = NSLocalizedString(@"Ok", @"dialog button"); 
```

2.打开终端，cd到项目文件夹下(包含en.lproj和zh-Hans.lproj，否则会报错couldn't connect to output directory xx.lproj)

```objc
find ./ -name "*.m" -print0 | xargs -0 genstrings -o en.lproj // 注意*.m旁边的引号，这个不可缺少，网上有很多这种命令是没有加引号的，这样执行会报错xx.m: unknown primary or operator
```

如果使用NSLocalizedStringFromTable(key, tbl, comment)来获取字符串，资源文件会以tbl参数作为文件名，比如

```objc
NSString *tip = NSLocalizedStringFromTable(@"Tip", @"qy", @"dialog title");  
NSString *ok = NSLocalizedStringFromTable(@"Ok", @"qy", @"dialog button"); 
```

生成的资源文件为：qy.strings</div>


4.将资源文件导入项目即可，然后打开资源文件，可以发现已经生成了key和comment 

###八、其他文件的本地化 
跟六中图片本地化的原理是一样的，重复六中的每个步骤即可 
###九、最终效果演示 
1.英文环境下  

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418221518179-1497265294.png)
![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418221812491-828679484.png)
![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418221819913-1076150726.png)
  
2.中文环境下   

![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418221633663-1786821289.png)
![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418221702366-1999391314.png)
![](http://images2015.cnblogs.com/blog/685098/201604/685098-20160418221709866-1016484201.png)  
最后给大家推荐一篇不错的本地化[博客](https://www.raywenderlich.com/64401/internationalization-tutorial-for-ios-2014)，提供给大家参考。