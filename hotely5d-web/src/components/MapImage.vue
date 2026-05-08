<template>
  <el-image
    :src="src"
    :style="imgStyle"
    :fit="fit"
    class="map-image"
    @click="handleClick"
  >
    <div slot="error" class="image-slot">
      <i class="el-icon-picture-outline"></i>
    </div>
  </el-image>
</template>

<script>
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
        // 百度 marker API，指定 wgs84 坐标系避免偏移
        return `https://api.map.baidu.com/marker?location=${this.lat},${this.lng}&title=${n}&content=${n}&output=html&coord_type=wgs84`;
      }
      // 高德官方标记链接，position 格式为 lng,lat
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
        // 页面未隐藏说明 App 未唤起，回退 Web 链接
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
    handleClick() {
      this.$emit('click', { lat: this.lat, lng: this.lng, name: this.name });
      // 无有效坐标时不跳转
      if (!this.lat || !this.lng) {
        return;
      }
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
  cursor: pointer;
  transition: opacity 0.2s;
}
.map-image:hover {
  opacity: 0.85;
}
</style>
