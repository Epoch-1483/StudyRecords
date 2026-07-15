编码的方法：
![[Pasted image 20251027192930.png]]
```
String str = "ai你哟"
byte[] bytes1 = str.getBytes();
Syetem.out.println(Arrays.toString(bytes1))

byte[] bytes2 = str.getBytes("GBK");
Syetem.out.println(Arrays.toString(bytes2))
```

解码的方法：

![[Pasted image 20251027193000.png]]
```
String str2 = new String(bytes1);
sout(str2);

String str3 = new String(bytes1,"GBK");
sout(str3);// 编码和解码不一样出现了乱码现象

```