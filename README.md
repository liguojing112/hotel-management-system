# 民宿管理系统 (hotely5d)

Spring Boot 2.0.1 + Vue 2.x + Element UI + MySQL 的民宿后台管理系统。

## 技术栈

| 层级    | 技术                    |
| ----- | --------------------- |
| 后端框架  | Spring Boot 2.0.1     |
| ORM   | MyBatis-Plus 2.3.3    |
| 连接池   | HikariCP              |
| 认证    | JWT (java-jwt 3.18.2) |
| 前端框架  | Vue 2.6               |
| UI 组件 | Element UI 2.15       |
| 数据库   | MySQL 8.0             |

## 环境要求

- Java 8+
- Maven 3.6+
- MySQL 8.0+
- Node.js 16+

## 快速启动

### 一键启动脚本

项目根目录提供了两个启动脚本，自动处理端口占用检测、依赖检查等：

| 脚本              | 用途               | 端口       |
| --------------- | ---------------- | -------- |
| `start.bat`     | 启动后端 Spring Boot | **8600** |
| `start-web.bat` | 启动前端 Vue 开发服务器   | **9001** |

直接双击即可运行。

### 手动启动

**1. 数据库初始化**

先执行 SQL 脚本创建数据库和表：

```bash
mysql -u root -p < hotely5d.sql
```

数据库配置见 `hotely5d/src/main/resources/application.yml`，默认连接 `localhost:3306/hotely5d`，账号 `root / root123`。

**2. 后端 (端口 8600)**

```bash
cd hotely5d
mvn spring-boot:run
```

**3. 前端 (端口 9001)**

```bash
cd hotely5d-web
npm install      # 首次运行
npm run dev
```

浏览器访问 [http://localhost:9001](http://localhost:9001**。)

## 测试账号

| 角色  | 用户名        | 密码  |
| --- | ---------- | --- |
| 管理员 | `admin`    | `1` |
| 管理员 | `wz`       | `1` |
| 操作员 | `operator` | `1` |
| 会员  | `fxr`      | `1` |
| 会员  | `zxf`      | `1` |
| 会员  | `qy`       | `1` |

## 项目结构

```
hotel-management-system/
├── start.bat                 # 后端一键启动
├── start-web.bat             # 前端一键启动
├── hotely5d.sql              # 数据库初始化脚本
├── hotely5d/                 # 后端
│   └── src/main/java/com/hotely5d/
│       ├── controller/       # REST 接口
│       ├── service/          # 业务逻辑
│       ├── dao/              # MyBatis Mapper
│       ├── entity/           # 实体类
│       ├── config/           # 配置类
│       ├── interceptor/      # JWT 拦截器
│       └── utils/            # 工具类
└── hotely5d-web/             # 前端
    └── src/
        ├── views/            # 页面组件
        ├── api/              # API 封装
        ├── router/           # 路由配置
        └── store/            # Vuex 状态
```

## 功能模块

- 管理员/经营者/会员三种角色登录
- 房型管理、房间管理
- 预约管理、入住/退房管理
- 会员管理、留言管理
- 公告管理、系统配置

## API 状态码

| 状态码   | 含义          |
| ----- | ----------- |
| 20000 | 成功          |
| 20001 | 失败          |
| 20002 | 用户名或密码错误    |
| 20003 | 权限不足        |
| 20004 | 远程调用失败      |
| 20005 | 重复操作        |
| 20006 | Token 无效或过期 |

## 常见问题

**端口被占用**: 直接运行对应的 `start.bat` / `start-web.bat`，脚本会自动处理。

**Token 过期**: JWT 有效期 3 小时，过期后需重新登录。登录接口 `POST /system/login`。

**后端接口需要认证**: 登录后获取 token，在请求头添加 `Authorization: <token>`。
