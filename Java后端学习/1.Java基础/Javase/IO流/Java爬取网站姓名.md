1.首先定义变量记录网址


2.爬取数据，把网址上的数据拼接成字符串


3.利用正则表达式，把其中的符合要求的数据获取出来


方法1：
作用：从网络中爬取数据，把数据拼接成字符串返回
形参：
网址
返回值：
爬取到的所有数据

```
//创建一个URL对象
URL url = new URL(net);
// 链接上这个网址
URLConnection conn = url.openConnection();
// 读取数据
InputStreamReader isr = new InputStream(conn.getInputStream());

```

```
// 使用httpUtil.get 和  ReUtil.findAll
//请求列表页
String listContent = HttpUtil.get("https://www.oschina.net/action/ajax/get_more_news_list?newsType=&p=2");
//使用正则获取所有标题
List<String> titles = ReUtil.findAll("<span class=\"text-ellipsis\">(.*?)</span>", listContent, 1);
for (String title : titles) {
	//打印标题
	Console.log(title);
}
```
![[Pasted image 20251031195605.png]]

