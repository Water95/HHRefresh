# HHRefresh
易于定制下拉刷新控件的模板控件。你需要做的是添加子视图和在setState方法里，维护子视图的状态。

### 1 使用说明
在podfile中写入    <br/>
pod 'HHRefresh', '~> 0.0.6'  <br/>
然后执行pod install  

### 2 下拉刷新的原理
给ScrollView添加了子视图HeaderView,HeaderView的frame是（0,-height,width,height)。<br/>

监听ScrollView的contentOffSet,根据contentOffSet的y值改变状态，根据状态不同修改不同的显示文字。<br/>

如进入刷新状态时，修改文字，修改ScrollView的contentInset的top为50，同时回调。<br/>

结束刷新状态，修改ScrollView的contentInset的top为0。

### 3 如何定制自己的headerView

打开HHRefreHeaderView.m,在这里面添加子视图，在setState方法里修改子视图的状态。

### 4 上拉加载的原理


给ScrollView添加子视图FooterView,监听scrollView的contentSize的变化。footerView的frame的y要动态的改变。判断contentSize的height和本身scrollView的height，如果contentSize的height的数值大，那么footerView的y值是contentSize的高度。具体代码见HHRefreshFooterView.m的adjustFrameWithContentSize。

监听ScrollView的contentOffSet的变化，满足临界条件后，修改状态，根据不同的状态，修改文字，图片的变化。

### 5 如何定制自己的footerView
打开HHRefreshFooterView.m,在这里面添加子视图，在setState方法里修改子视图的状态。

### 6 相关的知识点 

6.1 设置ScrollView的contentInset的top为0时，scrollView会自动滚动显示的范围，头部的调整 -top

6.2 如果改变了contentInset对contentOffSet有何影响

如果top设置了50，那么contentSet的y的默认值就是-50。contentSet跟着内容走的。准确的说，contentSet的y的默认值和conteInset的top有关

6.3 如果改变了contentInset对可见区域有何影响

如top设置了50，这块区域是可见的了，并且滚动放手后能固定在这个位置



如果有问题，可联系 QQ 791512142,欢迎交流


