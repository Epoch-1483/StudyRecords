[[字符流]]
操作本地文件的字符输入流
![[Pasted image 20251027194311.png]]
创建FileReader对象


==空参read 方法读取==，解码转换成十进制，要想得到中文必须进行强转

```
int ch;
while((ch = fr.read()) != -1){
	sout((char)ch)
}
// 最后释放资源
fr.close;
```
## 有参read方法读取
注意点：
 read(chars):
		 读取数据，解码，强转三步合并了，并把强转之后的字符放到数组当中
 
```
FileReader fr = new FileReader("myio\\a.txt");  
char[] chars = new char[2];  
int len;  
// read(chars):读取数据，解码，强转三步合并了，并把强转之后的字符放到数组当中
while ((len = fr.read(chars)) != -1){  
    // 注意打印的ln删除掉  
    System.out.print(new String(chars,0,len));  
}  
fr.close();
```

![[Pasted image 20251027194409.png]]
![[Pasted image 20251027194422.png]]
