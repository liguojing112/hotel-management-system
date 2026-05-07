<template>
  <div class="app-container">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'VueTemplateApp',

  data() {
    return {
      
    };
  },

  mounted() {
    //设置网页Title
    document.getElementsByTagName("title")[0].innerText = this.$sysTitle
  },

  methods: {
    
  },
};
</script>

<style lang="less" scoped>
.app-container{
  // background-color: #f2f4fb;
}
</style>