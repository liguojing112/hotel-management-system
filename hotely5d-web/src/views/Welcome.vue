<template>
    <div class="welcome-container">
        <h1 class="welcome-title">Hi~ 欢迎使用{{ $sysTitle }}后台</h1>
        <img src="@/assets/jiudian.jpeg" class="welcome-img" />
    </div>
</template>

<script>
export default {
    name: 'Welcome',
};
</script>

<style lang="less" scoped>
.welcome-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: calc(100vh - 56px);
    padding: 20px;
    box-sizing: border-box;
}

.welcome-title {
    font-size: 24px;
    color: #1a237e;
    margin-bottom: 20px;
    font-weight: 600;
}

.welcome-img {
    max-width: 60%;
    max-height: calc(100vh - 56px - 80px);
    object-fit: contain;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}
</style>
