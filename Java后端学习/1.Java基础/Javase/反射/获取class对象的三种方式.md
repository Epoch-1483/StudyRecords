[[反射]]
![[Pasted image 20251102203013.png]]

```
// 第一种方式 最为常用  
// 包名 + 类名  
Class<?> clazz1 = Class.forName("myreflect1.Student");  
  
// 2.类名.class  
// 一般当做参数传递  
Class<?> clazz2 = Student.class;  
  
// 3.对象.getClass();  
// 当我们有了类的对象才能使用  
Student s = new Student();  
Class<?> clazz3 = s.getClass();
```

