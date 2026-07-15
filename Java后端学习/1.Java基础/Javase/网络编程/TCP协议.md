[[协议]]
![[Pasted image 20251102154007.png]]

![[Pasted image 20251102154128.png]]

```
// TCP协议，发送数据  
Socket socket = new Socket("127.0.0.1",10000);  
  
//可以从🔗通道中获取输出流  
OutputStream os = socket.getOutputStream();  
// 写出数据  
// 不能传递中文  
os.write("你好你好".getBytes());  
  
os.close();  
socket.close();
```
```
```
```
// 创建对象  
ServerSocket ss = new ServerSocket(1000);  
  
// 监听客户端的链接  
Socket socket = ss.accept();  
  
// 从链接通道中读取数据  
InputStream is = socket.getInputStream();  
int b;  
while ((b = is.read()) != -1){  
    System.out.println((char) b);  
}  
  
socket.close();  
ss.close();
```

创建对象就是建立一个连接通道
用连接对象去获取IO的输出的输入
## 三次握手：
作用：确保连接建立
![[Pasted image 20251102161047.png]]
## 四次挥手：
作用：确保连接断开，且数据处理完毕
![[Pasted image 20251102161208.png]]

```
//通知服务端“我发完了”
socket.shutdownOutput();

/*  
* read 方法会从链接通道中读取数据  
* 但是，需要有一个结束标记，此处的循环才会停止  
* 否则，程序就会一直听在read方法这里，等待读取下面的数据  
* */
```
UUID:
解决文件名重复问题
```
// 返回的类型是字符串
UUID.randomUUID().toString.replace("-","")
```

利用多线程让一个客户对应一个线程

![[Pasted image 20251102170540.png]]
线程池优化：
![[Pasted image 20251102170747.png]]

