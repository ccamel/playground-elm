// A 320 × 200 framebuffer. Elm owns geometry, instruments and animation;
// this element rasterizes contours and the cockpit without antialiasing.
const hudGlyphs = {
  0: [7, 5, 5, 5, 7],
  1: [2, 6, 2, 2, 7],
  2: [7, 1, 7, 4, 7],
  3: [7, 1, 7, 1, 7],
  4: [5, 5, 7, 1, 1],
  5: [7, 4, 7, 1, 7],
  6: [7, 4, 7, 5, 7],
  7: [7, 1, 1, 1, 1],
  8: [7, 5, 7, 5, 7],
  9: [7, 5, 7, 1, 7],
  A: [2, 5, 7, 5, 5],
  C: [7, 4, 4, 4, 7],
  L: [4, 4, 4, 4, 7],
  P: [7, 5, 7, 4, 4],
  T: [7, 2, 2, 2, 2]
};

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

  set scene({ curves, heading, altitude }) {
    const pixels = this.frame.data;
    for (let i = 0; i < pixels.length; i += 4) {
      pixels[i] = pixels[i + 1] = pixels[i + 2] = 0;
      pixels[i + 3] = 255;
    }
    // Near to far: each column remembers the highest foreground pixel.
    const horizon = new Int16Array(320).fill(200);
    for (const { points: curve, color } of curves) {
      const nextHorizon = horizon.slice();
      const plot = (x, y) => {
        if (x < 0 || x >= 320 || y < 0 || y >= horizon[x]) return;
        const i = (y * 320 + x) * 4;
        pixels[i] = color[0];
        pixels[i + 1] = color[1];
        pixels[i + 2] = color[2];
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
    this.drawHud(heading, altitude);
    this.context.putImageData(this.frame, 0, 0);
  }

  drawHud(heading, altitude) {
    const pixels = this.frame.data;
    const blue = [66, 76, 156];
    const cyan = [96, 176, 208];
    const red = [240, 48, 24];
    const black = [0, 0, 0];
    const rect = (x, y, width, height, color) => {
      for (let row = y; row < y + height; row++) {
        for (let column = x; column < x + width; column++) {
          const i = (row * 320 + column) * 4;
          pixels[i] = color[0];
          pixels[i + 1] = color[1];
          pixels[i + 2] = color[2];
        }
      }
    };
    const text = (value, x, y) => {
      for (const character of value) {
        const rows = hudGlyphs[character];
        for (let row = 0; row < 5; row++) {
          for (let column = 0; column < 3; column++) {
            if (rows[row] & (4 >> column)) rect(x + column, y + row, 1, 1, cyan);
          }
        }
        x += 4;
      }
    };
    // Solid bezels and chamfered corners, overlaid after terrain occlusion.
    rect(0, 0, 320, 8, black);
    rect(0, 193, 320, 7, black);
    rect(0, 8, 4, 185, black);
    rect(316, 8, 4, 185, black);
    rect(12, 8, 296, 1, blue);
    rect(12, 192, 296, 1, blue);
    for (const x of [4, 315]) rect(x, 16, 1, 169, blue);
    for (let step = 0; step < 8; step++) {
      rect(5 + step, 15 - step, 1, 1, blue);
      rect(314 - step, 15 - step, 1, 1, blue);
      rect(5 + step, 185 + step, 1, 1, blue);
      rect(314 - step, 185 + step, 1, 1, blue);
    }
    rect(118, 2, 84, 19, black);
    rect(118, 20, 84, 1, blue);
    for (const x of [118, 159, 201]) rect(x, 2, 1, 18, blue);
    text('CAP', 133, 5);
    text('ALT', 174, 5);
    text(String(Math.round(heading)).padStart(3, '0'), 133, 13);
    text(String(Math.round(altitude)).padStart(3, '0'), 174, 13);
    // Open reticle leaves the landscape visible through its centre.
    for (const x of [155, 165]) rect(x, 98, 1, 5, red);
    for (const y of [96, 104]) rect(158, y, 5, 1, red);
    rect(160, 100, 1, 1, red);
    for (const x of [10, 303]) {
      rect(x, 100, 7, 1, red);
      for (const y of [84, 92, 108, 116]) rect(x + 2, y, 3, 1, blue);
    }
  }
}

customElements.define('terrain-raster', TerrainRaster);
