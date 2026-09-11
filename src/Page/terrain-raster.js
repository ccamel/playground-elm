// A two-colour 320 × 200 framebuffer. Elm owns geometry and animation;
// this element only rasterizes the same projected contours as the SVG view.
class TerrainRaster extends HTMLElement {
  constructor() {
    super();
    const canvas = document.createElement('canvas');
    canvas.width = 320;
    canvas.height = 200;
    canvas.style.cssText = 'display:block;width:100%;height:100%;image-rendering:pixelated';
    this.attachShadow({ mode: 'open' }).append(canvas);
    this.context = canvas.getContext('2d', { alpha: false });
    this.frame = this.context.createImageData(320, 200);
  }

  set curves(curves) {
    const pixels = this.frame.data;
    for (let i = 0; i < pixels.length; i += 4) {
      pixels[i] = pixels[i + 1] = pixels[i + 2] = 0;
      pixels[i + 3] = 255;
    }
    // Near to far: each column remembers the highest foreground pixel.
    const horizon = new Int16Array(320).fill(200);
    for (const curve of curves) {
      const nextHorizon = horizon.slice();
      const plot = (x, y) => {
        if (x < 0 || x >= 320 || y < 0 || y >= horizon[x]) return;
        const i = (y * 320 + x) * 4;
        pixels[i] = 66;
        pixels[i + 1] = 76;
        pixels[i + 2] = 156;
        nextHorizon[x] = Math.min(nextHorizon[x], y);
      };
      for (let i = 1; i < curve.length; i++) {
        let [x0, y0] = curve[i - 1];
        let [x1, y1] = curve[i];
        // Profiles are monotone in x. Clip horizontally before walking pixels.
        if (x1 < 0 || x0 > 319 || (y0 >= 200 && y1 >= 200)) continue;
        const slope = (y1 - y0) / (x1 - x0);
        if (x0 < 0) {
          y0 += -x0 * slope;
          x0 = 0;
        }
        if (x1 > 319) {
          y1 += (319 - x1) * slope;
          x1 = 319;
        }
        x0 = Math.round(x0);
        x1 = Math.round(x1);
        y0 = Math.round(y0);
        y1 = Math.round(y1);
        const dx = Math.abs(x1 - x0);
        const dy = -Math.abs(y1 - y0);
        const sx = x0 < x1 ? 1 : -1;
        const sy = y0 < y1 ? 1 : -1;
        let error = dx + dy;
        // Integer Bresenham: no antialiasing, canvas strokes or filters.
        for (;;) {
          plot(x0, y0);
          if (x0 === x1 && y0 === y1) break;
          const twiceError = 2 * error;
          if (twiceError >= dy) {
            error += dy;
            x0 += sx;
          }
          if (twiceError <= dx) {
            error += dx;
            y0 += sy;
          }
        }
      }
      horizon.set(nextHorizon);
    }
    this.context.putImageData(this.frame, 0, 0);
  }
}

customElements.define('terrain-raster', TerrainRaster);
