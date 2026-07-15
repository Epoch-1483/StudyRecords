[[协议]]
![[Pasted image 20251102144844.png]]

## ==发送数据：==

![[Pasted image 20251102145253.png]]

## ==接收数据：==

![[Pasted image 20251102145352.png]]
![[Pasted image 20251102150601.png]]
‘
先运行接收端再运行发送端
```
ds.receive
// 改方法是阻塞的，程序执行到这一步的时候，会在这里死等，等发送端发送信息
```

//接收数据不知道什么时候停止发送，故采用死循环接收

## ==UDP的三种通信方式：==

![[Pasted image 20251102153421.png]]

组播：
创建MulticastScoket对象
```
MulticastScoket ms = new MulticastScoket();
```
指定组播地址


广播：
只需要把单播的地址改为255.255.255.255