<template>
  <el-image
    :src="src"
    :style="imgStyle"
    :fit="fit"
    :class="imageClasses"
    @click="handleClick($event)"
  >
    <div slot="error" class="image-slot">
      <i class="el-icon-picture-outline"></i>
    </div>
  </el-image>
</template>

<script>
import { getToken } from '@/utils/auth';

export default {
  name: 'MapImage',
  props: {
    src: { type: String, required: true },
    lat: { type: Number, default: 0 },
    lng: { type: Number, default: 0 },
    name: { type: String, default: '' },
    mapType: { type: String, default: 'amap' },
    zoom: { type: Number, default: 17 },
    openMode: { type: String, default: 'blank' },
    fit: { type: String, default: 'cover' },
    imgStyle: { type: String, default: '' },
    className: { type: String, default: '' },
  },
  computed: {
    isLoggedIn() {
      return !!getToken();
    },
    imageClasses() {
      const classes = ['map-image'];
      if (this.isLoggedIn && this.lat && this.lng) {
        classes.push('clickable');
      }
      if (this.className) {
        classes.push(this.className);
      }
      return classes;
    },
  },
  methods: {
    isWeChat() {
      return /micromessenger/i.test(navigator.userAgent);
    },
    isMobile() {
      return /android|iphone|ipad|ipod|windows phone/i.test(navigator.userAgent);
    },
    getWebUrl() {
      const n = encodeURIComponent(this.name);
      if (this.mapType === 'baidu') {
        return `https://api.map.baidu.com/marker?location=${this.lat},${this.lng}&title=${n}&content=${n}&output=html&coord_type=wgs84`;
      }
      return `https://uri.amap.com/marker?position=${this.lng},${this.lat}&name=${n}&callnative=0`;
    },
    getAppScheme() {
      const n = encodeURIComponent(this.name);
      if (this.mapType === 'baidu') {
        return `baidumap://map/marker?location=${this.lat},${this.lng}&title=${n}&content=${n}&coord_type=wgs84`;
      }
      const isIOS = /iphone|ipad|ipod/i.test(navigator.userAgent);
      const prefix = isIOS ? 'iosamap' : 'androidamap';
      return `${prefix}://viewMap?sourceApplication=hotel&poiname=${n}&lat=${this.lat}&lon=${this.lng}`;
    },
    openWeb() {
      const url = this.getWebUrl();
      if (this.openMode === 'self') {
        window.location.href = url;
      } else {
        window.open(url, '_blank');
      }
    },
    tryOpenApp() {
      const start = Date.now();
      const scheme = this.getAppScheme();
      const iframe = document.createElement('iframe');
      iframe.style.display = 'none';
      iframe.src = scheme;
      document.body.appendChild(iframe);
      const timer = setTimeout(() => {
        document.body.removeChild(iframe);
        if (Date.now() - start > 1800) {
          this.openWeb();
        }
      }, 2500);
      document.addEventListener('visibilitychange', () => {
        if (document.hidden) {
          clearTimeout(timer);
          document.body.removeChild(iframe);
        }
      }, { once: true });
    },
    handleClick(event) {
      this.$emit('click', { lat: this.lat, lng: this.lng, name: this.name });
      // 未登录或无有效坐标 → 不跳转，事件冒泡给父元素
      if (!this.isLoggedIn || !this.lat || !this.lng) {
        return;
      }
      // 已登录 → 阻止冒泡，打开地图
      event.stopPropagation();
      if (this.isWeChat()) {
        this.openWeb();
        return;
      }
      if (this.isMobile()) {
        this.tryOpenApp();
        return;
      }
      this.openWeb();
    },
  },
};
</script>

<style scoped>
.map-image {
  transition: opacity 0.2s;
}
.map-image.clickable {
  cursor: pointer;
}
.map-image.clickable:hover {
  opacity: 0.85;
}
</style>
