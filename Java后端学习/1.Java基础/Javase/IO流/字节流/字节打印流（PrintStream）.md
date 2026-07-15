[[打印流]]
![[Pasted image 20251029154717.png]]
字节打印流（PrintStream）构造方法：
![[Pasted image 20251029155613.png]]
成员方法：
![[Pasted image 20251029155659.png]]

特殊的打印流：
系统中的标准输出流，是不能关闭，在系统中是唯一的
```
PrintStream ps = System.out;

// 写出数据，自动换行，自动刷新，
ps.println("123");

// ps.close();
```