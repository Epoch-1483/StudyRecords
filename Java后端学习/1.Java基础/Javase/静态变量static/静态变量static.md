
> 📇 完整学习笔记：[[JavaSE基础完整笔记]] · 枢纽 [[Javase]]
[[Javase]]
## 一、静态方法（Static Method）

### ✅ 是什么？

- **静态方法属于类本身**，而不是某个对象。
- 你**不需要创建对象**，就能直接通过类名调用它。
- 最常见的例子：`public static void main(String[] args)` —— 这就是静态方法！
- 普通方法（非 static）：需要对象才能调用
  

###  静态方法的限制：

1. **不能直接访问非静态变量或方法**（因为它们属于对象，而静态方法不依赖对象）。
2. **不能使用 `this` 或 `super`**（因为没有当前对象）。

```
// 类里面
public class Calculator { 
	// 静态方法：加法 
	public static int add(int a, int b) {
		 return a + b; 
	 }
	  // 静态方法：乘法 
	public static int multiply(int a, int b) {
		 return a * b; 
	 } // 普通方法（非 static）：需要对象才能调用 
	public void sayHello() { 
		System.out.println("Hello from an instance!"); 
	} 
}
```
```
public class Main {
	 public static void main(String[] args) { 
	 
	 // 直接用类名调用静态方法，不用 new 对象！ 
	 int sum = Calculator.add(3, 5); 
	 int product = Calculator.multiply(4, 6); 
	 System.out.println("3 + 5 = " + sum); // 输出：8   
	 System.out.println("4 × 6 = " + product); // 输出：24 
	 
	 // ❌ 下面这行会报错！静态方法里不能直接调用非静态方法 
	 // Calculator.sayHello(); // 编译错误！ 
	 // ✅ 必须先创建对象才能调用普通方法 
	 Calculator calc = new Calculator(); calc.sayHello();
	 } 
}
```

## 二、静态代码块（Static Block）

### ✅ 是什么？

- 一段用 `static { ... }` 包起来的代码。
- 它在**类第一次被加载时执行**，而且**只执行一次**。
- 常用于**初始化静态变量**，尤其是复杂的初始化（比如读配置文件、连接数据库等）。


## 如果你同时有：静态变量、静态代码块、构造方法，它们的执行顺序是？
1. 静态代码块
2. 静态方法初始化变量
3. 构造方法

## 一句话记住

- **静态 = 属于类，不依赖对象**
- **静态方法：工具人，直接用**
- **静态代码块：类的“开机自启程序”，只跑一次**
