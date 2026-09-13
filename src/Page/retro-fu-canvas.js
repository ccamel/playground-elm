import 'elm-canvas/elm-canvas.js';

const canvasPrototype = customElements.get('elm-canvas').prototype;
const setCanvasDimensions = canvasPrototype.setCanvasDimensions;

// elm-canvas normally scales its backing buffer by DPR. Retro Fu instead needs
// one framebuffer pixel per game pixel; CSS alone enlarges the finished image.
canvasPrototype.setCanvasDimensions = function () {
  setCanvasDimensions.call(this);
  if (this.mounted && this.classList.contains('retro-fu')) {
    this.canvas.width = Number(this.getAttribute('width'));
    this.canvas.height = Number(this.getAttribute('height'));
    this.context.imageSmoothingEnabled = false;
  }
};

document.addEventListener('click', event => {
  const button = event.target.closest('.retro-fu-controls button');
  if (button) {
    button.closest('.retro-fu-frame')?.querySelector('elm-canvas.retro-fu')?.focus();
  }
});
