import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: Number(process.env.BLOODMATCH_FRONTEND_PORT || 5180),
    strictPort: true,
    watch: {
      usePolling: true,
      interval: 500
    },
    proxy: {
      '/api': {
        target: process.env.BLOODMATCH_API_TARGET || 'http://127.0.0.1:8010',
        changeOrigin: false
      }
    }
  }
})
