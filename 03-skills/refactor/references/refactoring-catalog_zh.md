# Refactoring Catalog

一份基于 Martin Fowler《*Refactoring*（第 2 版）》整理的重构技术目录。每项重构都包含动机、步骤和示例。

> "A refactoring is defined by its mechanics—the precise sequence of steps that you follow to carry out the change." — Martin Fowler

---

## How to Use This Catalog

1. 先用 code smells 参考找到问题类型
2. 再在本目录中找到对应的 refactoring
3. 严格按 mechanics 分步执行
4. 每一步之后都跑测试，确保行为没变

**Golden Rule**：如果某一步花的时间超过 10 分钟，就继续拆成更小的步骤。

---

## Most Common Refactorings

### Extract Method

**When to use**：长方法、重复代码、需要给一段逻辑命名时

**Motivation**：把一段代码提炼成一个方法，并让方法名本身解释其意图。

**Mechanics**：
1. 新建一个方法，用“它做什么”来命名，而不是“它怎么做”
2. 把目标代码片段复制进去
3. 检查片段中使用到的局部变量
4. 把这些变量作为参数传入（或在方法内声明）
5. 正确处理返回值
6. 用方法调用替换原始代码片段
7. 跑测试

**Before**：
```javascript
function printOwing(invoice) {
  let outstanding = 0;

  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");

  // Calculate outstanding
  for (const order of invoice.orders) {
    outstanding += order.amount;
  }

  // Print details
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

**After**：
```javascript
function printOwing(invoice) {
  printBanner();
  const outstanding = calculateOutstanding(invoice);
  printDetails(invoice, outstanding);
}

function printBanner() {
  console.log("***********************");
  console.log("**** Customer Owes ****");
  console.log("***********************");
}

function calculateOutstanding(invoice) {
  return invoice.orders.reduce((sum, order) => sum + order.amount, 0);
}

function printDetails(invoice, outstanding) {
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}
```

---

### Inline Method

**When to use**：方法体和方法名一样直白，或者存在过度委托

**Motivation**：如果一个方法没有提供额外价值，就消除这层无意义的间接性。

**Mechanics**：
1. 确认该方法不是多态入口
2. 找到所有调用点
3. 用方法体替换每个调用点
4. 每替换一个就跑测试
5. 删除该方法定义

**Before**：
```javascript
function getRating(driver) {
  return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver) {
  return driver.numberOfLateDeliveries > 5;
}
```

**After**：
```javascript
function getRating(driver) {
  return driver.numberOfLateDeliveries > 5 ? 2 : 1;
}
```

---

### Extract Variable

**When to use**：表达式过于复杂，读起来不直观

**Motivation**：给复杂表达式中的一部分起一个清晰名字。

**Mechanics**：
1. 确认表达式没有副作用
2. 声明一个不可变变量
3. 让它接住表达式（或其中一部分）的结果
4. 用变量名替换原来的表达式
5. 跑测试

**Before**：
```javascript
return order.quantity * order.itemPrice -
  Math.max(0, order.quantity - 500) * order.itemPrice * 0.05 +
  Math.min(order.quantity * order.itemPrice * 0.1, 100);
```

**After**：
```javascript
const basePrice = order.quantity * order.itemPrice;
const quantityDiscount = Math.max(0, order.quantity - 500) * order.itemPrice * 0.05;
const shipping = Math.min(basePrice * 0.1, 100);
return basePrice - quantityDiscount + shipping;
```

---

### Inline Variable

**When to use**：变量名没有比原表达式提供更多信息

**Motivation**：去掉不必要的中间层。

**Mechanics**：
1. 确认右值表达式没有副作用
2. 如果变量不是不可变的，先改成不可变并测试
3. 找到第一处引用，用表达式替换
4. 测试
5. 对其他引用重复执行
6. 删除变量声明和赋值
7. 再测试

---

### Rename Variable

**When to use**：变量名无法清晰表达意图

**Motivation**：好名字是可读代码的核心。

**Mechanics**：
1. 如果变量使用范围很广，先考虑做封装
2. 找到所有引用
3. 逐个修改引用
4. 跑测试

**Tips**：
- 使用意图明确的命名
- 避免缩写
- 尽量使用领域术语

```javascript
// Bad
const d = 30;
const x = users.filter(u => u.a);

// Good
const daysSinceLastLogin = 30;
const activeUsers = users.filter(user => user.isActive);
```

---

### Change Function Declaration

**When to use**：函数名无法准确解释意图，或参数设计需要调整

**Motivation**：好的函数签名能让代码更接近自解释。

**Mechanics (Simple)**：
1. 删除不需要的参数
2. 修改函数名
3. 添加真正需要的参数
4. 跑测试

**Mechanics (Migration - for complex changes)**：
1. 若要移除某参数，先确保它确实未被使用
2. 创建新的函数签名
3. 让旧函数先委托调用新函数
4. 测试
5. 逐步把调用方切到新函数
6. 每改一处都测试
7. 删除旧函数

**Before**：
```javascript
function circum(radius) {
  return 2 * Math.PI * radius;
}
```

**After**：
```javascript
function circumference(radius) {
  return 2 * Math.PI * radius;
}
```

---

### Encapsulate Variable

**When to use**：多个地方直接访问某份数据

**Motivation**：为数据访问提供清晰、受控的入口。

**Mechanics**：
1. 创建 getter / setter
2. 找到所有引用
3. 把读取替换成 getter
4. 把写入替换成 setter
5. 每改一处都测试
6. 收紧原变量的可见性

**Before**：
```javascript
let defaultOwner = { firstName: "Martin", lastName: "Fowler" };

// Used in many places
spaceship.owner = defaultOwner;
```

**After**：
```javascript
let defaultOwnerData = { firstName: "Martin", lastName: "Fowler" };

function defaultOwner() { return defaultOwnerData; }
function setDefaultOwner(arg) { defaultOwnerData = arg; }

spaceship.owner = defaultOwner();
```
