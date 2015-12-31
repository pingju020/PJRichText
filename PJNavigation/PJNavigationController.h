//
//  PJNavigationController.h
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJNavigationController : UINavigationController

@end

// ****** NavigationController 自定义的原理*********************
/*
UINavigationController是IOS编程中比较常用的一种容器view controller，很多系统的控件(如UIImagePickerViewController)以及很多有名的APP中(如qq，系统相册等)都有用到。说是使用详解，其实我只会介绍几个自认为比较重要或者容易放错的地方进行讲解，下面让我们挨个探探究竟：
 
    UINavigationController view层级见苹果官网。

1、navigationItem

　　我们都知道navigationItem是UIViewController的一个属性，这个属性是为UINavigationController服务的。文档中是这么解释的“The navigation item used to represent the view controller in a parent’s navigation bar. (read-only)”，即navigation item在navigation Bar代表一个viewController，具体一点儿来说就是每一个加到navigationController的viewController都会有一个对应的navigationItem，该对象由viewController以懒加载的方式创建，稍后我们可以在对象中堆navigationItem进行配置，可以设置leftBarButtonItem, rightBarButtonItem, backBarButtonItem, title以及prompt等属性。前三个每一个都是一个UIBarButtonItem对象，最后两个属性是一个NSString类型描述，注意添加该描述以后NavigationBar的高度会增加30，总的高度会变成74(不管当前方向是Portrait还是Landscape，此模式下navgationbar都使用高度44加上prompt30的方式进行显示)。当然如果觉得只是设置文字的title不够爽，你还可以通过titleview属性指定一个定制的titleview，这样你就可以随心所欲了，当然注意指定的titleview的frame大小，不要显示出界。

　　举个简单的例子：

复制代码
// set rightItem
UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Root" style:UIBarButtonItemStyleBordered target:self action:@selector(popToRootVC)];
childOne.navigationItem.rightBarButtonItem = rightItem;
[rightItem release];

// when you design a prompt for navigationbar, the hiehgt of navigationbar will becaome 74, ignore the orientation
childOne.navigationItem.prompt = @"Hello, im the prompt";
复制代码
　　这段代码设置了navigationItem的rightBarButtonItem，同时设置了prompt信息。



2、titleTextAttributes（ios5.0以后可用）

　　这是UINavigationBar的一个属性，通过它你可以设置title部分的字体，这个属性定义如下：

   //You may specify the font, text color, text shadow color, and text shadow offset for the title in the text attributes dictionary, using the keys found in UIStringDrawing.h.
 
@property(nonatomic,copy) NSDictionary *titleTextAttributes __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) UI_APPEARANCE_SELECTOR;
　　它的dictionary的key定义以及其对应的value类型如下：

//    Keys for Text Attributes Dictionaries
//    NSString *const UITextAttributeFont;                       value: UIFont
//    NSString *const UITextAttributeTextColor;                 value: UIColor
//    NSString *const UITextAttributeTextShadowColor;       value: UIColor
//    NSString *const UITextAttributeTextShadowOffset;      value: NSValue wrapping a UIOffset struct.
　　下面看一个简单的例子：

NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor yellowColor] forKey:UITextAttributeTextColor];
childOne.navigationController.navigationBar.titleTextAttributes = dict;
　　这个例子就是设置title的字体颜色为黄色，怎么样简单吧。



3、wantsFullScreenLayout

　　viewController的一个属性，这个属性默认值是NO，如果设置为YES的话，如果statusbar，navigationbar, toolbar是半透明的话，viewController的view就会缩放延伸到它们下面，但注意一点儿tabBar不在范围内，即无论该属性是否为YES，view都不会覆盖到tabbar的下方。



4、navigationBar中的stack

　　这个属性可以算是UINavigationController的灵魂之一，它维护了一个和UINavigationController中viewControllers对应的navigationItem的stack，该stack用于负责navigationbar的刷新。“注意：如果navigationbar中navigationItem的stack和对应的NavigationController中viewController的stack是一一对应的关系，如果两个stack不同步就会抛出异常。

　　下面举个简单抛出异常的例子：

SvNavChildViewController *childOne = [[SvNavChildViewController alloc] initWithTitle:@"First" content:@"1"];
[self.navigationController pushViewController:childOne animated:NO];
[childOne release];

// raise exception when the stack of navigationbar and navigationController was not correspond
[self.navigationController.navigationBar popNavigationItemAnimated:NO];
　　当pushViewcontroller的之后，强制把navigationBar中的navigationItem pop一个出去，程序立马挂起。当然这纯粹只是为了验证问题，我想一般的码农没有人会这么写的。



5、navigationBar的刷新

　　通过前面介绍的内容，我们知道navigationBar中包含了这几个重要组成部分：leftBarButtonItem, rightBarButtonItem, backBarButtonItem, title。当一个view controller添加到navigationController以后，navigationBar的显示遵循一下几个原则：

　　1）、Left side of the navigationBar

　　a）如果当前的viewController设置了leftBarButtonItem，则显示当前VC所自带的leftBarButtonItem。

　　b）如果当前的viewController没有设置leftBarButtonItem，且当前VC不是rootVC的时候，则显示前一层VC的backBarButtonItem。如果前一层的VC没有显示的指定backBarButtonItem的话，系统将会根据前一层VC的title属性自动生成一个back按钮，并显示出来。

　　c）如果当前的viewController没有设置leftBarButtonItem，且当前VC已是rootVC的时候，左边将不显示任何东西。

　　此处注意：5.0中新增加了一个属性leftItemsSupplementBackButton，通过指定该属性为YES，可以让leftBarButtonItem和backBarButtonItem同时显示，其中leftBarButtonItem显示在backBarButtonItem的右边。

　　2)、title部分

　　a）如果当前VC通过 .navigationItem.titleView指定了自定义的titleView，系统将会显示指定的titleView，此处要注意自定义titleView的高度不要超过navigationBar的高度，否则会显示出界。

　　b）如果当前VC没有指定titleView，系统则会根据当前VC的title或者当前VC的navigationItem.title的内容创建一个UILabel并显示，其中如果指定了navigationItem.title的话，则优先显示navigationItem.title的内容。

　　3)、Right side of the navigationBar

　　a）如果当前VC指定了rightBarButtonItem的话，则显示指定的内容。

　　b）如果当前VC没有指定rightBarButtonItem的话，则不显示任何东西。



6、Toolbar

　　navigationController自带了一个工具栏，通过设置 self.navigationController.toolbarHidden = NO来显示工具栏，工具栏中的内容可以通过viewController的toolbarItems来设置，显示的顺序和设置的NSArray中存放的顺序一致，其中每一个数据都一个UIBarButtonItem对象，可以使用系统提供的很多常用风格的对象，也可以根据需求进行自定义。

　　设置Toolbar内容的例子：

复制代码
// test ToolBar
UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:nil action:nil];
UIBarButtonItem *three = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
UIBarButtonItem *four = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
[childOne setToolbarItems:[NSArray arrayWithObjects:flexItem, one, flexItem, two, flexItem, three, flexItem, four, flexItem, nil]];
[one release];
[two release];
[three release];
[four release];
[flexItem release];

childOne.navigationController.toolbarHidden = NO;
复制代码


7、UINavigationControllerDelegate

　　这个代理真的很简单，就是当一个viewController要显示的时候通知一下外面，给你一个机会进行设置，包含如下两个函数：

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
　　当你需要对某些将要显示的viewController进行修改的话，可实现该代理。



8、UINavigationController的viewControllers属性

　　通过该属性我们可以实现一次性替换整个navigationController的层次, 这个过程如果通过setViewControllers:animated:来设置，并指定动画为YES的画，动画将会从当前的navigationController所显示的vc跳转到所设置的目标viewController的最顶层的那个VC，而中间其他的VC将会被直接从VC层级中移除和添加进来（没有动画）。



9、topViewController Vs visibleViewController

　　topViewController代表当前navigation栈中最上层的VC，而visibleViewController代表当前可见的VC，它可能是topViewController，也可能是当前topViewController present出来的VC。因此UINavigationController的这两个属性通常情况下是一样，但也有可能不同。

　　------------------（完）
 */
