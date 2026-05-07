# 酒店管理系统

Spring Boot 2.0.1 + Vue 2.x + Element UI + MySQL 的酒店后台管理系统。

## 技术栈

| 层级 | 技术 |
|------|------|
| 后端框架 | Spring Boot 2.0.1 |
| ORM | MyBatis-Plus 2.3.3 |
| 连接池 | HikariCP |
| 认证 | JWT (java-jwt 3.18.2) |
| 前端框架 | Vue 2.x |
| UI 组件 | Element UI |
| 数据库 | MySQL 5.7+ |

## 快速启动

### 后端

```bash
cd hotely5d
# 需先在 MySQL 中执行 hotely5d.sql 初始化数据库
mvn spring-boot:run
```

后端运行在 `8600` 端口，数据库配置见 `application.yml`。

### 前端

```bash
cd hotely5d-web
npm install
npm run dev
```

前端运行在 `8080` 端口，浏览器访问 `http://localhost:8080`。

### 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | 1 |
| 管理员 | wz | 1 |
| 用户 | fxr | 1 |

## 项目结构

```
hotely5d/          # 后端
  src/main/java/com/hotely5d/
    controller/    # REST 接口
    service/       # 业务逻辑
    dao/           # 数据访问
    entity/        # 实体类
    config/        # 配置类
    interceptor/   # JWT 拦截器
    utils/         # 工具类

hotely5d-web/      # 前端
  src/
    views/         # 页面组件
    api/           # API 封装
    router/        # 路由配置
    store/         # Vuex 状态
    utils/         # 工具函数
```

## 功能模块

- 管理员/经营者/用户三种角色登录
- 房型管理、房间管理
- 预约管理、入住管理
- 用户管理、留言管理
- 公告管理、个人信息
